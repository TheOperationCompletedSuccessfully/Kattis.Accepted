:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readData(Current,Result):-at_end_of_stream,!,Result = Current.
readData(Current,Result):-get0(Ch),(Ch is 10,!,Result = Current;append(Current,[Ch],NewC),readData(NewC,Result)).

writeItem([]).
writeItem([Head|Tail]):-char_code(Ch,Head),bufferedWrite(Ch),writeItem(Tail).

writeSong(1,_,Item):-!,bufferedWrite('1 bottle of '),writeItem(Item),bufferedWrite(' on the wall, 1 bottle of '),writeItem(Item),bufferedWriteln('.'),bufferedWrite('Take it down, pass it around, no more bottles of '),writeItem(Item),bufferedWriteln('.').
writeSong(11,_,Item):-!,bufferedWrite('11 bottles of '),writeItem(Item),bufferedWrite(' on the wall, 11 bottles of '),writeItem(Item),bufferedWriteln('.'),bufferedWrite('Take one down, pass it around, 10 bottles of '),writeItem(Item),bufferedWriteln(' on the wall.'),bufferedWriteln('').
writeSong(X,2,Item):-!,XX is X-1,bufferedWrite(X),bufferedWrite(' bottles of '),writeItem(Item),bufferedWrite(' on the wall, '),bufferedWrite(X),bufferedWrite(' bottles of '),writeItem(Item),bufferedWriteln('.'),bufferedWrite('Take one down, pass it around, '),bufferedWrite(XX),(XX > 1,!,bufferedWrite(' bottles of ');bufferedWrite(' bottle of ')),writeItem(Item),bufferedWriteln(' on the wall.'),bufferedWriteln('').
writeSong(X,_,Item):-XX is X-1,bufferedWrite(X),bufferedWrite(' bottles of '),writeItem(Item),bufferedWrite(' on the wall, '),bufferedWrite(X),bufferedWrite(' bottles of '),writeItem(Item),bufferedWriteln('.'),bufferedWrite('Take one down, pass it around, '),bufferedWrite(XX),bufferedWrite(' bottles of '),writeItem(Item),bufferedWriteln(' on the wall.'),bufferedWriteln('').

solve(N,N,_).
solve(I,N,Item):-NN is N-I,I1 is I+1,D is NN rem 10,writeSong(NN,D,Item),solve(I1,N,Item).

main:-initiateBufferedRead(256),readUInt(N),readData([],Item),solve(0,N,Item).