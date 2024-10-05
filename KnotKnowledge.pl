readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readKnots(N,N,Current,Result):-!,Result = Current.
readKnots(I,N,Current,Result):-I1 is I+1, readUInt(Knot),append(Current,[Knot],NewC),readKnots(I1,N,NewC,Result).

learnKnots(N,N).
learnKnots(I,N):-I1 is I+1,readUInt(Knot),assert(know(Knot)),learnKnots(I1,N).

checkKnots([]).
checkKnots([H|T]):-(know(H),!,checkKnots(T);writeln(H)).

main:-readUInt(Knots),readKnots(0,Knots,[],KnotList),KK is Knots-1,learnKnots(0,KK),checkKnots(KnotList).