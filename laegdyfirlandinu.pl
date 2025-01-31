:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic data/3.

readRow(N,N,_).
readRow(I,N,Row):-II is I+1,readUInt(Next),assert(data(Row,I,Next)),readRow(II,N,Row).

readData(N,N,_).
readData(I,N,Cols):-II is I+1,readRow(0,Cols,I),readData(II,N,Cols).

checkData(Col,Row,Answer):-CC1 is Col-1,RR1 is Row-1,CC2 is Col+1,RR2 is Row+1,data(Row,Col,D),data(RR1,Col,D1),data(RR2,Col,D2),data(Row,CC1,D3),data(Row,CC2,D4),(D <D1,D <D2,D <D3,D <D4,!,Answer is 1;Answer is 0).

checkRow(N,N,_,_,0).
checkRow(I,N,Row,0,Answer):-II is I+1,checkData(I,Row,AA),(AA is 1,!,Answer is 1;checkRow(II,N,Row,0,Answer)).

findAnswer(N,N,_):-!,bufferedWriteln('Neibb').
findAnswer(I,N,Cols):-II is I+1,checkRow(1,Cols,I,0,Answer),(Answer is 1,!,bufferedWriteln('Jebb');findAnswer(II,N,Cols)).

main:-initiateBufferedRead(32768),readUInt(Rows),readUInt(Cols),readData(0,Rows,Cols),RR is Rows-1,CC is Cols-1,findAnswer(1,RR,CC).