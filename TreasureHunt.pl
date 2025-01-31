:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic visited/2.

move(_,Rows,Rows,_,_):-!,bufferedWriteln('Out').
move(_,_,_,Cols,Cols):-!,bufferedWriteln('Out').
move(_,-1,_,_,_):-!,bufferedWriteln('Out').
move(_,_,_,-1,_):-!,bufferedWriteln('Out').
move(_,Row,_,Col,_):-visited(Row,Col),!,bufferedWriteln('Lost').
move(Move,Row,_,Col,_):-data(Row,Col,84),!,bufferedWriteln(Move).
move(Move,Row,Rows,Col,Cols):-data(Row,Col,78),!,assert(visited(Row,Col)),NewMove is Move+1,NewRow is Row-1,move(NewMove,NewRow,Rows,Col,Cols).
move(Move,Row,Rows,Col,Cols):-data(Row,Col,83),!,assert(visited(Row,Col)),NewMove is Move+1,NewRow is Row+1,move(NewMove,NewRow,Rows,Col,Cols).
move(Move,Row,Rows,Col,Cols):-data(Row,Col,69),!,assert(visited(Row,Col)),NewMove is Move+1,NewCol is Col+1,move(NewMove,Row,Rows,NewCol,Cols).
move(Move,Row,Rows,Col,Cols):-data(Row,Col,87),!,assert(visited(Row,Col)),NewMove is Move+1,NewCol is Col-1,move(NewMove,Row,Rows,NewCol,Cols).

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readRow(N,N,_).
readRow(I,Cols,Row):-II is I+1,get0(Ch),assert(data(Row,I,Ch)),readRow(II,Cols,Row).

readData(N,N,_).
readData(Row,Rows,Columns):-II is Row+1,readRow(0,Columns,Row),readPending,readData(II,Rows,Columns).

main:-initiateBufferedRead(65536),readUInt(R),readUInt(C),readData(0,R,C),move(0,0,R,0,C).