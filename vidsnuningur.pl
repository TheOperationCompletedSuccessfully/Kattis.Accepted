:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

printData([]).
printData([H|T]):-char_code(Ch,H),bufferedWrite(Ch),printData(T).

readData(Data):-at_end_of_stream,!,printData(Data).
readData(Data):-get0(Ch),append([Ch],Data,NewData),readData(NewData).

main:-initiateBufferedRead(1024),readData([]).