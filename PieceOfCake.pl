readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

main:-readUInt(N),readUInt(H),readUInt(V),HH is max(H,N-H),VV is max(V,N-V),Result is 4*HH*VV,writeln(Result).