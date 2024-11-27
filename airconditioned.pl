:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readMinions(N,N,Min,Min,Max,Max).
readMinions(I,N,CMin,Min,CMax,Max):-II is I+1,readUInt(NextFrom),readUInt(NextTo),NewCMin is min(CMin,NextFrom),NewCMax is max(CMax,NextTo),assert(start(I,NextFrom)),assert(end(I,NextTo)),readMinions(II,N,NewCMin,Min,NewCMax,Max).

processStarted([]).
processStarted([H|T]):-assert(started(H)),processStarted(T).

processData(N,N,Result,Result).
processData(I,N,Current,Result):-II is I+1,findall(J,start(J,I),LStart),processStarted(LStart),(end(K,I),started(K),!,retractall(started(_)),NewCurrent is Current+1;NewCurrent is Current),processData(II,N,NewCurrent,Result).

main:-initiateBufferedRead(1024),readUInt(N),NN is 2*N,readMinions(0,N,NN,Min,0,Max),MMax is Max+1,processData(Min,MMax,0,Result),bufferedWriteln(Result).