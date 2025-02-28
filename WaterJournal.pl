:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

writeAnswer(N,N).
writeAnswer(I,N):-II is I+1,bufferedWriteln(I),writeAnswer(II,N).

readData(N,N).
readData(I,N):-II is I+1,readUInt(Next),assert(data(I,Next)),readData(II,N).

main:-initiateBufferedRead(512),readUInt(N),readUInt(A),readUInt(B),readData(1,N),BB is B+1,(data(_,A),data(_,B),!,writeAnswer(A,BB);data(_,A),not(data(_,B)),!,bufferedWriteln(B);data(_,B),not(data(_,A)),!,bufferedWriteln(A);bufferedWriteln(-1)).