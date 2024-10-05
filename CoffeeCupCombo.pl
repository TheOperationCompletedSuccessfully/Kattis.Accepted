readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(N,N,_,Result,Result).
readData(I,N,CC,Current,Result):-II is I+1,get0(Ch),(Ch is 49,!,NewCurrent is Current+1,NewCC is 2;CC>0,!,NewCurrent is Current+1,NewCC is CC-1;NewCurrent is Current,NewCC is 0),readData(II,N,NewCC,NewCurrent,Result).

main:-set_stream(user_input,buffer_size(16384)),readUInt(N),fill_buffer(user_input),readData(0,N,0,0,Result),writeln(Result).