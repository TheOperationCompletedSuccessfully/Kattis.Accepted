readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(I,Length,Current,Result):-get0(Ch),(Ch is 32,!,Length is I,Result is Current;C is Ch-65,NewCurrent is Current + (2^I)*C,I1 is I+1, readData(I1,Length,NewCurrent,Result)).

writeAnswer(N,N,_).
writeAnswer(I,N,R):-RR is R rem 2,NewR is R//2,Ch is 65+RR,char_code(C,Ch),write(C),I1 is I+1,writeAnswer(I1,N,NewR).

main:-readData(0,Length,0,Data),readUInt(N),Result is Data+N,writeAnswer(0,Length,Result).