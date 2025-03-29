:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic visitor/2.

getName(Current,Result):-get0(Ch),(Ch < 65,!,Result = Current;append(Current,[Ch],NewC),getName(NewC,Result)).

readSpecies(N,N,_).
readSpecies(I,N,PlanetName):-II is I+1,getName([],Next),assert(isHabitatedBy(PlanetName,Next)),readSpecies(II,N,PlanetName).

readPlanets(N,N).
readPlanets(I,N):-II is I+1,getName([],Name),assert(planet(Name,0)),readUInt(Species),readSpecies(0,Species,Name),readPlanets(II,N).

readVisitors(N,N).
readVisitors(I,N):-II is I+1,readUInt(C),getName([],VisitorName),(visitor(VisitorName,Old),!,retract(visitor(VisitorName,Old)),New is Old+C;New is C),assert(visitor(VisitorName,New)),readVisitors(II,N).

findAnswer:-planet(Planet,Old),isHabitatedBy(Planet,S),(visitor(S,A),New is Old+A,retract(visitor(S,A)),retract(planet(Planet,Old)),assert(planet(Planet,New));retract(isHabitatedBy(Planet,S))),findAnswer.
findAnswer:-!,true.

writeName([]).
writeName([H|T]):-char_code(Ch,H),bufferedWrite(Ch),writeName(T).

printResult([]).
printResult([H|T]):-H = [Name,C],writeName(Name),bufferedWrite(' '),bufferedWriteln(C),printResult(T).

printPlanets:-findall(Planet,planet(Planet),L),bufferedWriteln(L).
printHabitated:-findall([PlanetName,Next],isHabitatedBy(PlanetName,Next),L),bufferedWriteln(L).
printVisitors:-findall([VName,C],visitor(VName,C),L),bufferedWriteln(L).

main:-initiateBufferedRead(1024),readUInt(Planets),readPlanets(0,Planets),readUInt(Visitors),readVisitors(0,Visitors),findAnswer,findall([Planet,Number],planet(Planet,Number),L),msort(L,Sorted),printResult(Sorted).