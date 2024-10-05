readHowl(I,N):-at_end_of_stream,!,N is I.
readHowl(I,N):-get0(Ch),(Ch is 10,!,N is I;I1 is I+1,readHowl(I1,N)).
writeAnswer(0).
writeAnswer(I):-I1 is I-1,write('O'),writeAnswer(I1).
main:-readHowl(0,N),NN is N+1,(NN<10,!,writeln('AWAWHOOOOO');write('AWAWHOOOOO'),NNN is NN-10,writeAnswer(NNN)).