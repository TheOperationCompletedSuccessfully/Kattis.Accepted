readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(N,N,_).
readData(I,N,K):-II is I+1,readUInt(Next),assert(data(I,Next,K)),readData(II,N,K).

findAnswer(L,I):-msort(L,Sorted),Sorted = [_,Result|_],(I is 0,!,true;write(' ')),write(Result).

writeAnswer(N,N).
writeAnswer(I,N):-II is I+1,data(I,D0,0),data(I,D1,1),data(I,D2,2),findAnswer([D0,D1,D2],I),writeAnswer(II,N).

main:-readUInt(N),readData(0,N,0),readData(0,N,1),readData(0,N,2),writeAnswer(0,N).