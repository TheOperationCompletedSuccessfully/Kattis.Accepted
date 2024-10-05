readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(N,N,Result,Result).
readData(I,N,Current,Result):-II is I+1,readUInt(Year),readUInt(A),readUInt(B),AB is A*B//gcd(A,B),R is Year+AB,NewC is min(Current,R),readData(II,N,NewC,Result).

main:-readUInt(K),readData(0,K,1000000000,Result),writeln(Result).