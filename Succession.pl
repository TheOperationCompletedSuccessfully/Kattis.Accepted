:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readWord(Word):-readWord([],Word).
readWord(I,W):-get0(Ch),(Ch<33,!,W = I;append(I,[Ch],II),readWord(II,W)).

readData(N,N).
readData(I,N):-II is I+1,readWord(Child),readWord(Parent1),readWord(Parent2),assert(family(Child,Parent1,Parent2)),readData(II,N).

traceClaim(Claim):-(blood(_,Claim),!,true;family(Claim,Parent1,Parent2),!,traceClaim(Parent1),traceClaim(Parent2),blood(P1,Parent1),blood(P2,Parent2),P is (P1+P2)/2,assert(blood(P,Claim));assert(blood(0,Claim))).

readNames(N,N,Max,Max).
readNames(I,N,Current,Result):-II is I+1,readWord(Claim),traceClaim(Claim),blood(B,Claim),Current=[C|_],(B>C,!,NewC = [B,Claim];NewC = Current),readNames(II,N,NewC,Result).

printName([]):-!,nl.
printName([H|T]):-char_code(Ch,H),bufferedWrite(Ch),printName(T).

main:-initiateBufferedRead(16384),readUInt(N),readUInt(M),readWord(King),assert(blood(1,King)),readData(0,N),readNames(0,M,[0,[]],MaxClaim),MaxClaim = [_,Result],printName(Result).
