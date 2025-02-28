:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

processRecipes(Quantity,Index):-recipe(U,Index,W),!,NewQ is Quantity*W,(needs(Q,U),!,retract(needs(Q,U)),QQ is NewQ+Q,assert(needs(QQ,U));assert(needs(NewQ,U))),retract(recipe(U,Index,W)),processRecipes(Quantity,Index),assert(recipe(U,Index,W)).
processRecipes(_,_):-true.

processNeed(-1,Index):-!,retract(needs(-1,Index)).
processNeed(Quantity,Index):-processRecipes(Quantity,Index),retract(needs(Quantity,Index)),assert(processedNeed(Quantity,Index)).

processNeeds:-(needs(Quantity,Index),!,processNeed(Quantity,Index),processNeeds;true).

readRecipes(N,N).
readRecipes(I,N):-I1 is I+1,readUInt(U),readUInt(V),readUInt(W),assert(recipe(U,V,W)),readRecipes(I1,N).

readNeeds(N,N).
readNeeds(I,N):-I1 is I+1,readUInt(Next),(Next>0,!,assert(needs(Next,I));true),readNeeds(I1,N).

aggregateNeeds(I,Current,Result):-processedNeed(Quantity,I),!,NewC is Current+Quantity,retract(processedNeed(Quantity,I)),aggregateNeeds(I,NewC,Result).
aggregateNeeds(_,Current,Result):-Result is Current.

writeAnswer(N,N).
writeAnswer(0,N):-!,(processedNeed(_,0),!,aggregateNeeds(0,0,Q),bufferedWrite(Q);bufferedWrite(0)),writeAnswer(1,N).
writeAnswer(I,N):-I1 is I+1,bufferedWrite(' '),(processedNeed(_,I),!,aggregateNeeds(I,0,Q),bufferedWrite(Q);bufferedWrite(0)),writeAnswer(I1,N).

assertFuture:-assert(needs(-1,-1)),assert(recipe(-1,-1,-1)),assert(processedNeed(-2,-2)).

main:-initiateBufferedRead(16384),readUInt(N),readUInt(M),readNeeds(0,N),assertFuture,readRecipes(0,M),processNeeds,writeAnswer(0,N).