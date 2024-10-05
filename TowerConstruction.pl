readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,_,Result,Result).
solve(I,N,CN,CR,Result):-I1 is I+1,readUInt(NextNumber),(NextNumber>CN,!,CCR is CR+1,solve(I1,N,NextNumber,CCR,Result);solve(I1,N,NextNumber,CR,Result)).

main:-readUInt(Numbers),readUInt(FirstNumber),solve(1,Numbers,FirstNumber,1,Result),writeln(Result).