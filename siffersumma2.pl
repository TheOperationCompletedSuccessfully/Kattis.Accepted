:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

canRemove(1).
canRemove(2).
canRemove(3).
canRemove(4).
canRemove(5).
canRemove(6).
canRemove(7).
canRemove(8).
canRemove(9).

canAdd(0).
canAdd(1).
canAdd(2).
canAdd(3).
canAdd(4).
canAdd(5).
canAdd(6).
canAdd(7).
canAdd(8).

/*
idea 1 is to decrease and increase next cypher, done, however in order to minimize further
if we have added 1 at the start, we can reorder the rest in order sum = sum 00012399 etc
otherwise we can do the same starting from cypher #2, see tests
stuff([H|T],OutList):-
processChars(1,[],[H|T],Result):-!,stuff(T,Stuffed),append(Stuffed,[1,H],Result).

*/

sumList([],Result,Result).
sumList([H|T],Current,Result):-NewCurrent is Current+H,sumList(T,NewCurrent,Result).

stuff([],_,Current,Result):-reverse(Current,Result).
stuff([_|T],Sum,Current,Result):-ToDetract is max(0,min(9,Sum)),NewSum is Sum-ToDetract,append(Current,[ToDetract],NewCurrent),stuff(T,NewSum,NewCurrent,Result).

processChars(1,[],[H|T],Result):-!,sumList([H|T],0,Sum),stuff([H|T],Sum,[],Stuffed),append([1],Stuffed,Result).
processChars(1,[H|T],Current,Result):-Digit is H-48,(canAdd(Digit),!,NewDigit is Digit+1,append(Current,[NewDigit],NewCurrent),reverse(NewCurrent,FinalNewCurrent),reverse(T,TR),FinalNewCurrent=[A|Tail],sumList(Tail,0,Sum),stuff(Tail,Sum,[],Stuffed),append(TR,[A],FNC),append(FNC,Stuffed,Result);append(Current,[Digit],NewCurrent),processChars(1,T,NewCurrent,Result)).

processChars(0,[H|T],Current,Result):-Digit is H-48,(canRemove(Digit),!,NewDigit is Digit-1,append(Current,[NewDigit],NewCurrent),processChars(1,T,NewCurrent,Result);append(Current,[Digit],NewCurrent),processChars(0,T,NewCurrent,Result)).

printResult([]).
printResult([H|T]):-H>=48,!,Digit is H-48,bufferedWrite(Digit),printResult(T).
printResult([H|T]):-bufferedWrite(H),printResult(T).

main:-initiateBufferedRead(256),readUInt(N),number_to_chars(N,Chars),reverse(Chars,Reversed),processChars(0,Reversed,[],ReversedRawResult),printResult(ReversedRawResult).