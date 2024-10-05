readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

printResult([]).
printResult([A|Tail]):-(A>0,writeln(A);true),printResult(Tail).

findGood(InputList,Diff,Result):-select(Elem,InputList,0,NewInputList),Elem2 is Diff-Elem,member(Elem2,NewInputList),Elem2>0,select(Elem2,NewInputList,0,ResList),sum_list(ResList,100),!,Result = ResList.

main:-readUInt(G1),readUInt(G2),readUInt(G3),readUInt(G4),readUInt(G5),readUInt(G6),readUInt(G7),readUInt(G8),readUInt(G9),FalseSum is G1+G2+G3+G4+G5+G6+G7+G8+G9,Diff is FalseSum - 100,
findGood([G1,G2,G3,G4,G5,G6,G7,G8,G9],Diff,Result),printResult(Result).