printResult(AE,Total,Sign):-Result is 100*(AE+Sign)/Total,(Result>=40,!,writeln('dae ae ju traeligt va');writeln('haer talar vi rikssvenska')).

main(_,AE,Total,Sign):-at_end_of_stream,!,T is Total +1,printResult(AE,T,Sign).
main(Data,AE,Total,Sign):-get0(Ch),(Ch<32,!,T is Total +1,printResult(AE,T,Sign);Ch is 32,!,AE1 is AE + Sign,T is Total + 1,main(Ch,AE1,T,0);Data is 97,Ch is 101,!,main(Ch,AE,Total,1);main(Ch,AE,Total,Sign)).

main:-main(32,0,0,0).