readInt(Number):-readInt(-1,Number).
readInt(-1,R):-!,get0(Ch),(Ch is 45,!,readInt(0,R1),R is -1*R1;Ch <48,!,readInt(-1,R);I1 is Ch-48,readInt(I1,R)).
readInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readInt(I1,R)).

main:-readInt(A),readInt(B),readInt(C),(C is A+B,!,writeln('correct!');writeln('wrong!')).