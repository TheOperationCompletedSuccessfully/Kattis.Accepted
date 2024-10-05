readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(H,H,_,_,Result,Result).
solve(I,H,A,B,Current,Result):-(H-I=<A,!,Result is Current+1;NewI is I + (A-B)*(H//A),NewC is Current + (H//A),solve(NewI,H,A,B,NewC,Result)).

main:-readUInt(A),readUInt(B),readUInt(H),(H=<A,!,Result is 1;H-A>=A-B,!,RR is (H-A)//(A-B),R1 is RR*(A-B),(H-R1 is 0,!,K is 0;H-R1=<A,K is 1;K is 2),Result is RR+K;solve(0,H,A,B,0,Result)),writeln(Result).