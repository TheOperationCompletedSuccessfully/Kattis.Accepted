readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readHotelData(N,N,_,Flag,Result):-!,Result is Flag.
readHotelData(I,N,Participants,Flag,Result):-I1 is I+1,readUInt(VacantPlaces),(VacantPlaces>=Participants,!,Flag1 is 1,readHotelData(I1,N,Participants,Flag1,Result);readHotelData(I1,N,Participants,Flag,Result)).

solve(N,N,_,_,Budget,Current):-!,(Current>Budget,!,writeln('stay home');writeln(Current)).
solve(I,N,Participants,Weeks,Budget,Current):-I1 is I+1,readUInt(HotelPrice),readHotelData(0,Weeks,Participants,0,IsFit),(IsFit is 1,!,NewCurrent is min(Current,HotelPrice*Participants),solve(I1,N,Participants,Weeks,Budget,NewCurrent);solve(I1,N,Participants,Weeks,Budget,Current)).

main:-readUInt(Participants),readUInt(Budget),readUInt(Hotel),readUInt(Weeks), solve(0,Hotel,Participants,Weeks,Budget,1000000).