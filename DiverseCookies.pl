readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solveInner([A,B],N,Total):-BA is B-A,(N>=BA,!,writeln(Total);Result is BA-N,!,R is Total - Result,writeln(R)).

solve([A,B,C],N,Total):- CA is C-A,solveInner([B,CA],N,Total).

main:-readUInt(N),readUInt(A),readUInt(B),readUInt(C),ABC is A+B+C,msort([A,B,C],Sorted),solve(Sorted,N,ABC).