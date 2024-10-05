readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

getData(N,N,_).
getData(I,N,Result):-II is I+1,readUInt(New),NewResult is New + Result),getData(II,N).

main:-readUInt(N),readUInt(X),getData(0,N,Sum),(Sum>X,!,writeln('Neibb');writeln('Jebb')).