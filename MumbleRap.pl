readUInt(Number):-at_end_of_stream,!,Number is -1.
readUInt(Number):-readUInt(-1,Number).
readUInt(I,R):-at_end_of_stream,!,R is I.
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);Ch >57,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;Ch >57,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(Answer):-at_end_of_stream,!,writeln(Answer).
readData(Prev):-readUInt(Next),ToProceedWith is max(Next,Prev),readData(ToProceedWith).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(_),readData(0).