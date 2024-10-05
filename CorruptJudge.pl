readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

writeData(N,N,_).
writeData(I,N,0):-II is I+1,bufferedWriteln(0),writeData(II,N,0).
writeData(I,N,1):-II is I+1,(data(I,0),!,writeData(I,N,0);bufferedWriteln(1),writeData(II,N,1)).
writeData(I,N,K):-II is I+1,(increase(I),!,NewK is K-1;NewK is K),bufferedWriteln(NewK),writeData(II,N,NewK).

readData(N,N,_,Result,Result).
readData(I,N,Prev,Current,Result):-II is I+1,readUInt(Next),assert(data(I,Next)),(Prev>Next,Next>0,!,NewC is Current+1,assert(increase(I));NewC is Current),NewPrev is Next,readData(II,N,NewPrev,NewC,Result).

bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(N),readUInt(P),assert(data(-1,-1)),readData(0,N,0,0,D),(P is 1,!,writeData(0,N,1);data(0,0),!,writeData(0,N,0);D<P-1,!,writeln('ambiguous');data(_,0),!,DD is D+1,writeData(0,N,DD);DD is D+1,writeData(0,N,DD)).