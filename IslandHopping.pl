readUInt(Number):-readUInt(0,Number).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).
readFloat(Number):-readFloat(0,RN,0,Number),(var(Number),!,Number is RN;true).
readFloat(I,R,0,Result):-get0(Ch),(Ch is 45,!,readFloat(I,R,0,Result),Result is -1*R;Ch is 46,!,readFloat(I,R,1,Result);Ch <48,!,R is I;I1 is I*10+Ch-48,readFloat(I1,R,0,Result)).
readFloat(I,R,N,Result):-get0(Ch),(Ch <48,!,R is I;I1 is I+((Ch-48)/10**N),NN is N+1, readFloat(I1,R,NN,Result)).

readIslands(N,N,Current,Result):-!,Result = Current.
readIslands(I,N,Current,Result):-I1 is I+1,readFloat(X),readFloat(Y),append(Current,[[X,Y]],NewCurrent),readIslands(I1,N,NewCurrent,Result).

distance(X1,Y1,X2,Y2,Result):-Result is sqrt(abs((X1-X2)*(X1-X2))+abs((Y1-Y2)*(Y1-Y2))).

findMinDistance([],[],CurrentItem,Item,Current,Result):-!,Item=CurrentItem,Result is Current.
findMinDistance([],_,CurrentItem,Item,Current,Result):-!,Item = CurrentItem,Result is Current.
findMinDistance(_,[],CurrentItem,Item,Current,Result):-!,Item = CurrentItem,Result is Current.
findMinDistance([[X1,Y1]|Tail],[[X2,Y2]|T],CurrentItem,Item,Current,Result):-distance(X1,Y1,X2,Y2,Candidate),(Candidate<Current,!,findMinDistance(Tail,[[X2,Y2]|T],[X2,Y2],IT,Candidate,R1),findMinDistance([[X1,Y1]|Tail],T,IT,IT2,R1,R2);findMinDistance(Tail,[[X2,Y2]|T],CurrentItem,IT,Current,R1),findMinDistance([[X1,Y1]|Tail],T,IT,IT2,R1,R2)),Item=IT2,Result is R2.

findLength(_,[],Current,Result):-!,Result is Current.
findLength(FirstList,SecondList,Current,Result):-SecondList=[Item0|_],findMinDistance(FirstList,SecondList,Item0,Item,1000000000,MinDistance),C is Current+MinDistance,append(FirstList,[Item],FL),nth0(_,SecondList,Item,SL),findLength(FL,SL,C,Result).

solve(N,N).
solve(I,N):-I1 is I+1,readUInt(Islands),readIslands(0,Islands,[],Coords),Coords = [[X,Y]|Tail],findLength([[X,Y]],Tail,0,Result),writeln(Result),solve(I1,N).

main:-readUInt(Cases),solve(0,Cases).

