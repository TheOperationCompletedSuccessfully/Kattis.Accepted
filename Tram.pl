readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readInt(Number):-readInt(0,Number).
readInt(0,R):-!,get0(Ch),(Ch is 45,!,readInt(0,R1,0),R is -1*R1;Ch <48,!,readInt(0,R);I1 is Ch-48,readInt(I1,R,0)).
readInt(I,R,_):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readInt(I1,R,0)).

solve(N,N,SumX,SumY):-!,Result is (SumY-SumX)/N,writeln(Result).
solve(I,N,SumX,SumY):-I1 is I+1,readInt(X),readInt(Y),NewSumX is SumX+X,NewSumY is SumY +Y,solve(I1,N,NewSumX,NewSumY).

main:-readUInt(N),solve(0,N,0,0).