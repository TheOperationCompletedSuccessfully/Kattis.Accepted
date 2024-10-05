readWord(Word):-readWord([],Word).
readWord(I,W):-at_end_of_stream,!,W = I.
readWord(I,W):-get0(Ch),(Ch<97,!,W = I;append([Ch],I,II),readWord(II,W)).

printList([]).
printList([H|T]):-char_code(Ch,H),write(Ch),printList(T).

printItem(A,B,I,List):-A is B+I,!,printList(List).
printItem(A,B,I,List):-write(' '),I1 is I+1, printItem(A,B,I1,List).

printResult(_,[]).
printResult(M,[H|T]):-length(H,HL),reverse(H,HR),printItem(M,HL,0,HR),nl,printResult(M,T).

main(Data,MaxLength,0):-nl,main(Data,MaxLength).
main(Data,MaxLength):-at_end_of_stream,(MaxLength is 0;msort(Data,Result),printResult(MaxLength,Result)).
main(Data,MaxLength):-readWord(NewWord),(NewWord = [],!,msort(Data,Result),printResult(MaxLength,Result),main([],0,0);length(NewWord,L),NewMax is max(L,MaxLength),append(Data,[NewWord],NewData),main(NewData,NewMax)).
main:-at_end_of_stream.
main:-main([],0).
