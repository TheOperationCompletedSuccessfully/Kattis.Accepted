readUFloat(Number):-readUFloat(0,Number,0).
readUFloat(I,R,0):-get0(Ch),(Ch is 46,!,readUFloat(I,R,1);Ch <48,!,R is I;I1 is I*10+Ch-48,readUFloat(I1,R,0)).
readUFloat(I,R,N):-get0(Ch),(Ch <48,!,R is I;I1 is I+((Ch-48)/10**N),NN is N+1, readUFloat(I1,R,NN)).


/*
Main equation is 
X-H = K*T2 + T1*(1-L/X)*K
X = answer
e.g.
water that left = H-L,
water that flawed is flawed in T2 time + flawed in T1 time,
X/T1 - speed of rain
*/
solve(L,_,_,_,H):-L>H,!,write(H),write(' '),writeln(H).

solve(L,K,T1,T2,H):-L<H,!,B is (H+K*(T1+T2)),D is (H+K*(T1+T2))*(H+K*(T1+T2))-4*T1*L*K,Result is (B+sqrt(D))/2,write(Result),write(' '),writeln(Result).

solve(L,K,T1,T2,H):-B is (H+K*(T1+T2)),D is (H+K*(T1+T2))*(H+K*(T1+T2))-4*T1*L*K,Result is (B+sqrt(D))/2,write(H),write(' '),writeln(Result).

main:-readUFloat(L),readUFloat(K),readUFloat(T1),readUFloat(T2),readUFloat(H),solve(L,K,T1,T2,H).