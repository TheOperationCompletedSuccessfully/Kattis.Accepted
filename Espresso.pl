readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;Ch is 76,!,R is I+1;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,_,_,Result,Result).
solve(I,N,CS,S,Current,Result):-II is I+1,readUInt(Next),(CS<Next,!,NewCS is S-Next,NewC is Current+1;NewCS is CS-Next,NewC is Current),solve(II,N,NewCS,S,NewC,Result).

main:-readUInt(N),readUInt(S),solve(0,N,S,S,0,Result),writeln(Result).