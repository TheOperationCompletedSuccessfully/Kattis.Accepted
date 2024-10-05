readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readIngredients(N,N,Current,Result):-!,Result = Current.
readIngredients(I,N,Current,Result):-I1 is I+1,readUInt(Next),append(Current,[Next],NewC),readIngredients(I1,N,NewC,Result).

writeResult([],_,_).
writeResult([Head|Tail],X,Y):-R is Head*Y//X, writeln(R),writeResult(Tail,X,Y). 

main:-readUInt(N),readUInt(X),readUInt(Y),readIngredients(0,N,[],Ingredients),writeResult(Ingredients,X,Y).