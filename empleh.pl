:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic data/4.

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

mapData(319,'K',1).
mapData(320,'K',2).
mapData(321,'K',3).
mapData(322,'K',4).
mapData(323,'K',5).
mapData(324,'K',6).
mapData(325,'K',7).
mapData(326,'K',8).

mapData(379,'Q',1).
mapData(380,'Q',2).
mapData(381,'Q',3).
mapData(382,'Q',4).
mapData(383,'Q',5).
mapData(384,'Q',6).
mapData(385,'Q',7).
mapData(386,'Q',8).

mapData(389,'R',1).
mapData(390,'R',2).
mapData(391,'R',3).
mapData(392,'R',4).
mapData(393,'R',5).
mapData(394,'R',6).
mapData(395,'R',7).
mapData(396,'R',8).

mapData(229,'B',1).
mapData(230,'B',2).
mapData(231,'B',3).
mapData(232,'B',4).
mapData(233,'B',5).
mapData(234,'B',6).
mapData(235,'B',7).
mapData(236,'B',8).

mapData(349,'N',1).
mapData(350,'N',2).
mapData(351,'N',3).
mapData(352,'N',4).
mapData(353,'N',5).
mapData(354,'N',6).
mapData(355,'N',7).
mapData(356,'N',8).

cellTiling(1,'.').
cellTiling(2,':').

mapData(N,Figure,Row,Col,Sign):-N>=491,N=<568,!,Row is N rem 10,C is 48+N//10,char_code(H,C),column(H,Col),(Sign is 0,!,Figure = 'P';Figure = 'p').


printCell(WB,Row,Col):-cellTiling(WB,Ch),bufferedWrite('|'),bufferedWrite(Ch),(data(Color,Figure,Row,Col),!,(Color is 0,!,F = Figure;downcase_atom(Figure,F)),bufferedWrite(F);bufferedWrite(Ch)),bufferedWrite(Ch).

isBlackLine(2454700).
isWhiteLine(4524340).

/*
readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-at_end_of_stream,!,R is -1.
readUInt(I,R):-at_end_of_stream,!,R is I.
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).
*/

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readData(_):-at_end_of_stream,!,true.
readData(_):-peek_code(Ch),Ch < 44,!,readPending.
readData(I):-readUInt(Next),(isBlackLine(Next),!,readData(1);isWhiteLine(Next),!,readData(0);NN is Next//10,mapData(NN,Figure,Col),Row is Next rem 10,assert(data(I,Figure,Row,Col));mapData(Next,Figure,Row,Col,I),assert(data(I,Figure,Row,Col));true),readData(I).

logData:-findall([I,F,Row,Col],data(I,F,Row,Col),L),writeln(L).

writeRow(N,N,_).
writeRow(I,N,Row):-R is Row rem 2,(R is 1,!,bufferedWriteln('+---+---+---+---+---+---+---+---+');II is I+1,RR is 9-Row//2,WB is 2 - (RR+II) rem 2,printCell(WB,RR,II),writeRow(II,N,Row)).

writeTable(N,N,_).
writeTable(I,N,Cols):-II is I+1,writeRow(0,Cols,II),R is I rem 2,(R is 1,!,bufferedWriteln('|');true),writeTable(II,N,Cols).
main:-initiateBufferedRead(1024),readData(0),readData(1),writeTable(0,17,8).