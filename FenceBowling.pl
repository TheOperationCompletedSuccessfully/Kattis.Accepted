:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

calcSum(N,N,Result,Result).
calcSum(I,N,Current,Result):-II is I+1,Next is 2**I + 2**II,NewC is Current+Next,calcSum(II,N,NewC,Result).

main:-initiateBufferedRead(256),readUInt(K),readUInt(W),readUInt(L),calcSum(0,K,0,Sum),Tan is (2*L/(Sum*W)),Result is 180*atan(Tan)/pi,bufferedWriteln(Result).