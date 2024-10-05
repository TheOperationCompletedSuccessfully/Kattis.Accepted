readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

main:-readUInt(A),readUInt(B),readUInt(C),readUInt(D),G is gcd(C,D),NOK is C*D//G,BN is B//NOK,AN is A//NOK,R is A rem NOK,(R is 0,!,Result is BN-AN+1;Result is BN-AN),writeln(Result).