readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

calcDist(X1,Y1,X2,Y2,Result):-Result is sqrt((X2-X1)*(X2-X1)+(Y2-Y1)*(Y2-Y1)).
/*
calcSS(X1,Y1,X2,Y2,X3,Y3,SS):-calcDist(X1,Y1,X2,Y2,AB),calcDist(X1,Y1,X3,Y3,AC),calcDist(X2,Y2,X3,Y3,BC),BBCC is BC*BC,AACC is AC*AC,AABB is AB*AB,P is (AB+AC+BC)/2,(BBCC=<AACC+AABB,!,SS is P*(P-AB)*(P-AC)*(P-BC)/(AB*AB);SS is AABB).
*/
calcSS(X1,Y1,X2,Y2,X3,Y3,SS):-calcDist(X1,Y1,X2,Y2,AB),calcDist(X1,Y1,X3,Y3,AC),calcDist(X2,Y2,X3,Y3,BC),P is (AB+AC+BC)/2,SS is round(1000000*sqrt(P*(P-AB)*(P-AC)*(P-BC))).


readName(Current,Result):-get0(Ch),(Ch <65,!,Result = Current;append(Current,[Ch],NewC),readName(NewC,Result)).

readData(N,N,_,_,_,_,Result,Result).
readData(I,N,X1,Y1,X2,Y2,Current,Result):-II is I+1,readName([],Name),readUInt(CX),readUInt(CY),calcSS(X1,Y1,X2,Y2,CX,CY,SS),NewC is min(Current,SS),assert(city(SS,I,Name)),readData(II,N,X1,Y1,X2,Y2,NewC,Result).

printName([]).
printName([H|T]):-char_code(Ch,H),write(Ch),printName(T).

printList([],_):-!,nl.
printList([H|T],0):-H=[_,_,Name],printName(Name),printList(T,1).
printList([H|T],1):-H=[_,_,Name],write(' '),printName(Name),printList(T,1).

printAnswer(Result):-findall([Result,I,Name],city(Result,I,Name),L),msort(L,Sorted),printList(Sorted,0).

retractData:-retractall(city(_,_,_)).

solve(N,N).
solve(I,N):-II is I+1,readUInt(X1),readUInt(Y1),readUInt(X2),readUInt(Y2),readUInt(Cities),readData(0,Cities,X1,Y1,X2,Y2,4000000000000,Result),printAnswer(Result),retractData,solve(II,N).

main:-readUInt(Cases),solve(0,Cases).