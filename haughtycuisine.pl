:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readItem(Current,Result):-get0(Ch),(Ch <65,!,Result = Current;append(Current,[Ch],NewC),readItem(NewC,Result)).

readData(N,N,Data,Data).
readData(I,N,Current,Result):-II is I+1,readItem([],Next),append(Current,[Next],NewC),readData(II,N,NewC,Result).

recommendItem([]).
recommendItem([H|T]):-char_code(Ch,H),bufferedWrite(Ch),recommendItem(T).

recommend([]).
recommend([H|T]):-recommendItem(H),nl,recommend(T).

main:-initiateBufferedRead(65536),readUInt(_),readUInt(R),readData(0,R,[],Data),bufferedWriteln(R),recommend(Data).