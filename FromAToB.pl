readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,Current,Result):-!,Result is Current.
solve(I,N,Current,Result):-(I>N,R is I rem 2,R is 0,!,I1 is I/2,NewC is Current+1;I>N,!,I1 is I+1,NewC is Current+1;I1 is N,NewC is Current+N-I),solve(I1,N,NewC,Result).


main:-readUInt(A),readUInt(B),solve(A,B,0,Result),writeln(Result).