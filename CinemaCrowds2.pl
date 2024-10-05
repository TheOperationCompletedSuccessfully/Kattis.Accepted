readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(I,I,_,Result):-!,Answer is I-Result,writeln(Answer).
solve(I,M,N,Result):-I1 is I+1, readUInt(K),(K>N,!,solve(I1,M,0,Result);KK is N-K,RR is Result+1,solve(I1,M,KK,RR)).

main:-readUInt(N),readUInt(M),solve(0,M,N,0).