readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

readMessages(N,N,_,_).
readMessages(I,N,PeopleCount,Current):-II is I+1,readUInt(Next),ToAdd is PeopleCount-1,(lastRead(Next,LastRead),!,ToRemove is I-LastRead,retract(lastRead(Next,LastRead));ToRemove is I),assert(lastRead(Next,II)),Result is Current+ToAdd-ToRemove,bufferedWriteln(Result),readMessages(II,N,PeopleCount,Result).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(N),readUInt(M),assert(lastRead(-1,-1)),readMessages(0,M,N,0).