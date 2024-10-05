readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

main:-readUInt(M),N is M//100, P is ceiling(M/100),P1 is N*100+99,PN is abs(N-1)*100+99,P2 is P*100+99,P1M is abs(P1-M),P2M is abs(P2-M),PNM is abs(M-PN),R is min(min(P1M,P2M),PNM),(P2M is R,!,writeln(P2);P1M is R,!,writeln(P1);writeln(PN)).