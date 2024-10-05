readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

calcCurrent(N,N,NewTotal):-!,assert(data(N,1)),Total is NewTotal+1,retract(total(_)),assert(total(Total)).
calcCurrent(I,N,NewTotal):-II is I+1,D is I*(1/N),total(T),(data(I,Old),!,(I<T,!,retract(data(I,Old)),DD is T*(1/N),assert(data(I,DD)),NT is NewTotal+DD;NT is NewTotal+D);assert(data(I,D)),NT is NewTotal+D),calcCurrent(II,N,NT).

calcNext(N,N,_).
calcNext(I,N,NN):-II is I+1,calcCurrent(1,NN,0),calcNext(II,N,NN).


main:-readUInt(N),readUInt(K),assert(data(-1,-1)),assert(total(0)),calcCurrent(1,N,0),calcNext(1,K,N),total(Answer),writeln(Answer).