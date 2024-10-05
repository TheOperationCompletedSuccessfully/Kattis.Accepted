vowel(65).
vowel(69).
vowel(73).
vowel(79).
vowel(85).
vowel(97).
vowel(101).
vowel(105).
vowel(111).
vowel(117).


main(Count):-at_end_of_stream,!,writeln(Count).
main(Count):-get0(Ch),(Ch<32,!,writeln(Count);vowel(Ch),!,C is Count+1,main(C);main(Count)).
main:-main(0).