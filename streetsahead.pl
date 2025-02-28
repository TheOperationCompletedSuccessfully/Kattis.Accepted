:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readHash(Number):-readHash(-1,Number).
readHash(-1,R):-!,get0(Ch),(Ch <97,!,readHash(-1,R);I1 is Ch-96,readHash(I1,R)).
readHash(I,R):-get0(Ch),(Ch <97,!,R is I;I1 is I*27+Ch-96,readHash(I1,R)).

readStreets(N,N).
readStreets(I,N):-II is I+1,readHash(NextStreet),assert(street(I,NextStreet)),readStreets(II,N).

readDrivers(N,N).
readDrivers(I,N):-II is I+1,readHash(StartStreet),street(StartIndex,StartStreet),readHash(EndStreet),street(EndIndex,EndStreet),Result is max(0,abs(EndIndex-StartIndex)-1),bufferedWriteln(Result),readDrivers(II,N).

main:-initiateBufferedRead(4194304),readUInt(Streets),readUInt(Drivers),readStreets(0,Streets),readDrivers(0,Drivers).