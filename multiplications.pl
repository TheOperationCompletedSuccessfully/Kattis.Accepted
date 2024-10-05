:-use_module(moduleMyNumbers, [readUInt/1,readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

solve(N,N,Result):-!,bufferedWriteln(Result).
solve(I,N,Current):-II is I+1,readInt(Next),NNext is Next rem 1000000007,NewC is (NNext*Current) rem 1000000007,solve(II,N,NewC).

main:-initiateBufferedRead(256),readUInt(N),solve(0,N,1).