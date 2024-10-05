readNumber(X):-get0(_),readNumber(0,X).
readNumber(I,N):-at_end_of_stream,!,N is I.
readNumber(I,N):-get0(Ch),(Ch<32,!,N is I;I1 is I+1,readNumber(I1,N)).

readSign(S):-get0(S),get0(Ch),(Ch is 10,!,true;get0(_)).
writeAnswerInner(X):-write(1),writeAnswerInner(0,X).
writeAnswerInner(X,X).
writeAnswerInner(I,N):-write(0),I1 is I+1,writeAnswerInner(I1,N).
writeAnswer(42,Min,Max):-!,X is Min+Max,writeAnswerInner(X).
writeAnswer(43,Min,Min):-!,write(2),writeAnswerInner(0,Min).
writeAnswer(43,Min,Max):-!,write(1),I1 is Max-Min-1,writeAnswerInner(0,I1),write(1),writeAnswerInner(0,Min).

main:-readNumber(N1),readSign(Sign),readNumber(N2),M is min(N1,N2), X is max(N1,N2),writeAnswer(Sign,M,X).