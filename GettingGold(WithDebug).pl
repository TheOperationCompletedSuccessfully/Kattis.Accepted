readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readColumns(N,N,_).
readColumns(I,N,Row):-II is I+1,get0(Ch),assert(field(I,Row,Ch)),readColumns(II,N,Row).

readField(N,N,_).
readField(I,N,W):-II is I+1,readColumns(0,W,I),readPending,readField(II,N,W).

addToQueue(X,Y,W,H):-logAddingToQueue(X,Y),X>=0,Y>=0,X<W,Y<H,not(visited(X,Y)),not(queue(X,Y)),!,writeln('truly added'),assert(queue(X,Y)),printQueue.
addToQueue(_,_,_,_):-true.

getNextFromQueue(W,H):-queue(X,Y),!,retract(queue(X,Y)),visit(X,Y,W,H).
getNextFromQueue(_,_):-true.

/*
addNextToQueue(X,Y,W,H):-X1 is X-1,Y1 is Y-1,X2 is X+1,Y2 is Y+1,(not(isSafe(X,Y)),not(isSafe(X1,Y)),!,true;addToQueue(X1,Y,W,H)),(not(isSafe(X,Y)),not(isSafe(X,Y1)),!,true;addToQueue(X,Y1,W,H)),(not(isSafe(X,Y)),not(isSafe(X,Y2)),!,true;addToQueue(X,Y2,W,H)),(not(isSafe(X,Y)),not(isSafe(X2,Y)),!,true;addToQueue(X2,Y,W,H)).
*/
addNextToQueue(X,Y,W,H):-X1 is X-1,Y1 is Y-1,X2 is X+1,Y2 is Y+1,(isSafe(X,Y),!,addToQueue(X1,Y,W,H);true),(isSafe(X,Y),!,addToQueue(X,Y1,W,H);true),(isSafe(X,Y),!,addToQueue(X,Y2,W,H);true),(isSafe(X,Y),!,addToQueue(X2,Y,W,H);true).

logAddingToQueue(X,Y):-write('adding to queue '),write(X),write(' '),writeln(Y).
logVisiting(X,Y):-write('visiting '),write(X),write(' '),writeln(Y).
printQueue:-findall([X,Y],queue(X,Y),L),writeln(L).

isSafe(X,Y):-X1 is X-1,Y1 is Y-1,X2 is X+1,Y2 is Y+1,not(field(X1,Y,84)),not(field(X,Y1,84)),not(field(X,Y2,84)),not(field(X2,Y,84)).

isGoldSafe(X,Y):-X1 is X-1,Y1 is Y-1,X2 is X+1,Y2 is Y+1,not(field(X1,Y,84)),not(field(X,Y1,84)),not(field(X,Y2,84)),not(field(X2,Y,84)).

visit(X,Y,W,H):-logVisiting(X,Y),(visited(X,Y),!,getNextFromQueue(W,H);(field(X,Y,84),!,assert(visited(X,Y)),getNextFromQueue(W,H);field(X,Y,35),!,assert(visited(X,Y)),getNextFromQueue(W,H);field(X,Y,71),!,assert(visited(X,Y)),foundGold(Old),retract(foundGold(Old)),NewGold is Old+1,assert(foundGold(NewGold)),addNextToQueue(X,Y,W,H),getNextFromQueue(W,H);assert(visited(X,Y)),addNextToQueue(X,Y,W,H),getNextFromQueue(W,H))).

main:-readUInt(W),readUInt(H),assert(field(-1,-1,35)),assert(queue(-1,-1)),assert(visited(-1,-1)),assert(foundGold(0)),readField(0,H,W),field(X,Y,80),visit(X,Y,W,H),foundGold(Gold),writeln(Gold).