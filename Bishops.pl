:-use_module(moduleMyNumbers, [readUIntSafe/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readPending:-at_end_of_stream,!,true.
readPending:-get0(Ch),(Ch is 10,!,true;readPending).

main:-at_end_of_stream,!,true.
main:-initiateBufferedRead(256),readUIntSafe(N),readPending,(N is 1,bufferedWriteln(1);Result is N + N - 2,bufferedWriteln(Result)),main.