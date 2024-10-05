readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readName(Current,Name):-get0(Ch),(Ch is 32,!, Name = Current;char_code(H,Ch),append(Current,[H],NewC),readName(NewC,Name)).

writeData([]).
writeData([H|T]):-write(H),writeData(T).

processRoads(N,N,_).
processRoads(I,N,Wind):-II is I+1,readName([],Name),readUInt(W),writeData(Name),write(' '),(W<Wind,!,writeln('lokud');writeln('opin')),processRoads(II,N,Wind).

main:-readUInt(Wind),readUInt(Roads),processRoads(0,Roads,Wind).