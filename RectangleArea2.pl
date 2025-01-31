:-use_module(moduleMyNumbers, [readUInt/1,readFloat/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

main:-initiateBufferedRead(256),readFloat(X1),readFloat(Y1),readFloat(X2),readFloat(Y2),Result is abs(X1-X2)*abs(Y1-Y2),bufferedWriteln(Result).