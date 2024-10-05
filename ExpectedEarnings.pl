readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readFloat(Number):-readFloat(0,RN,0,Number),(var(Number),!,Number is RN;true).
readFloat(I,R,0,Result):-get0(Ch),(Ch is 45,!,readFloat(I,R,0,Result),Result is -1*R;Ch is 46,!,readFloat(I,R,1,Result);Ch <48,!,R is I;I1 is I*10+Ch-48,readFloat(I1,R,0,Result)).
readFloat(I,R,N,Result):-get0(Ch),(Ch <48,!,R is I;I1 is I+((Ch-48)/10**N),NN is N+1, readFloat(I1,R,NN,Result)).

main:-readUInt(N),readUInt(K),readFloat(P),Result is P*N-K,(Result<0,!,writeln('spela');writeln('spela inte!')).