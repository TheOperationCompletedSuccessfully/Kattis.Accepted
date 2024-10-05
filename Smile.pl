smile(7465).
smile(7593).
smile(956073).
smile(972457).

checkHash(Ch1,Ch2,Ch3):-C is Ch1*128*128+Ch2*128+Ch3,smile(C).
checkHash(Ch1,Ch2):-C is Ch1*128+Ch2,smile(C).

main(_,_):-at_end_of_stream,!,true.
main(I,Ch1):-get0(Ch),(Ch is 10,!,true;Ch is 41,!,(checkHash(Ch1,Ch),writeln(I);true);true),I1 is I+1,main(I1,Ch1,Ch).
main(_,_,_):-at_end_of_stream,!,true.
main(I,Ch1,Ch2):-get0(Ch),(Ch is 10,!,true;I1 is I+1,main(I1,Ch1,Ch2,Ch)).
main(I,Ch1,Ch2,Ch3):-at_end_of_stream,!,(Ch3 is 41,!,(checkHash(Ch1,Ch2,Ch3),I1 is I-2,writeln(I1);checkHash(Ch2,Ch3),I1 is I-1,writeln(I1);true);true).
main(I,Ch1,Ch2,Ch3):-get0(Ch),I1 is I+1,(Ch is 10,!,(checkHash(Ch1,Ch2,Ch3),II is I-2,writeln(II);checkHash(Ch2,Ch3),II is I-1,writeln(II);true);Ch3 is 41,!,(checkHash(Ch1,Ch2,Ch3),II is I-2,writeln(II),main(I1,Ch2,Ch3,Ch);checkHash(Ch2,Ch3),II is I-1,writeln(II),main(I1,Ch2,Ch3,Ch);main(I1,Ch2,Ch3,Ch));main(I1,Ch2,Ch3,Ch)).

main:-at_end_of_stream,!,true.
main:-get0(Ch),(Ch is 10,!,true;main(0,Ch)).
