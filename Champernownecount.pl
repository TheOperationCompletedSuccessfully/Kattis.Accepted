:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

l(100000,6).
l(K,R):-K<10,!,R is 1.
l(K,R):-K<100,!,R is 2.
l(K,R):-K<1000,!,R is 3.
l(K,R):-K<10000,!,R is 4.
l(_,R):-R is 5.

calc(N,N,_,_,Result,Result).
calc(I,N,V,K,Current,Result):-II is I+1,l(I,P),Next is V*(10^P)+I,R is Next rem K,(R is 0,!,NewC is Current+1;NewC is Current),calc(II,N,R,K,NewC,Result).

main:-initiateBufferedRead(256),readUInt(N),NN is N+1,readUInt(K),calc(1,NN,0,K,0,Result),bufferedWriteln(Result).