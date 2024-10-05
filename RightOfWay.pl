valid(78).
valid(83).
valid(69).
valid(87).

valid(83,87,69).
valid(69,83,78).
valid(78,69,87).
valid(87,78,83).

valid(83,87,78).
valid(69,83,87).
valid(78,69,83).
valid(87,78,69).

valid(83,78,69).
valid(69,87,78).
valid(78,83,87).
valid(87,69,83).


readData(Current,Result):-Current = [_,_,_],!,Result = Current.
readData(Current,Result):-get0(Ch),(valid(Ch),!,append(Current,[Ch],NewCurrent),readData(NewCurrent,Result);readData(Current,Result)).

main:-readData([],Result),Result = [A,B,C],(valid(A,B,C),!,writeln('Yes');writeln('No')).