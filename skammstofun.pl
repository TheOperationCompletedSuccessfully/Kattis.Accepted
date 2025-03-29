:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readData(_,_,_):-at_end_of_stream,!,true.
readData(Current,Result,0):-get0(Ch),(Ch is 10,!,Result = Current;Ch < 91,!,append(Current,[Ch],NewC),readData(NewC,Result,1);readData(Current,Result,1)).
readData(Current,Result,1):-get0(Ch),(Ch is 10,!,Result = Current;Ch is 32,!,readData(Current,Result,0);readData(Current,Result,1)).

writeList([]):-!,nl.
writeList([H|T]):-char_code(Ch,H),bufferedWrite(Ch),writeList(T).

main:-initiateBufferedRead(16384),readUInt(_),readData([],Result,0),writeList(Result).