readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

valid(36,1).
valid(124,2).
valid(42,3).
valid(98,-1).
valid(106,-3).
valid(116,-2).

readToEnd:-at_end_of_stream,!.
readToEnd:-get0(Ch),(Ch is 10;Ch is -1;readToEnd),!.

solveInner([]):-at_end_of_stream,!,writeln('YES').
solveInner(_):-at_end_of_stream,!,writeln('NO').
solveInner([Head|Tail]):-get0(Ch),(Ch is 46,!,solveInner([Head|Tail]);valid(Ch,C),(C>0,append([C,Head],Tail,Result),solveInner(Result);R is Head + C, (R is 0,!,solveInner(Tail);readToEnd,!,writeln('NO')));Ch is 10,!,writeln('NO')).
solveInner([]):-get0(Ch),(Ch is 46,!,solveInner([]);valid(Ch,C),(C>0,solveInner([C]);readToEnd,!,writeln('NO'));Ch is 10,!,writeln('YES')).
solveInner:-get0(Ch),(Ch is 46,!,solveInner([]);valid(Ch,C),(C>0,solveInner([C]);readToEnd,!,writeln('NO'))).


solve(N,N).
solve(I,N):-I1 is I+1,solveInner,solve(I1,N).
main:-readUInt(Cases),solve(0,Cases).