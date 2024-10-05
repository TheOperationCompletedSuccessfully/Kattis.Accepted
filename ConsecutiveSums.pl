readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

writeAnswers(N,N,_,_):-!,nl.
writeAnswers(_,-1,-1,_):-!,bufferedWriteln('IMPOSSIBLE').
writeAnswers(0,AnswerN,AnswerA,Next):-bufferedWrite(Next),bufferedWrite(' = '),bufferedWrite(AnswerA),writeAnswers(1,AnswerN,AnswerA,Next).
writeAnswers(I,AnswerN,AnswerA,Next):-I1 is I+1,GG is AnswerA+I,bufferedWrite(' + '),bufferedWrite(GG),writeAnswers(I1,AnswerN,AnswerA,Next).

findSolution(NN,NN,_,AnswerN,AnswerA):-!,AnswerN is -1,AnswerA is -1.
findSolution(I,NN,Next,AnswerN,AnswerA):-I1 is I+1,CandidateA is Next*1.0/I - (I-1)/2,A is integer(CandidateA),(abs(CandidateA-A)<0.000001,!,AnswerA is A,AnswerN is I;findSolution(I1,NN,Next,AnswerN,AnswerA)).

solve(N,N).
solve(I,N):-I1 is I+1,readUInt(Next),K is Next rem 2,(Next is 1,!,bufferedWriteln('IMPOSSIBLE');K is 1,!,S is Next//2,SS is S+1,bufferedWrite(Next),bufferedWrite(' = '),bufferedWrite(S),bufferedWrite(' + '),bufferedWriteln(SS);known(Next,AnswerN,AnswerA),!,writeAnswers(0,AnswerN,AnswerA,Next);NN is integer(sqrt(1+8*Next)),findSolution(3,NN,Next,AnswerN,AnswerA),assert(known(Next,AnswerN,AnswerA)),writeAnswers(0,AnswerN,AnswerA,Next)),solve(I1,N).

bufferedWrite(C):-with_output_to(user_output,write(C)).
bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(N),assert(known(-1,-1,-1)),solve(0,N).