readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

printFail:-!,read_pending_input(user_input, _, []),writeln('next time').

readData(N,N,_,_,_):-!,writeln('champion').
readData(I,N,CH,MaxH,PotionsLeft):-II is I+1,readUInt(NextDamage),(NextDamage>=MaxH,!,printFail;NextDamage>=CH,!,PotionsToUse is ceiling((NextDamage-CH+1)/20),(PotionsToUse>PotionsLeft,!,printFail;NewPotions is PotionsLeft - PotionsToUse,HealthLeft is min(CH+PotionsToUse*20,MaxH)-NextDamage,readData(II,N,HealthLeft,MaxH,NewPotions));HealthLeft is CH-NextDamage,readData(II,N,HealthLeft,MaxH,PotionsLeft)).

main:-readUInt(Health),readUInt(Attacks),readUInt(Potions),readData(0,Attacks,Health,Health,Potions).