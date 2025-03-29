:-use_module(moduleMyNumbers, [readUInt/1,readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

printAnswer(N,N).
printAnswer(I,N):-II is I+1,bufferedWrite('0'),printAnswer(II,N).

main:-initiateBufferedRead(256),readUInt(N),bufferedWrite('0.'),printAnswer(1,N),bufferedWriteln('1').