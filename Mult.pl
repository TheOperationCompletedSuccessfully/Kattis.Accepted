readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

mult(N,N,_).
mult(I,N,M):-I1 is I+1,readUInt(Next),R is Next rem M,(R is 0,!,writeln(Next),(I1 is N,!,mult(N,N,M);readUInt(NN),I2 is I1 +1,mult(I2,N,NN);mult(I1,N,M));mult(I1,N,M)).

main:-readUInt(N),readUInt(M),mult(1,N,M).