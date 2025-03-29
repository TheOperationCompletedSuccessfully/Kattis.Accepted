:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

reverseCase([],Result,Result).
reverseCase([H|T],Current,Result):-H>=65,H=<90,!,NewH is H+32,append(Current,[NewH],NewC),reverseCase(T,NewC,Result).
reverseCase([H|T],Current,Result):-H>=97,H=<122,!,NewH is H-32,append(Current,[NewH],NewC),reverseCase(T,NewC,Result).
reverseCase([H|T],Current,Result):-append(Current,[H],NewC),reverseCase(T,NewC,Result).

valid(A,A).
valid(A,B):-A = [C|B],C >= 48,C=<57.
valid(A,B):-append(B,[C],A),C>=48,C=<57.
valid(A,B):-reverseCase(A,[],C),C=B.

readData(Current,Result):-at_end_of_stream,!,Result = Current.
readData(Current,Result):-get0(Ch),(Ch is 10,!,Result = Current;append(Current,[Ch],NewC),readData(NewC,Result)).

main:-initiateBufferedRead(256),readData([],S),readData([],P),(valid(S,P),!,bufferedWriteln('Yes');bufferedWriteln('No')).