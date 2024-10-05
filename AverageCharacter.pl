readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

writeAnswer(Count,Sum):-Code is Sum//Count,char_code(Char,Code),writeln(Char).

main(Count,Sum):-at_end_of_stream,!,writeAnswer(Count,Sum).
main(Count,Sum):-get0(Ch),(Ch<32,!,writeAnswer(Count,Sum);C is Count+1,NewSum is Sum+Ch,main(C,NewSum)).
main:-main(0,0).