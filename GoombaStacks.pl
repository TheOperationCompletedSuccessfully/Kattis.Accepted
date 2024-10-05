readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,_):-!,writeln('possible').
solve(I,N,Current):-II is I+1,readUInt(G),readUInt(B),NewC is Current+G,(NewC<B,!,read_pending_input(user_input, _, []),writeln('impossible');solve(II,N,NewC)).

main:-readUInt(N),solve(0,N,0).