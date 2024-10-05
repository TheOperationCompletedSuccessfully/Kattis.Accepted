readData(Current,Result):-at_end_of_stream,!,Result = Current.
readData(Current,Result):-get0(Ch),(Ch is 10,!,Result = Current;append([Ch],Current,NewCurrent),readData(NewCurrent,Result)).
main:-readData([],Words),(Words = [63,104,101|_],!,writeln('Canadian!');writeln('Imposter!')).