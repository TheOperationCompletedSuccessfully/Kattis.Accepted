:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

main:-initiateBufferedRead(256),readUInt(A),readUInt(B),C is A-B,bufferedWriteln(C).