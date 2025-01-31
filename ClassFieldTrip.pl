:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readData(Current,Result):-at_end_of_stream,!,Result = Current.
readData(Current,Result):-get0(Ch),(Ch is 10,!,Result = Current;append(Current,[Ch],NewC),readData(NewC,Result)).

printData([]).
printData([H|T]):-char_code(Ch,H),bufferedWrite(Ch),printData(T).

writeData([],List):-!,printData(List).
writeData(List,[]):-!,printData(List).
writeData([A|T1],[A|T2]):-char_code(Ch,A),bufferedWrite(Ch),bufferedWrite(Ch),writeData(T1,T2).
writeData([A|T1],[B|T2]):-(A<B,!,char_code(C,A),bufferedWrite(C),writeData(T1,[B|T2]);char_code(Ch,B),bufferedWrite(Ch),writeData([A|T1],T2)).

main:-initiateBufferedRead(256),readData([],Ann),readData([],Benn),writeData(Ann,Benn).