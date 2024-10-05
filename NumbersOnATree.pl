readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

printResult(Root,Current,Level):-Result is Root - 2^(Level)+2 - Current - 1,writeln(Result).

solve(Root,Current,Level):-at_end_of_stream,!,printResult(Root,Current,Level).
solve(Root,Current,Level):-get0(Ch),(Ch<76,!,printResult(Root,Current,Level);Ch is 76,!,NewCurrent is Current*2,NewLevel is Level +1,solve(Root,NewCurrent,NewLevel);Ch is 82,!,NewCurrent is Current*2+1,NewLevel is Level +1,solve(Root,NewCurrent,NewLevel)).

main:-readUInt(TreeHeight),Root is 2^(TreeHeight+1)-1,solve(Root,0,0).