readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(N,N,Result,Result).
readData(I,N,Current,Result):-II is I+1,readUInt(A),readUInt(L),NewCurrent is A*L+Current,readData(II,N,NewCurrent,Result).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readData(0,5,0,Sum),Average is Sum//5,readUInt(N),readUInt(KWF),Result is Average*N//KWF,writeln(Result).