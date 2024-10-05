readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,_,Answer):-!,writeln(Answer).
solve(I,N,V,Answer):-I1 is I+1,readUInt(L),readUInt(W),readUInt(H),VV is L*W*H,D is VV-V,NewAnswer is max(Answer,D),solve(I1,N,V,NewAnswer).

main:-readUInt(N),readUInt(V),VV is 0-V,solve(0,N,V,VV).