readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solveInner(1,Current,Result):-!,Result is Current.
solveInner(Data,Current,Result):-D is Data rem 2,(D is 0,!,NewData is Data//2,NewC is Current + 1,solveInner(NewData,NewC,Result);Result is Current).

solve(_,_,N,N):-!,writeln(0).
solve(I,K,_,_):-I>=K,!,writeln(1).
solve(I,K,J,N):-J1 is J+1,readUInt(Next),solveInner(Next,0,Res),I1 is I+Res,solve(I1,K,J1,N).

main:-readUInt(N),readUInt(K),solve(0,K,0,N).