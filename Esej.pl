readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

generateWord(N,N,_).
generateWord(I,N,K):-I1 is I+1,KK is (K rem 25) + 97,NewK is K//25,char_code(Ch,KK),write(Ch),generateWord(I1,N,NewK).

solve(N,N).
solve(0,N):-generateWord(0,6,0),solve(1,N).
solve(I,N):-I1 is I+1,write(' '),generateWord(0,6,I),solve(I1,N).

main:-readUInt(A),readUInt(B),N is (A+B)//2,solve(0,N).