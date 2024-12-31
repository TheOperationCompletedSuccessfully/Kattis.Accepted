:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic answer/2.
:-dynamic message/2.

readData(I,N):-at_end_of_stream,!,N is I.
readData(I,N):-get0(Ch),(Ch < 97,!,N is I;assert(message(I,Ch)),II is I+1,readData(II,N)).

findCorrect(C,C,_,C).
findCorrect(C,_,C,C).
findCorrect(_,C,C,C).

findResult(N,N).
findResult(I,N):-II is I+1,I2 is N+I,I3 is 2*N+I,message(I,Ch1),message(I2,Ch2),message(I3,Ch3),findCorrect(Ch1,Ch2,Ch3,Ch),assert(answer(I,Ch)),findResult(II,N).

writeResult(N,N).
writeResult(I,N):-II is I+1,answer(I,Code),char_code(Ch,Code),bufferedWrite(Ch),writeResult(II,N).

main:-readData(0,N),NN is N//3,findResult(0,NN),writeResult(0,NN),nl.