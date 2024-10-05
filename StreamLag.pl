readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

getData(N,N).
getData(I,N):-II is I+1,readUInt(Time),readUInt(FrameNumber),assert(data(FrameNumber,Time)),getData(II,N).

playVideo(N,N,Lag,Lag).
playVideo(I,N,CurrentLag,FinalLag):-II is I+1,data(II,Time),NewLag is max(CurrentLag,Time-II),playVideo(II,N,NewLag,FinalLag).

main:-readUInt(N),getData(0,N),playVideo(0,N,0,Lag),writeln(Lag).