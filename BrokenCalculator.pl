:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

calc(43,A,B,P,Result):-!,Result is A+B-P.
calc(45,A,B,P,Result):-!,Result is P*(A-B).
calc(42,A,B,_,Result):-!,Result is A*B*A*B.
calc(47,A,_,_,Result):-!,Result is (A+1)//2.

readOp(Result):-get0(Ch),(Ch is 32,!,readOp(Result);Result is Ch).

solve(N,N).
solve(I,N):-II is I+1,readUInt(A),readOp(Op),readUInt(B),previous(P),calc(Op,A,B,P,Result),retract(previous(P)),assert(previous(Result)),bufferedWriteln(Result),solve(II,N).

main:-initiateBufferedRead(32768),readUInt(N),assert(previous(1)),solve(0,N).