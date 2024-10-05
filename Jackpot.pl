readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPending(N,N).
readPending(I,N):-II is I+1,readUInt(_),readPending(II,N).

solveMachine(N,N,Result):-!,(Result>1000000000,!,writeln('More than a billion.');writeln(Result)).
solveMachine(I,N,Current):-II is I+1,readUInt(Next),G is gcd(Next,Current),NewCurrent is Next*Current//G,(NewCurrent>1000000000,!,readPending(II,N),solveMachine(N,N,NewCurrent);solveMachine(II,N,NewCurrent)).

solve(N,N).
solve(I,N):-II is I+1, readUInt(Wheels), readUInt(Next),solveMachine(1,Wheels,Next),solve(II,N).

main:-readUInt(N),solve(0,N).