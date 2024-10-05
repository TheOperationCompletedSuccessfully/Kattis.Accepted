readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readInt(Number):-readInt(0,Number).
readInt(0,R):-!,get0(Ch),(Ch is 45,!,readInt(0,R1,0),R is -1*R1;Ch <48,!,readInt(0,R);I1 is Ch-48,readInt(I1,R,0)).
readInt(I,R,_):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readInt(I1,R,0)).

solve(N,N,_,Result):-R is max(0-Result,0),writeln(R).
solve(I,N,Sum,CurrentMin):-I1 is I+1, readInt(Next), NewSum is Sum + Next,NewMin is min(CurrentMin,NewSum),solve(I1,N,NewSum,NewMin).
main:-readUInt(N),solve(0,N,0,0).