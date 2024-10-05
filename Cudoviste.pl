readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

getValue(35,-10).
getValue(46,0).
getValue(88,1).

readPending:-at_end_of_stream,!,true.
readPending:-get0(Ch),(Ch is 10,!,true;readPending).

writeAnswers(N,N).
writeAnswers(I,N):-I1 is I+1,(answer(I,Answer),!,true;Answer is 0),writeln(Answer),writeAnswers(I1,N).

getRowAnswers(N,N,_).
getRowAnswers(I,N,Row):-I1 is I+1,RR is Row+1,field(AA,I,Row),field(AB,I1,Row),field(BA,I,RR),field(BB,I1,RR),getValue(AA,AAV),getValue(AB,ABV),getValue(BA,BAV),getValue(BB,BBV),Result is AAV+ABV+BAV+BBV,(answer(Result,Answer),!,retract(answer(Result,Answer)),NewAnswer is Answer+1,assert(answer(Result,NewAnswer));assert(answer(Result,1))),getRowAnswers(I1,N,Row).

getAnswers(N,N,_).
getAnswers(I,N,C):-I1 is I+1,getRowAnswers(0,C,I),getAnswers(I1,N,C).

readRow(N,N,_).
readRow(I,N,Row):-I1 is I+1,get0(Ch),assert(field(Ch,I,Row)),readRow(I1,N,Row).

readMatrix(N,N,_).
readMatrix(I,N,C):-I1 is I+1,readRow(0,C,I),readPending,readMatrix(I1,N,C).

main:-readUInt(R),readUInt(C),assert(field(-1,-1,-1)),assert(answer(-50,-50)),readMatrix(0,R,C),RR is R-1,CC is C-1,getAnswers(0,RR,CC),writeAnswers(0,5).

