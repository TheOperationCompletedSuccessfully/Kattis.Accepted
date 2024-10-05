readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(N,N,_,Min,Min,Max,Max).
readData(I,N,D,CMin,Min,CMax,Max):-II is I+1,readUInt(Next),R is Next//D,(data(R,Old),!,retract(data(R,Old)),New is Old+1,assert(data(R,New));assert(data(R,1))),(R>CMax,!,NewMax is R;NewMax is CMax),(R<CMin,!,NewMin is R;NewMin is CMin),readData(II,N,D,NewMin,Min,NewMax,Max).

findAnswer(R,_,Result):-data(R,DD),Result is (DD-1)*DD//2.

main:-readUInt(N),readUInt(D),assert(data(-1,-1)),readData(0,N,D,0,_,0,_),retract(data(-1,-1)),aggregate_all(sum(Result),findAnswer(_,D,Result),Answer),writeln(Answer).