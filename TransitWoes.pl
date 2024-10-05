:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readDData(N,N).
readDData(I,N):-II is I+1, readUInt(Next), assert(ddata(I,Next)),readDData(II,N).

readBData(N,N).
readBData(I,N):-II is I+1, readUInt(Next), assert(bdata(I,Next)), readBData(II,N).

readCData(N,N).
readCData(I,N):-II is I+1, readUInt(Next), assert(cdata(I,Next)), readCData(II,N).

solve(N,N,Current,Max):-!,ddata(N,DI),NewC is Current + DI,(NewC>Max,!,bufferedWriteln('no');bufferedWriteln('yes')).
solve(I,N,Current,Max):-II is I+1,ddata(I,DI),bdata(I,BI),cdata(I,CI),CC is (Current+DI) rem CI,(CC is 0,!,ToWait is 0;ToWait is CI-CC),TotalTime is DI + BI + ToWait,NewC is Current + TotalTime,(NewC > Max,!,bufferedWriteln('no');solve(II,N,NewC,Max)).

main:-initiateBufferedRead(16384),readUInt(S),readUInt(T),readUInt(N),NN is N+1,readDData(0,NN),readBData(0,N),readCData(0,N),solve(0,N,S,T).