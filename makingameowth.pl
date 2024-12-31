:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

main:-initiateBufferedRead(256),readUInt(N),readUInt(P),readUInt(X),readUInt(Y),YourTime is P*X,Reads1 is P//(N-1), HisTime is Reads1*Y,Result is YourTime + HisTime,bufferedWriteln(Result).