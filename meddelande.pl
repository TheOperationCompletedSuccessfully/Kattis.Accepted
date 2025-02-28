:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readRow(N,N,_).
readRow(I,N,Row):-II is I+1,get0(Ch),(Ch is 46,!,true;Sum is I+Row,assert(data(Sum,Ch))),readRow(II,N,Row).

readData(N,N,_).
readData(I,N,Cols):-II is I+1,readRow(0,Cols,I),readPending,readData(II,N,Cols).

printAnswer([]).
printAnswer([H|T]):-H=[_,C],char_code(Ch,C),bufferedWrite(Ch),printAnswer(T).

main:-initiateBufferedRead(256),readUInt(Rows),readUInt(Cols),readData(0,Rows,Cols),findall([Index,D],data(Index,D),L),msort(L,LSorted),printAnswer(LSorted),nl.