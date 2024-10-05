readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(N,N).
readData(I,N):-I1 is I+1,readUInt(Next),assert(data(Next,I)),readData(I1,N).

writeAnswers(N,N).
writeAnswers(I,N):-I1 is I+1,NN is N-I1,data(D,NN),writeln(D),writeAnswers(I1,N).

main:-readUInt(N),readData(0,N),writeAnswers(0,N).