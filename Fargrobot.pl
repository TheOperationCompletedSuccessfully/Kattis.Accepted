:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic data/1.

solve(N,N).
solve(I,N):-II is I+1,get0(Ch),(data(Ch),!,solve(I,N);assert(data(Ch)),(fullCheck,!,char_code(C,Ch),bufferedWrite(C),resetAll,solve(II,N);solve(I,N))).

resetAll:-retract(data(82)),retract(data(71)),retract(data(66)).
fullCheck:-data(82),data(71),data(66).

main:-initiateBufferedRead(256),readUInt(N),solve(0,N),nl.