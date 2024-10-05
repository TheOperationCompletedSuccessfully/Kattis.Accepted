readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

hailstone(I,1,Result):-!,Result is I+1.
hailstone(I,N,Result):- C is N rem 2,I1 is I+1,(C is 0,!,D is N//2;D is 3*N+1),hailstone(I1,D,Result).

main:-readUInt(N),hailstone(0,N,Result),writeln(Result).