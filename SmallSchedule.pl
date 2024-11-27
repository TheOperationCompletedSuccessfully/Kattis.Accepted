:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

main:-initiateBufferedRead(256),readUInt(Q),readUInt(M),readUInt(S),readUInt(L),(L is 0,!,Result is ceil(S/M);LongBatchesPerMachine is ceil(L/M),RemainderTime is LongBatchesPerMachine*M*Q-Q*L,(S=<RemainderTime,!,Result is LongBatchesPerMachine*Q;Result is LongBatchesPerMachine*Q + ceil((S - RemainderTime)/M))),bufferedWriteln(Result).