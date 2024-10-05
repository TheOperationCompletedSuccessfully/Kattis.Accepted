writeAnswer(Word):-writePrefix,writeInner(Word),writeEnd.

writePrefix:-write('Thank you, ').
writeEnd:-write(', and farewell!').

writeInner([]).
writeInner([Head|Tail]):-char_code(Code,Head),write(Code),writeInner(Tail).

main(Word):-at_end_of_stream,!,writeAnswer(Word).
main(Word):-get0(Ch),(Ch<32,!,writeAnswer(Word);append(Word,[Ch],NewWord),main(NewWord)).
main:-main([]).