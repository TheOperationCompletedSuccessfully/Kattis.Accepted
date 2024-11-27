:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

writeAnswer(N,N).
writeAnswer(0,N):-bufferedWrite(1),writeAnswer(1,N).
writeAnswer(I,N):-II is I+1,Answer is 2^I,bufferedWrite(' '),bufferedWrite(Answer),writeAnswer(II,N).

main:-readUInt(N),M is log10(N)/log10(2),K is truncate(M),KK is K+1,bufferedWriteln(KK),writeAnswer(0,KK),nl.