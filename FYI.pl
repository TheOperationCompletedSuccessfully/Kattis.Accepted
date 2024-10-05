readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

valid(53,0,R):-!,writeln('1'),R is 10.
valid(53,C,R):-R is C+1.
valid(_,-2,R):-!,R is 10,writeln('0').
valid(_,-1,R):-!,R is 10,writeln('0').
valid(_,0,R):-!,R is 10,writeln('0').
valid(_,C,R):-R is 22.


main:-get0(Ch1),valid(Ch1,-2,D1),get0(Ch2),valid(Ch2,D1,D2),get0(Ch3),valid(Ch3,D2,_).