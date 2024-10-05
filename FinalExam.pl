readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPending:-at_end_of_stream,!,true.
readPending:-get0(Ch),(Ch is 10,!,true;readPending).

solve(N,N,_,Result):-!,writeln(Result).
solve(I,N,Prev,Current):-II is I+1, get0(Ch),readPending,(Prev is Ch,!,NewC is Current+1;NewC is Current),solve(II,N,Ch,NewC).

main:-readUInt(N),solve(0,N,64,0).