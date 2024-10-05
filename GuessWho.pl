readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readColumns(N,N,_):-!,true.
readColumns(I,N,Row):-II is I+1,get0(Next),assert(data(Row,II,Next)),readColumns(II,N,Row).

readLines(N,N,_).
readLines(I,N,M):-II is I+1,readColumns(0,M,II),readPending,readLines(II,N,M).

readQuestions(N,N).
readQuestions(I,N):-II is I+1,readUInt(QN),get0(Ch),readPending,assert(q(II,QN,Ch)),readQuestions(II,N).

test(_,_,M,M).
test(N,N,CR,Max):-assert(answer(CR)),NewCR is CR +1,test(0,N,NewCR,Max).
test(I,N,Row,Max):-II is I+1,(data(Row,B,D),q(II,B,D),!,test(II,N,Row,Max);NewRow is Row+1,test(0,N,NewRow,Max)).

test(N,N,_):-!,true.
test(I,N,Row):-II is I+1,data(Row,B,D),q(II,B,D),test(II,N,Row).

writeTest:-findall([A,B,C],data(A,B,C),RR),writeln(RR),findall([F,D,E],q(F,D,E),TT),writeln(TT).

bufferedWriteln(C):-with_output_to(user_output,writeln(C)).
/*
main:-readUInt(N),readUInt(M),readUInt(Q),readLines(0,N,M),readQuestions(0,Q),NN is N+1,test(0,Q,0,NN),findall(Row,answer(Row),Raw),sort(Raw,L),length(L,LL),(LL is 1,!,writeln('unique'),L =[A],writeln(A);writeln('ambiguous'),writeln(LL)).
*/
main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(N),readUInt(M),readUInt(Q),readLines(0,N,M),readQuestions(0,Q),findall(Row,test(0,Q,Row),Raw),sort(Raw,L),length(L,LL),(LL is 1,!,bufferedWriteln('unique'),L =[A],bufferedWriteln(A);bufferedWriteln('ambiguous'),bufferedWriteln(LL)).
