:-use_module(moduleMyNumbers, [readUInt/1,readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readData(N,N,Max,Max).
readData(I,N,Current,Max):-get0(Ch),(Ch is 10,!,II is I+1,maxl(Prev),NM is max(Current,Prev),retract(maxl(Prev)),assert(maxl(NM)), NewMax is 0;NewMax is Current+1,II is I,assert(word(I,Current,Ch))),readData(II,N,NewMax,Max).

calcSum(_,N,N,Sum,Sum,C,C).
calcSum(Index,I,N,S,Sum,CC,C):-II is I+1,(word(I,Index,Ch),!,NewS is S+Ch,NewCC is CC+1;NewS is S,NewCC is CC),calcSum(Index,II,N,NewS,Sum,NewCC,C).

calc(N,N,_).
calc(I,N,WN):-II is I+1,calcSum(I,0,WN,0,Sum,0,C),Ch is Sum//C, assert(result(I,Ch)),calc(II,N,WN).

writeAnswer(N,N).
writeAnswer(I,N):-II is I+1,result(I,Ch),char_code(C,Ch),bufferedWrite(C),writeAnswer(II,N).

main:-initiateBufferedRead(65536),readUInt(N),assert(maxl(-1)),readData(0,N,0,_),maxl(Max),calc(0,Max,N),writeAnswer(0,Max),nl.