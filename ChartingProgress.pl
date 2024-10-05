printRow(N,N,_).
printRow(I,C,Row):-I1 is I+1,CC is C-I-1,(data(_,CC,Row),!,write('*');write('.')),printRow(I1,C,Row).

printMatrix(N,N,_).
printMatrix(I,R,C):-I1 is I+1,printRow(0,C,I),nl,printMatrix(I1,R,C).

processRow(I,N,Row,Rows,_):-at_end_of_stream,!,N is I,Rows is Row.
processRow(I,N,Row,Rows,0):-get0(Ch),(Ch is 42,!,assert(data(Ch,I,Row)),I1 is I+1,processRow(I1,N,Row,Rows,0);Ch is 10,!,RR is Row +1,processRow(I,N,RR,Rows,1);processRow(I,N,Row,Rows,0)).
processRow(I,N,Row,Rows,1):-get0(Ch),(Ch is 42,!,assert(data(Ch,I,Row)),I1 is I+1,processRow(I1,N,Row,Rows,0);Ch is 10,!,N is I,Rows is Row;processRow(I,N,Row,Rows,0)).
processMatrix:-processRow(0,N,0,Rows,0),printMatrix(0,Rows,N),retractall(data(_,_,_)),(at_end_of_stream,!,true;nl,processMatrix).

main:-processMatrix.