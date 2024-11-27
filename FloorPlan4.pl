:-use_module(moduleMyNumbers, [readUInt/1,readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

/*
idea is 
if N is 2*n+1, then it is always possible, (n+1)^2 - n^2
if N is 2*n, = 4m^2 -4k^2, e.g. it should be divisible on 4

counter example 8088 = 1013*1013-1009*1009

*/

writeSolution(A,B):-(A>=0,!,bufferedWrite(A),bufferedWrite(' '),bufferedWriteln(B);bufferedWriteln('impossible')).

probeNext(I,N,A,B):-I>N,!,A is -1,B is -1.
probeNext(I,N,A,B):-III is I+2,II is I*I,Sum is II+N,T is floor(sqrt(Sum)),(Sum is T*T,!,A is T,B is I;probeNext(III,N,A,B)).

findSolution(2,A,B):-!,A is -1,B is -1.
findSolution(K,A,B):-(1 is K rem 2,!,B is (K-1)//2, A is B+1;0 is K rem 4,!,KK is K//4,findSolution(KK,NewA,NewB),(NewA>0,!,A is 2*NewA,B is 2*NewB;probeNext(3,K,A,B));findSolution(2,A,B)).
main:-initiateBufferedRead(256),readUInt(N),K is floor(sqrt(N)),(N is 1,!,writeSolution(1,0);N is K*K,!,writeSolution(K,0);1 is N rem 2,!,B is (N-1)//2, A is B+1,writeSolution(A,B);findSolution(N,A,B),!,writeSolution(A,B)).