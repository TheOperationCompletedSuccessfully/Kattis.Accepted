:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

assertFirstStats(N,N).
assertFirstStats(I,N):-II is I+1,assert(firstStats(I,0)),assertFirstStats(II,N).

readWord(CF,First,CL,Last,Current,Result):-at_end_of_stream,!,First is CF,Last is CL,Result=Current.
readWord(CF,First,CL,Last,Current,Result):-get0(Ch),(Ch is 10,!,First is CF,Last is CL,Result=Current;CF is 0,!,NewCF is Ch,NewCL is Ch,append(Current,[Ch],NewC),readWord(NewCF,First,NewCL,Last,NewC,Result);NewCL is Ch,append(Current,[Ch],NewC),readWord(CF,First,NewCL,Last,NewC,Result)).
/*
,(lastStats(Last,1),!,retract(lastStats(Last,1)),assert(lastStats(Last,2));lastStats(Last,_),!,true;assert(lastStats(Last,1)))
*/
updateStats(First):-(firstStats(First,I),I<2,!,II is I+1,retract(firstStats(First,I)),assert(firstStats(First,II));true).

readWords(N,N,_,Result,Result).
readWords(I,N,Sign,Current,Result):-II is I+1,(780 is I rem 21,fill_buffer(user_input);true),readWord(0,First,0,Last,[],Data),(Current is -1,First is Sign,!,NewC is I;NewC is Current),assert(word(I,First,Last,Data)),updateStats(First),readWords(II,N,Sign,NewC,Result).

writeResult([]).
writeResult([H|T]):-char_code(Ch,H),write(Ch),writeResult(T).

writeOptimalResult(Data):-writeResult(Data),writeln('!').

findOptimalSolution(_,-1):-!,writeln('?').
findOptimalSolution(Last,Index):-word(Index,Last,L,Data),(firstStats(L,0),!,writeOptimalResult(Data);Last is L,firstStats(L,1),!,writeOptimalResult(Data);firstStats(L,_),!,(word(_,Last,End,AnotherData),(firstStats(End,0),!,writeOptimalResult(AnotherData);End is Last,firstStats(End,1),!,writeOptimalResult(AnotherData));writeResult(Data),nl)).

main:-initiateBufferedRead(16384),readWord(0,First,0,Last,[],Data),assert(initialWord(First,Last,Data)),readUInt(Words),assertFirstStats(97,123),readWords(0,Words,Last,-1,Index),findOptimalSolution(Last,Index).