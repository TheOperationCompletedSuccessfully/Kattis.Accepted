:-use_module(moduleMyNumbers, [readUInt/1,readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

splitOnPrimes(N,N,_,Result,Result).
splitOnPrimes(I,N,Main,Current,Result):-II is I+1,R is Main rem I,(R is 0,!,Cand is Main//I,append(Current,[[I,Cand]],NewCurrent);NewCurrent = Current),splitOnPrimes(II,N,Main,NewCurrent,Result).

checkResults([]):-!,bufferedWriteln('impossible').
checkResults([[A,B]|T]):-X is (A+B)/2,Y is (max(A,B)-min(A,B))/2,XX is X-truncate(X),YY is Y-truncate(Y),(XX is 0,YY is 0,X>0,Y>0,Max is max(X,Y),Min is min(X,Y),bufferedWrite(Min),bufferedWrite(' '),bufferedWriteln(Max);checkResults(T)).

main:-initiateBufferedRead(256),readUInt(D),DD is truncate(sqrt(D)),(D is DD*DD,!,bufferedWrite('0 '),bufferedWriteln(DD);DDD is DD+1,splitOnPrimes(1,DDD,D,[],Primes),checkResults(Primes)).