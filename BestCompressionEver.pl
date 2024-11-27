:-use_module(moduleMyNumbers, [readUInt/1,readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).


main:-initiateBufferedRead(256),readUInt(N),readUInt(B),Total is 2^(B+1),(N<Total,!,bufferedWriteln('yes');bufferedWriteln('no')).