:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic stack/2.

readData(N,N,Data,Data,Max,Max).
readData(I,N,Current,Data,CM,Max):-II is I+1,readUInt(Next),append(Current,[Next],NewC),NewCM is max(CM,Next),readData(II,N,NewC,Data,NewCM,Max).

fillData(N,N,Result,Result).
fillData(I,N,[H|T],Result):-II is I+1,Index is N-I-1,assert(stack(Index,H)),fillData(II,N,T,Result).

findAnswer(N,N,_,_,Answer,Answer).
findAnswer(I,N,End,[H|T],Current,Answer):-II is I+1,Index is I-End,(stack(Index,Value),!,NewC is max(Current,Value + H);NewC is max(Current,H)),findAnswer(II,N,End,T,NewC,Answer). 

main:-initiateBufferedRead(2048),readUInt(N),readUInt(M),readData(0,N,[],Data,0,Max),(M>=N,!,bufferedWriteln(Max);msort(Data,OrderedData),End is N-M,fillData(0,End,OrderedData,ResultData),findAnswer(0,M,0,ResultData,0,Answer),bufferedWriteln(Answer)).