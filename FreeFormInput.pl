:-use_module(moduleMyNumbers, [readFloatSafe/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

main(Sum):-at_end_of_stream,!,bufferedWriteln(Sum).
main(Sum):-readFloatSafe(Next),NewSum is Sum+Next,peek_code(Ch),(Ch<32,!,readPending,bufferedWriteln(NewSum),main;get0(_),main(NewSum)).
main:-at_end_of_stream,!,true.
main:-readFloatSafe(Next),peek_code(Ch),(Ch<32,!,readPending,bufferedWriteln(Next),main;get0(_),main(Next)).