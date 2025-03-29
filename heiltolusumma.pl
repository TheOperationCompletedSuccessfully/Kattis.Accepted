:-use_module(moduleMyNumbers, [readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

main:-initiateBufferedRead(256),readInt(N),(N is 0,!,Result is 1;N+1 < 0,!,Result is ((N-2)*(abs(N)-1)//2);Result is abs(N)*(N+1)//2),bufferedWriteln(Result).