readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

cross(C,I,N,J,K):-CC is C*I,NewC is C+1,(CC>N,!,K is J;crossed(CC,_),!,cross(NewC,I,N,J,K);assert(crossed(CC,J)),NewJ is J+1,cross(NewC,I,N,NewJ,K)).

solve(_,_,J,K):-J>K,!,crossed(Answer,K),writeln(Answer).
/*solve(_,_,K,K):-!,crossed(Answer,K),writeln(Answer).*/
solve(I,N,J,K):-I1 is I+1,cross(1,I,N,J,NewJ),solve(I1,N,NewJ,K).

main:-readUInt(N),readUInt(K),assert(crossed(-1,-1)),solve(2,N,1,K).