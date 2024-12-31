:-use_module(moduleMyNumbers, [readUInt/1,readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).
/*
move 1 to target, move 2 to target,
move 1 to 2, move 2 to target, move 1 to target,
move 2 to 1 move 1 to target, move 2 to target
move 2 to target, move 1 to target
*/
solve1(M,MTarget,L,LTarget,Result):-Result1 is abs(M) + abs(MTarget-M),Result2 is Result1 + abs(L-MTarget) + abs(LTarget-L),Result = [Result1,Result2].
solve2(M,MTarget,L,LTarget,Result):-Result2 is abs(M) + abs(L-M) + abs(LTarget-L), Result1 is Result2 + abs(LTarget-L)+abs(MTarget-L),Result = [Result1,Result2].
solve3(M,MTarget,L,LTarget,Result):-Result1 is abs(L) + abs(L-M) + abs(MTarget-M), Result2 is Result1 + abs(MTarget-M)+abs(LTarget-M),Result = [Result1,Result2].
solve4(M,MTarget,L,LTarget,Result):-Result2 is abs(L) + abs(LTarget-L),Result1 is Result2 + abs(M-LTarget) + abs(MTarget-M),Result = [Result1,Result2].

solve(M,MTarget,L,LTarget,Result):-solve1(M,MTarget,L,LTarget,Result1),solve2(M,MTarget,L,LTarget,Result2),solve3(M,MTarget,L,LTarget,Result3),solve4(M,MTarget,L,LTarget,Result4),Result=[Result1,Result2,Result3,Result4].

checkOptions([],_,_):-!,bufferedWriteln('impossible').
checkOptions([[MReal,LReal]|T],MTarget,LTarget):-(MReal=<MTarget,LReal=<LTarget,!,bufferedWriteln('possible');checkOptions(T,MTarget,LTarget)).

main:-initiateBufferedRead(256),readInt(M),readInt(L),readInt(MTarget),readInt(LTarget),readUInt(MTargetTime),readUInt(LTargetTime),solve(M,MTarget,L,LTarget,Options),checkOptions(Options,MTargetTime,LTargetTime).