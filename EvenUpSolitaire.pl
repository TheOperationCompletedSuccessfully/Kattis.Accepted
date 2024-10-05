readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,Answer):-!,writeln(Answer).
solve(I,N,CurrentAnswer):-I1 is I+1,readUInt(K),KK is K rem 2,(data(CurrentAnswer,KK),!,retract(data(CurrentAnswer,KK)),NA is CurrentAnswer-1,NewC is max(0,NA);NewC is CurrentAnswer+1,assert(data(NewC,KK))),solve(I1,N,NewC).

main:-readUInt(N),assert(data(-1,-1)),solve(0,N,0).