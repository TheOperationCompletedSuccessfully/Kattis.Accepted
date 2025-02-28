:-use_module(moduleMyNumbers, [readUInt/1,readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

calcDistance(X1,Y1,X2,Y2,Result):-Result is sqrt((X1-X2)*(X1-X2)+(Y1-Y2)*(Y1-Y2)).

solve(_,_,_,_,_,_,3,F,_):-!,F is 3.
solve(N,N,_,_,Current,Result,CF,F,_):-!,F is CF,Result = Current.
solve(I,N,X,Y,Current,Result,CF,F,Max):-readInt(XX),readInt(YY),readUInt(Power),calcDistance(X,Y,XX,YY,Distance),DD is Distance-Power,(DD =<0,!,NewCF is CF+1;NewCF is CF),(I < 3,!,NewMax is max(Max,DD);NewMax is Max),(DD=<NewMax,!,append(Current,[DD],NewC);NewC=Current),I1 is I+1,solve(I1,N,X,Y,NewC,Result,NewCF,F,NewMax).

writeAnswer([_,_,Answer|_]):-A is truncate(Answer),bufferedWriteln(A).

main:-initiateBufferedRead(2048),readInt(MyX),readInt(MyY),readUInt(Devices),solve(0,Devices,MyX,MyY,[],Distances,0,FoundQuick,-1000),(FoundQuick is 3,!,bufferedWriteln(0);msort(Distances,Sorted),writeAnswer(Sorted)).

