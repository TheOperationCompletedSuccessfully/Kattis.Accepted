readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(0,I1,R)).
readUInt(I,D,R):-get0(Ch),(Ch <44,!,R is I+D;Ch is 44,!,I1 is 60*D+I*60,readUInt(I1,0,R);D1 is D*10+Ch-48,readUInt(I,D1,R)).

solve(N,N).
solve(I,N):-I1 is I+1,readUInt(Number),writeln(Number),solve(I1,N).

main:-readUInt(Cases),solve(0,Cases).