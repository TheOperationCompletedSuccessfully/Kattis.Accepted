:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readData(N,N,_,_,Result,Result).
readData(I,N,Total,M,Current,Result):-II is I+1,readUInt(Next),R is Next rem 2,(R is 0,!,NewTotal is Total +1;NewTotal is Total),assert(evens(I,NewTotal)),(II<M,!,readData(II,N,NewTotal,M,Current,Result);Index is I-M,(evens(Index,OldE);OldE is 0),TT is NewTotal-OldE,(TT>=2,!,NewC is Current+1;NewC is Current),readData(II,N,NewTotal,M,NewC,Result)).

main:-initiateBufferedRead(4096),readUInt(N),readUInt(M),readData(0,N,0,M,0,Result),bufferedWriteln(Result).