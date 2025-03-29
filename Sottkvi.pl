:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readAndCountFriends(N,N,_,_,Result,Result).
readAndCountFriends(I,N,K,D,Current,Result):-II is I+1,readUInt(QD),LQ is QD+14,KD is D+K,(KD>=QD,KD<LQ,!,NewC is Current;NewC is Current+1),readAndCountFriends(II,N,K,D,NewC,Result).

main:-initiateBufferedRead(8192),readUInt(N),readUInt(K),readUInt(D),readAndCountFriends(0,N,K,D,0,FC),bufferedWriteln(FC).