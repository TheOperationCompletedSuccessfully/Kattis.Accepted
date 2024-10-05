solve(0):-get0(Ch),(Ch is 97,!,write('a'),solve(1);solve(0)).
solve(1):-at_end_of_stream,!.
solve(1):-get0(Ch),(Ch is 10,!,true;char_code(C,Ch),write(C),solve(1)).

main:-solve(0).