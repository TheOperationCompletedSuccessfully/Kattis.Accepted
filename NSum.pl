readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,Current,Result):-!,Result is Current.
solve(I,N,Current,Result):-I1 is I+1,readUInt(Next),NewC is Current + Next,solve(I1,N,NewC,Result).

main:-readUInt(N),solve(0,N,0,Result),writeln(Result).