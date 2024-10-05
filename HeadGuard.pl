writeAnswer(I,OldChar):-write(I),char_code(Ch,OldChar),writeln(Ch).
getData(I,OldChar):-at_end_of_stream,!,writeAnswer(I,OldChar).
getData(I,OldChar):-get0(Ch),(Ch is 10,!,writeAnswer(I,OldChar),main;Ch is OldChar,!,I1 is I+1,getData(I1,OldChar);write(I),char_code(C,OldChar),write(C),getData(1,Ch)).

main:-at_end_of_stream,!,true.
main:-get0(Ch),getData(1,Ch).
