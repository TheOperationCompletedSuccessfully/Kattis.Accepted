readUInt(Number):-readUInt(0,Number).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solveInner(N,N,Current):-!,writeln(Current).
solveInner(I,N,Current):-I is N-1,!,readUInt(Outlet),C1 is Current + Outlet,solveInner(N,N,C1).
solveInner(I,N,Current):-readUInt(Outlet),C1 is Current + Outlet - 1,I1 is I+1,solveInner(I1,N,C1).

solve(N,N).
solve(I,N):-readUInt(PowerStrips),solveInner(0,PowerStrips,0),I1 is I+1,solve(I1,N).

main:-readUInt(Problems),solve(0,Problems).