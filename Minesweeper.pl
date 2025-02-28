:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readData(N,N).
readData(I,N):-II is I+1,readUInt(Row),readUInt(Column),R is Row-1,C is Column-1,assert(mine(R,C)),readData(II,N).

printRow(N,N,_).
printRow(I,N,Row):-II is I+1,(mine(Row,I),!,bufferedWrite('*');bufferedWrite('.')),printRow(II,N,Row).

printAnswer(N,N,_).
printAnswer(I,N,Cols):-II is I+1,printRow(0,Cols,I),nl,printAnswer(II,N,Cols).

main:-initiateBufferedRead(65536),readUInt(Rows),readUInt(Columns),readUInt(Mines),readData(0,Mines),printAnswer(0,Rows,Columns).