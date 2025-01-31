:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

checkAndSave(A,N):-(A>N,!,assert(duplicate(A));registered(A),!,assert(duplicate(A));assert(registered(A))).

readData(N,N,_).
readData(I,N,Expected):-II is I+1,readUInt(A),readUInt(B),checkAndSave(A,Expected),checkAndSave(B,Expected),readData(II,N,Expected).

main:-initiateBufferedRead(2097152),readUInt(N),K is 1+N//2,assert(registered(-1)),readData(0,K,N),findall(X,duplicate(X),L),msort(L,Sorted),(Sorted=[A,B],bufferedWrite(A),bufferedWrite(' '),bufferedWriteln(B);Sorted=[C],!,bufferedWrite(C),bufferedWrite(' '),bufferedWriteln(C)).