readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

valid(0,-1).
valid(1,-1).
valid(2,-1).
valid(3,-1).
valid(4,-1).
valid(5,-1).
valid(6,-1).
valid(7,1).
valid(8,-1).
valid(9,-1).
valid(10,-1).
valid(11,-1).
valid(12,-1).
valid(13,-1).
valid(15,-1).
valid(16,-1).
valid(17,1).
valid(18,-1).
valid(19,-1).
valid(14,2).
valid(20,-1).
valid(21,3).
valid(22,-1).
valid(23,-1).
valid(25,-1).
valid(26,-1).
valid(27,1).
valid(28,4).
valid(29,-1).
valid(30,-1).
valid(32,-1).
valid(33,-1).
valid(35,5).
valid(36,-1).
valid(39,-1).
valid(40,-1).
valid(42,6).
valid(43,-1).
valid(46,-1).
valid(49,7).
valid(50,-1).
valid(53,-1).
valid(56,8).
valid(60,-1).
valid(63,9).
valid(70,10).
valid(77,1).

validKK(0,10).
validKK(1,3).
validKK(2,6).
validKK(3,9).
validKK(4,2).
validKK(5,5).
validKK(6,8).
validKK(7,1).
validKK(8,4).
validKK(9,7).

solve(N,N).
solve(I,N):-I1 is I+1,readUInt(K),(valid(K,Answer),!,writeln(Answer);KK is K rem 10,validKK(KK,AnswerRem),!,writeln(AnswerRem);writeln(-1)),solve(I1,N).

main:-readUInt(N),solve(0,N).