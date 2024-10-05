readFloat(Number):-readFloat(0,RN,0,Number),(var(Number),!,Number is RN;true).
readFloat(I,R,0,Result):-get0(Ch),(Ch is 45,!,readFloat(I,R,0,Result),Result is -1*R;Ch is 46,!,readFloat(I,R,1,Result);Ch <48,!,R is I;I1 is I*10+Ch-48,readFloat(I1,R,0,Result)).
readFloat(I,R,N,Result):-get0(Ch),(Ch <48,!,R is I;I1 is I+((Ch-48)/10**N),NN is N+1, readFloat(I1,R,NN,Result)).

readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPending:-at_end_of_stream,!,true.
readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readData(N,N,Plast,Plast).
readData(I,N,Current,Plast):-II is I+1,get0(Ch),(Ch is 112,!,NewC is Current+1;NewC is Current),readPending,readData(II,N,NewC,Plast).

main:-readPending,readFloat(Level),readUInt(N),readData(0,N,0,Plast),AffordableLevel is (N-Plast)/N,(AffordableLevel=<Level,!,writeln('Jebb');writeln('Neibb')).