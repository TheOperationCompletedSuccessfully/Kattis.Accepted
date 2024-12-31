:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

solve(N,N,Limit,Number,Current,Result):-!,K is Number rem N,(K is 0,L is Number/N,L=<Limit,!,Result is Current+1;Result is Current).
solve(I,N,Limit,Number,Current,Result):-II is I+1,K is Number rem I,(K is 0,L is Number/I,L=<Limit,!,NewC is Current+1;NewC is Current),solve(II,N,Limit,Number,NewC,Result).

main:-initiateBufferedRead(256),readUInt(M),readUInt(N),S is truncate(sqrt(N)),solve(1,S,M,N,0,Result),(N is S*S,!,FinalResult is 2*Result - 1;FinalResult is 2*Result),bufferedWriteln(FinalResult).