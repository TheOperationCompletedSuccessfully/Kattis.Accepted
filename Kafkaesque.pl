readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,_,Result):-!,RR is Result+1,writeln(RR).
solve(I,N,Current,Result):-I1 is I+1, readUInt(Next),(Next<Current,!,RR is Result+1,solve(I1,N,Next,RR);solve(I1,N,Next,Result)).

main:-readUInt(N),solve(0,N,0,0).