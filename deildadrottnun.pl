:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

writeAnswer(N,N,_).
writeAnswer(0,N,0):-!,bufferedWrite(2),writeAnswer(1,N,1).
writeAnswer(I,N,I):-!,II is I+1,III is II+1,bufferedWrite(' '),bufferedWrite(III),writeAnswer(II,N,II).
writeAnswer(0,N,J):-bufferedWrite(1),writeAnswer(1,N,J).
writeAnswer(I,N,J):-II is I+1,bufferedWrite(' '),bufferedWrite(II),writeAnswer(II,N,J).

main:-initiateBufferedRead(256),readUInt(N),NN is truncate((sqrt(8*N+1)-1)/2),Diff is N - NN*(NN+1)//2,Start is NN-Diff,bufferedWriteln(NN),writeAnswer(0,NN,Start).