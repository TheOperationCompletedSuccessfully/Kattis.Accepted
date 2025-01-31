:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic white/4.
:-dynamic black/4.

getFigure('K',1).
getFigure('Q',2).
getFigure('R',3).
getFigure('B',4).
getFigure('N',5).
getFigure('P',6).
getFigure('k',1).
getFigure('q',2).
getFigure('r',3).
getFigure('b',4).
getFigure('n',5).
getFigure('p',6).

column('a',1).
column('b',2).
column('c',3).
column('d',4).
column('e',5).
column('f',6).
column('g',7).
column('h',8).

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

getRowForIndex(1,Row,Row).
getRowForIndex(2,Row,Result):-Result is 8-Row.

priority(WB,C,Row,Column,Result):-getFigure(C,CP),getRowForIndex(WB,Row,RR),Result is 1000*WB+100*CP+10*RR+Column.

readCols(N,N,_).
readCols(I,N,Row):-II is I+1,get0(Ch),(Ch>65,Ch<83,!,RR is 9-Row//2,Col is 1+I//4,char_code(C,Ch),priority(1,C,RR,Col,Index),assert(white(Index,RR,Col,C));Ch>97,Ch<115,!,RR is 9-Row//2,Col is 1+I//4,H is Ch-32,char_code(C,H),priority(2,C,RR,Col,Index),assert(black(Index,RR,Col,C));true),readCols(II,N,Row).

readRows(N,N,_).
readRows(I,N,Cols):-II is I+1,readCols(0,Cols,II),readPending,readRows(II,N,Cols).



printItem([_,Row,Col,'P']):-!,column(ColName,Col),bufferedWrite(ColName),bufferedWrite(Row).
printItem([_,Row,Col,'p']):-!,column(ColName,Col),bufferedWrite(ColName),bufferedWrite(Row).
printItem([_,Row,Col,Name]):-bufferedWrite(Name),column(ColName,Col),bufferedWrite(ColName),bufferedWrite(Row).

printList([]).
printList([H]):-!,printItem(H).
printList([H|T]):-printItem(H),bufferedWrite(','),printList(T).

findSolution:-findall([Index,RR,Col,C],white(Index,RR,Col,C),WhiteList),msort(WhiteList,WL),bufferedWrite('White: '),printList(WL),nl,findall([Index,RR,Col,C],black(Index,RR,Col,C),BlackList),msort(BlackList,BL),bufferedWrite('Black: '),printList(BL),nl.

main:-initiateBufferedRead(1024),readRows(0,17,33),findSolution.