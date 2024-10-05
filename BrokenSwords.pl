readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(N,N,CurrentTB,CurrentLR,TB,LR):-!,TB is CurrentTB,LR is CurrentLR.
readData(I,N,CurrentTB,CurrentLR,TB,LR):-I1 is I+1,get0(TChar),get0(BChar),get0(LChar),get0(RChar),NewCurrentTB is CurrentTB + (2-(TChar+BChar-96)),NewCurrentLR is CurrentLR + (2-(LChar+RChar-96)),readPending,readData(I1,N,NewCurrentTB,NewCurrentLR,TB,LR).

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

writeAnswers(A,B,C):-write(A),write(' '),write(B),write(' '),writeln(C).
main:-readUInt(N),readData(0,N,0,0,TB,LR),Min is min(TB,LR),Answer1 is Min//2,Answer2 is TB - Answer1*2,Answer3 is LR - Answer1*2,writeAnswers(Answer1,Answer2,Answer3).