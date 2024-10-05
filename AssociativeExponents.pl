readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).


solve(1,_,_).
solve(_,_,1).
solve(_,B,C):-C is B^C-B.

main:-readUInt(A),readUInt(B),readUInt(C),(solve(A,B,C),!,writeln('What an excellent example!');writeln('Oh look, a squirrel!')).