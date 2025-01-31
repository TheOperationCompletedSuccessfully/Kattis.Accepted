:-use_module(moduleMyNumbers, [readUInt/1,readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic classified/0.

classify(Next):-R is Next rem 2,R is 1,assert(classified),bufferedWrite('O'),fail.
classify(Next):-D is truncate(sqrt(Next)),Next is D*D,assert(classified),bufferedWrite('S'),fail.
classify(_):-(not(classified),!,bufferedWriteln('EMPTY');bufferedWriteln('')).

solve(N,N).
solve(I,N):-II is I+1,readUInt(Next),classify(Next),retractall(classified),solve(II,N).

main:-initiateBufferedRead(1048576),readUInt(N),solve(0,N).