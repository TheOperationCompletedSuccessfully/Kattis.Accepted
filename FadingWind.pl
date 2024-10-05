readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(0,_,_,_,_,Result,Result).
solve(I,H,V,S,K,Current,Result):-NewV is V+S,VV is NewV//10,NewV2 is NewV-max(1,VV),(NewV2>=K,!,NewH is I+1;NewV2>0,NewH is I-1;NewH is I),(NewH is 0,!,NewV3 is 0;NewV3 is NewV2),(NewV3<0,!,NewV4 is 0,NewH2 is 0;NewH2 is NewH,NewV4 is NewV3),NewC is Current+NewV4,(S>0,!,NewS is S-1;NewS is S),solve(NewH2,H,NewV4,NewS,K,NewC,Result).

main:-readUInt(H),readUInt(K),readUInt(V),readUInt(S),solve(H,H,V,S,K,0,Distance),writeln(Distance).