:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

/*
solve(0,_,Result,Result).
solve(I,N,Counter,Result):-II is I-1, NewCounter is Counter+1,NN is N+1, R is NN rem I, (R is 0,!,solve(0,N,NewCounter,Result);solve(II,N,NewCounter,Result)).

main:-readUInt(N),NN is N-1,solve(NN,NN,0,Result),bufferedWriteln(Result).
*/

findGcd(NN,NN,1).
findGcd(I,N,Result):-I*I>N,!,Result is 1.
findGcd(I,N,Result):-S is gcd(I,N),(S>1,!,Result is S;II is I+2,findGcd(II,N,Result)).

main:-initiateBufferedRead(256),readUInt(N),(N is 1,!,bufferedWriteln(0);(A is gcd(2,N),A>1,!,GCD is A;findGcd(3,N,GCD)),(GCD>1,!,Result is N-N//GCD;Result is N-1),bufferedWriteln(Result)).
