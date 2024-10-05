readWord(Word):-readWord([],Word).
readWord(Current,Word):-at_end_of_stream,!,Word = Current.
readWord(Current,Word):-get0(Ch),(Ch<33,!,Word = Current;append(Current,[Ch],NewC),readWord(NewC,Word)).

readData(Current,Result):-get0(Ch),(Ch is 10,!,Result = Current;append(Current,[Ch],NewC),readData(NewC,Result)).

readWords([]):-readWord(Word),(Word = [],!,writeln('True');writeln('False')).
readWords([H|T]):-readWord(Word),(Word=[],!,writeln('False');(know(H),!,(know(H,Word),know(Word,H),!,readWords(T);writeln('False'));(know(Word),!,writeln('False');assert(know(H)),assert(know(Word)),assert(know(H,Word)),assert(know(Word,H)),readWords(T)))).

main:-readData([],Data),assert(know(-1)),assert(know(-1,[])),readWords(Data).