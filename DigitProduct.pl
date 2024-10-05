readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(0,1,K):-!,(K<10,!,writeln(K);solve(K,1,1)).
solve(0,K,P):-!,NewK is K*P,solve(NewK,1,1).
solve(N,1,P):-K is N rem 10,NN is N//10,KK is max(K,1), NewP is P*KK,solve(NN,1,NewP).

main:-readUInt(N),solve(N,1,1).