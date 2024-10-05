readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readData(N,N).
readData(I,N):-II is I+1,readUInt(Next),assert(data(I,Next)),readData(II,N).

packData(N,N,_,IncCount,DecCount):-!,packIndex(OldCC),CC is OldCC+1,(IncCount>0,!,assert(diff(CC,IncCount));DD is -1*DecCount,assert(diff(CC,DD))),retract(packIndex(OldCC)),assert(packIndex(CC)).
packData(I,N,Prev,IncCount,DecCount):-II is I+1,data(I,Next),packIndex(OldCC),CC is OldCC+1,(Prev>Next,!,(IncCount>0,!,assert(diff(CC,IncCount)),retract(packIndex(OldCC)),assert(packIndex(CC));true),NewIncCount is 0,NewDecCount is DecCount+1;(DecCount>0,!,DD is -1*DecCount,assert(diff(CC,DD)),retract(packIndex(OldCC)),assert(packIndex(CC));true),NewDecCount is 0,NewIncCount is IncCount+1),packData(II,N,Next,NewIncCount,NewDecCount).

calcPV(N,N,_,_,Peaks,Peaks,Valleys,Valleys).
calcPV(I,N,NN,MM,CP,Peaks,CV,Valleys):-II is I+1,diff(I,D),(II<N,!,diff(II,DD),(D>0,!,(D>=NN,abs(DD)>=NN,!,NewCP is CP+1;NewCP is CP),NewCV is CV;(abs(D)>=MM,DD>=MM,!,NewCV is CV+1;NewCV is CV),NewCP is CP;NewCP is CP,NewCV is CV);NewCP is CP,NewCV is CV),calcPV(II,N,NN,MM,NewCP,Peaks,NewCV,Valleys).

printDiff(N,N).
printDiff(I,N):-II is I+1,diff(I,D),writeln(D),printDiff(II,N).

main:-set_stream(user_input,buffer_size(16384)),readUInt(S),readUInt(N),readUInt(M),fill_buffer(user_input),readData(0,S),data(0,Current),assert(packIndex(-1)),packData(1,S,Current,0,0),packIndex(Index),IIndex is Index+1,NN is N-1,MM is M-1,calcPV(0,IIndex,NN,MM,0,Peaks,0,Valleys),write(Peaks),write(' '),writeln(Valleys).