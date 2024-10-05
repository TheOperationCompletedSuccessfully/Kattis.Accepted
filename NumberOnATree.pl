readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(Data):-at_end_of_stream,!,writeln(Data).
solve(Data):-get0(Ch),(Ch<76,!,writeln(Data);Ch is 76,!,NewData is Data - 2,solve(NewData);Ch is 82,!,NewData is Data-1,solve(NewData)).

main:-readUInt(TreeHeight),Root is 2^(TreeHeight+1)-1,solve(Root).