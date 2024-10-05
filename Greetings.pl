myecho(101):-!,write('e'),write('e').
myecho(Ch):-char_code(C,Ch),write(C).

main:-at_end_of_stream,!.
main:-get0(Ch),myecho(Ch),main.