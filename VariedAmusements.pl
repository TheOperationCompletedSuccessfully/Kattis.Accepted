readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

chooseABC(A,A,B,_,0,Result):-!,Result is B.
chooseABC(A,A,_,C,1,Result):-!,Result is C.
chooseABC(B,A,B,_,0,Result):-!,Result is A.
chooseABC(B,_,B,C,1,Result):-!,Result is C.
chooseABC(C,A,_,C,0,Result):-!,Result is A.
chooseABC(C,_,B,C,1,Result):-!,Result is B.

calcABC(K,_,_,_,N,N,Result):-!,Result is K.
calcABC(K,A,B,C,I,N,Result):-I1 is I+1,chooseABC(K,A,B,C,0,R0),chooseABC(K,A,B,C,1,R1),(know(R0,A,B,C,I1,N,RR0),!,true;calcABC(R0,A,B,C,I1,N,RR0),assert(know(R0,A,B,C,I1,N,RR0))),(know(R1,A,B,C,I1,N,RR1),!,true;calcABC(R1,A,B,C,I1,N,RR1),assert(know(R1,A,B,C,I1,N,RR1))),Result is K*(RR0+RR1) rem 1000000007.

solve(N,A,B,C,Result):-calcABC(A,A,B,C,1,N,NA),calcABC(B,A,B,C,1,N,NB),calcABC(C,A,B,C,1,N,NC),Result is (NA + NB + NC) rem 1000000007.

main:-readUInt(N),readUInt(A),readUInt(B),readUInt(C),assert(know(0,0,0,0,0,0,0)),solve(N,A,B,C,Result),writeln(Result).