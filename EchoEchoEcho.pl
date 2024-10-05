readData(Current,Result):-at_end_of_stream,!,Result = Current.
readData(Current,Result):-get0(Ch),char_code(C,Ch),write(C),append(Current,[C],NewC),readData(NewC,Result).

writeData([]).
writeData([Head|Tail]):-write(Head),writeData(Tail).

main:-readData([],Result),write(' '),writeData(Result),write(' '),writeData(Result).