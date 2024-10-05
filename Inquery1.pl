readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,Sum,ResultSum,QSum,ResultQSum):-!,ResultSum is Sum,ResultQSum is QSum.
solve(I,N,Sum,ResultSum,QSum,ResultQSum):-I1 is I+1,readUInt(Next),assert(know(Next,I)),NewQS is QSum + Next*Next,assert(qSum(QSum,I)),NewS is Sum + Next,solve(I1,N,NewS,ResultSum,NewQS,ResultQSum).

findAnswer(N,N,Current,_):-!,writeln(Current).
findAnswer(I,N,Current,Sum):-I1 is I+1,Index is N-I-1,know(Item,Index),NewS is Sum+Item,qSum(QSum,Index),NewC is max(Current,NewS*QSum),findAnswer(I1,N,NewC,NewS).

main:-readUInt(N),solve(0,N,0,_,0,_),assert(qSum(0,-1)),findAnswer(0,N,0,0).