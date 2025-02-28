:-use_module(moduleMyNumbers, [readFloat/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

main:-initiateBufferedRead(256),readFloat(N),NN is 1/N,Answer is N^NN,bufferedWriteln(Answer).
