readInt(Number):-readInt(0,Number).
readInt(0,R):-!,get0(Ch),(Ch is 45,!,readInt(0,R1,0),R is -1*R1;Ch <48,!,readInt(0,R);I1 is Ch-48,readInt(I1,R,0)).
readInt(I,R,_):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readInt(I1,R,0)).

solve(A,B,C,D,X,Result):-Result is max(X*X+A*X+B,X*X+C*X+D).

main:-readInt(A),readInt(B),readInt(C),readInt(D),AA is -A/2.0,CC is -C/2.0,DB is D-B,solve(A,B,C,D,AA,S1),solve(A,B,C,D,CC,S2),(A is C,!,S3 is max(S1,S2),DBAC is 1000000000;DBAC is DB/(A-C*1.0),solve(A,B,C,D,DBAC,S3)),L = [[S1,AA],[S2,CC],[S3,DBAC]],msort(L,Sorted),Sorted = [[F,Result]|_],write(Result),write(' '),writeln(F).