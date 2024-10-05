readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N).
solve(I,N):-I1 is I+1,readUInt(P),readUInt(R),readUInt(F),(F>=P,!,DD is log(F/P)/log(R), (ceil(DD)-DD>0.00000000001,!,Result is ceil(DD);Result is 1 + ceil(DD));Result is 0),writeln(Result),solve(I1,N).

main:-readUInt(Cases),solve(0,Cases).