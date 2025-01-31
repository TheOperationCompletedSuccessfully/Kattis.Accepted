:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

writeRow(N,N):-!,nl.
writeRow(I,N):-II is I+1,bufferedWrite('*'),writeRow(II,N).

writeAnswer(N,N,_,_).
writeAnswer(I,N,M,0):-!,II is I+1,writeRow(0,M),writeAnswer(II,N,M,0).
writeAnswer(I,N,M,Rem):-II is I+1,MM is M+1,NewRem is Rem-1,writeRow(0,MM),writeAnswer(II,N,M,NewRem).

main:-initiateBufferedRead(256),readUInt(N),readUInt(M),Rem is M rem N,NN is M//N,writeAnswer(0,N,NN,Rem).