readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(N,N,CurrentMin,ResultMin,CurrentMax,ResultMax):-!,ResultMin is CurrentMin,ResultMax is CurrentMax.
readData(I,N,CurrentMin,ResultMin,CurrentMax,ResultMax):-I1 is I+1, readUInt(Data),NewCurrentMin is min(Data,CurrentMin),NewCurrentMax is max(Data,CurrentMax),(know(Data,J),!,J1 is J+1,retract(know(Data,J)),assert(know(Data,J1));assert(know(Data,1))),readData(I1,N,NewCurrentMin,ResultMin,NewCurrentMax,ResultMax).

drinkPotions(_,_,_,_,_,K):-K=<0,!,writeln('NO').
drinkPotions(N,N,_,_,_,_):-!,writeln('YES').
drinkPotions(0,N,Min,Max,TimeToDrink,_):-!,know(Max,J),(J is 1,!,retract(know(Max,1)),MM is Max-1,drinkPotions(1,N,Min,MM,TimeToDrink,Max);JJ is J-1,retract(know(Max,J)),assert(know(Max,JJ)),drinkPotions(1,N,Min,Max,TimeToDrink,Max)).
drinkPotions(I,N,Min,Max,TimeToDrink,TimeLeft):-I1 is I+1,(know(Max,J),!,(J is 1,!,retract(know(Max,1)),MM is Max-1,TTL is min(TimeLeft-TimeToDrink,Max),drinkPotions(I1,N,Min,MM,TimeToDrink,TTL);JJ is J-1,retract(know(Max,J)),assert(know(Max,JJ)),TTL is min(TimeLeft-TimeToDrink,Max),drinkPotions(I1,N,Min,Max,TimeToDrink,TTL));MM is Max-1,drinkPotions(I1,N,Min,MM,TimeToDrink,TimeLeft)).

main:-readUInt(N),readUInt(T),assert(know(-1,-1)),readData(0,N,N,Min,0,Max),drinkPotions(0,N,Min,Max,T,N).