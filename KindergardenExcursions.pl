readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(_,_,ZerosToTheirPositions,TwoesToTheirPositions,ZeroTwoEncounters,_,Z,T,ZT20):-at_end_of_stream,!,Z is ZerosToTheirPositions,T is TwoesToTheirPositions,ZT20 is ZeroTwoEncounters.
solve(NonZeroCount,TwoCount,ZerosToTheirPositions,TwoesToTheirPositions,ZeroTwoEncounters,First2Met,Z,T,ZT20):-get0(Ch),(Ch < 48,!,Z is ZerosToTheirPositions,T is TwoesToTheirPositions,ZT20 is ZeroTwoEncounters;solve(Ch,NonZeroCount,TwoCount,ZerosToTheirPositions,TwoesToTheirPositions,ZeroTwoEncounters,First2Met,Z,T,ZT20)).

solve(48,NonZeroCount,TwoCount,ZerosToTheirPositions,TwoesToTheirPositions,ZeroTwoEncounters,0,Z,T,ZT20):-NewZerosToTheirPositions is ZerosToTheirPositions + NonZeroCount,NewZeroTwoEncounters is ZeroTwoEncounters + TwoCount,solve(NonZeroCount,TwoCount,NewZerosToTheirPositions,TwoesToTheirPositions,NewZeroTwoEncounters,0,Z,T,ZT20).
solve(48,NonZeroCount,TwoCount,ZerosToTheirPositions,TwoesToTheirPositions,ZeroTwoEncounters,1,Z,T,ZT20):-NewZerosToTheirPositions is ZerosToTheirPositions + NonZeroCount,NewZeroTwoEncounters is ZeroTwoEncounters + TwoCount,NewTwoesToTheirPositions is TwoesToTheirPositions + TwoCount, solve(NonZeroCount,TwoCount,NewZerosToTheirPositions,NewTwoesToTheirPositions,NewZeroTwoEncounters,1,Z,T,ZT20).

solve(49,NonZeroCount,TwoCount,ZerosToTheirPositions,TwoesToTheirPositions,ZeroTwoEncounters,0,Z,T,ZT20):-NewNonZeroCount is NonZeroCount + 1,solve(NewNonZeroCount,TwoCount,ZerosToTheirPositions,TwoesToTheirPositions,ZeroTwoEncounters,0,Z,T,ZT20).
solve(49,NonZeroCount,TwoCount,ZerosToTheirPositions,TwoesToTheirPositions,ZeroTwoEncounters,1,Z,T,ZT20):-NewNonZeroCount is NonZeroCount + 1,NewTwoesToTheirPositions is TwoesToTheirPositions + TwoCount,solve(NewNonZeroCount,TwoCount,ZerosToTheirPositions,NewTwoesToTheirPositions,ZeroTwoEncounters,1,Z,T,ZT20).

solve(50,NonZeroCount,TwoCount,ZerosToTheirPositions,TwoesToTheirPositions,ZeroTwoEncounters,_,Z,T,ZT20):-NewNonZeroCount is NonZeroCount + 1,NewTwoCount is TwoCount + 1,solve(NewNonZeroCount,NewTwoCount,ZerosToTheirPositions,TwoesToTheirPositions,ZeroTwoEncounters,1,Z,T,ZT20).

main:-solve(0,0,0,0,0,0,Z,T,ZT20),Result is Z+T-ZT20,writeln(Result).