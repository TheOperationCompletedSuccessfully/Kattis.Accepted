readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,Answer):-!,Result is Answer - N +1,writeln(Result).
solve(I,N,Answer):-I1 is I+1, readUInt(NextRod),A is Answer+NextRod,solve(I1,N,A).

main:-readUInt(SteelRods),solve(0,SteelRods,0).