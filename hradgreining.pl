valid(67,0).
valid(79,1).
valid(86,2).

readData(3):-!,writeln('Veikur!').
readData(_):-at_end_of_stream,!,writeln('Ekki veikur!').
readData(I):-get0(Ch),(Ch is 10,!,writeln('Ekki veikur!');valid(Ch,I),!,II is I+1,readData(II);valid(Ch,0),!,readData(1);readData(0)).

main:-readData(0).