readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

main:-readUInt(A),readUInt(B),readUInt(C),AB is A*B,D is AB//C,R is AB rem C,(R is 0,!,writeln(D);D1 is R/C,atom_string(D1,S1),atom_length(S1,Len),LL is Len-1,sub_string(S1,1,LL,_,Res),write(D),writeln(Res)).