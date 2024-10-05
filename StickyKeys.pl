main(N,N):-at_end_of_stream,!,true.
main(A,B):-at_end_of_stream,!,char_code(CA,A),write(CA),char_code(CB,B),write(CB).
main(X,10):-!,char_code(C,X),write(C).
main(N,N):-!,get0(Ch),main(N,Ch).
main(A,B):-(A>0,char_code(C,A),write(C);true),get0(Ch),main(B,Ch).
main:-get0(Ch),main(-1,Ch).