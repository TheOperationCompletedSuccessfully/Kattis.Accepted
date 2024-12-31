:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

funcKind(N,M,1,Result):-funcKind(1,N,M,[1],1,Result).
funcKind(N,M,2,Result):-funcKind(0,N,M,[2],1,Result).
funcKind(N,M,3,Result):-funcKind2(0,3,M,N,N,Result).
funcKind(N,M,4,Result):-funcKind2(0,2,M,N,N,Result).
funcKind(N,M,5,Result):-funcKind2(0,1,M,N,N,Result).
funcKind(N,M,6,Result):-K is M/N,(K=<50,!,KK is 2^K,(KK >= N,!,Result is 1; Result is -1);Result is 1).
funcKind(N,M,7,Result):-funcKind2(0,0,M,1,N,Result).

funcKind(N,N,M,[1],Current,Result):-NewC is Current*N,!,Result is M-NewC.
funcKind(_,_,M,_,Current,Result):-Current > M,!,Result is -1.
funcKind(I,N,M,[1],Current,Result):-II is I+1, NewC is Current*I,funcKind(II,N,M,[1],NewC,Result).

funcKind(N,N,M,[2],Current,Result):-!,Result is M-Current.
funcKind(I,N,M,[2],Current,Result):-II is I+1, NewC is 2*Current, funcKind(II,N,M,[2],NewC,Result).

funcKind2(N,N,M,_,Current,Result):-!,Result is M-Current.
funcKind2(I,N,M,C,Current,Result):-II is I+1, NewC is Current*C, funcKind2(II,N,M,C,NewC,Result).

main:-initiateBufferedRead(256),readUInt(M),readUInt(N),readUInt(Kind),funcKind(N,M,Kind,Result),(Result<0,!,bufferedWriteln('TLE');bufferedWriteln('AC')).