main(0,_):-at_end_of_stream,!,writeln('correct').
main(_,_):-at_end_of_stream,!,writeln('fix').
main(I,K):-get0(Ch),(Ch is 10,!,(I is 0,!,writeln('correct');writeln('fix'));Ch is 124,!,NextI is I+K*1,main(NextI,K);main(I,-1)).

main:-main(0,1).