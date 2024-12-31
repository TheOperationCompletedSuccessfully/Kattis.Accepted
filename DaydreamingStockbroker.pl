:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readData(N,N).
readData(I,N):-II is I+1,readUInt(NextPrice),assert(data(I,NextPrice)),readData(II,N).

buy(N,N,Money,0,Money).
buy(N,N,_,Shares,_):-Shares>0,fail.
buy(I,N,Money,Shares,Result):-II is I+1,Prev is I-1,data(I,Price),(data(Prev,PrevPrice),!,(Price is PrevPrice,!,buy(II,N,Money,Shares,Result);Price>PrevPrice,!,NewShares is min(Money//PrevPrice,100000),NewMoney is Money - NewShares*PrevPrice,sell(I,N,NewMoney,NewShares,Result);buy(II,N,Money,Shares,Result));buy(II,N,Money,Shares,Result)).

sell(N,N,_,_,_):-fail.
sell(I,N,Money,Shares,Result):-II is I+1,data(I,Price),(data(II,NextPrice),!,(Price is NextPrice,!,sell(II,N,Money,Shares,Result);NextPrice>Price,!,sell(II,N,Money,Shares,Result);NewMoney is Money + Shares*Price,buy(II,N,NewMoney,0,Result));NewMoney is Money + Shares*Price,buy(II,N,NewMoney,0,Result)).

main:-initiateBufferedRead(2048),readUInt(D),readData(0,D),buy(0,D,100,0,Result),bufferedWriteln(Result).