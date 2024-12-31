:-use_module(moduleMyNumbers, [readUInt/1,readUIntSafe/1,readUFloat/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

calcLevel(N,N,Level,Current,Result):-(level(Level,45),!,Result is Current;Result is 1/Current),retractall(level(Level,_)),retractall(data(_,Level,_)).
calcLevel(I,N,Level,Current,Result):-II is I+1,data(I,Level,Value),(level(Level,45),!,NewC is Current+Value;NewC is Current+ 1/Value),calcLevel(II,N,Level,NewC,Result).

prepareLevel(I,_,Result):-at_end_of_stream,!,Result is I.
prepareLevel(I,Level,Result):-get0(Ch),(Ch < 40,!,Result is I;Ch is 40,!,NextLevel is Level+1,prepareLevel(0,NextLevel,Len),calcLevel(0,Len,NextLevel,0,NextLevelResult),assert(data(I,Level,NextLevelResult)),II is I+1,prepareLevel(II,Level,Result);Ch is 41,!,Result is I;Ch is 45,!,assert(level(Level,45)),prepareLevel(I,Level,Result);Ch is 124,!,assert(level(Level,124)),prepareLevel(I,Level,Result);Ch is 82,!,readUIntSafe(Index),resistor(Index,Value),assert(data(I,Level,Value)),II is I+1,prepareLevel(II,Level,Result)).

readResistors(N,N).
readResistors(I,N):-II is I+1,readUFloat(Next),assert(resistor(II,Next)),readResistors(II,N).

main:-initiateBufferedRead(131072),readUInt(N),readResistors(0,N),prepareLevel(0,0,Len),assert(level(0,45)),calcLevel(0,Len,0,0,Result),bufferedWriteln(Result).