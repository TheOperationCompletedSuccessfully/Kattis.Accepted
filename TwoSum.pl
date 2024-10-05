readUInt(Number):-readUInt(0,Number).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

main:-readUInt(A),readUInt(B),C is A + B, writeln(C).