readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,_,Current,Result):-!,Result is Current.
solve(I,N,Size,Current,Result):-NextSize is Size+2,NextBlock is NextSize*NextSize,(I+NextBlock>N,!,Result is Current;I1 is I+NextBlock,NewC is Current+1,solve(I1,N,NextSize,NewC,Result)). 
main:-readUInt(Blocks),solve(1,Blocks,1,1,Result),writeln(Result).