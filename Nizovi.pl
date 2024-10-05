spacify(N,N).
spacify(I,N):-I1 is I+1, write(' '),spacify(I1,N).

main(_,_):-at_end_of_stream,!,true.
main(I,123):-get0(Ch),(Ch<44,!,true;Ch is 123, !,spacify(0,I),writeln('{'),I1 is I+2,main(I1,123);Ch is 125,!,I1 is I-2,spacify(0,I1),write('}'),main(I1,125);Ch is 44,!,writeln(','),main(I,44);spacify(0,I),char_code(C,Ch),write(C),main(I,Ch)).
main(I,125):-get0(Ch),(Ch<44,!,true;Ch is 123, !,spacify(0,I),writeln('{'),I1 is I+2,main(I1,123);Ch is 125,!,I1 is I-2,writeln(''),spacify(0,I1),write('}'),main(I1,125);Ch is 44,!,writeln(','),main(I,44);spacify(0,I),char_code(C,Ch),write(C),main(I,Ch)).
main(I,44):-get0(Ch),(Ch<44,!,true;Ch is 123, !,spacify(0,I),writeln('{'),I1 is I+2,main(I1,123);Ch is 125,!,I1 is I-2,writeln(''),spacify(0,I1),write('}'),main(I1,125);Ch is 44,!,writeln(','),main(I,44);spacify(0,I),char_code(C,Ch),write(C),main(I,Ch)).

main(I,_):-get0(Ch),(Ch<44,!,true;Ch is 123, !,spacify(0,I),writeln('{'),I1 is I+2,main(I1,123);Ch is 125,!,I1 is I-2,writeln(''),spacify(0,I1),write('}'),main(I1,125);Ch is 44,!,writeln(','),main(I,44);char_code(C,Ch),write(C),main(I,Ch)).



main:-main(0,65),writeln('').