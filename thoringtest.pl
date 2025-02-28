:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readHash(Number):-readHash(-1,Number).
readHash(-1,R):-!,get0(Ch),(Ch <65,!,readHash(-1,R);Ch>90,!,C is Ch-32,I1 is C-64,readHash(I1,R);I1 is Ch-64,readHash(I1,R)).
readHash(I,R):-get0(Ch),(Ch <65,!,R is I;Ch>90,!,C is Ch-32,I1 is I*10+C-64,readHash(I1,R);I1 is I*10+Ch-64,readHash(I1,R)).

readData(N,N).
readData(I,N):-II is I+1,readHash(Next),assert(word(I,Next)),readData(II,N).

readDataAndCheck:-at_end_of_stream,!,bufferedWriteln('Hi, how do I look today?').
readDataAndCheck:-peek_code(Ch),Ch <14,!,bufferedWriteln('Hi, how do I look today?').
readDataAndCheck:-readHash(Next),(word(_,Next),!,readDataAndCheck;bufferedWriteln('Thore has left the chat')).

main:-initiateBufferedRead(131072),readUInt(N),readData(0,N),readDataAndCheck.