readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

main:-readUInt(WC),readUInt(HC),readUInt(WS),readUInt(HS),(WC>WS+1,HC>HS+1,!,writeln(1);writeln(0)).