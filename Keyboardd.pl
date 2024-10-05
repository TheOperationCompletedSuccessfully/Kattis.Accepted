scrollList([Head|Tail],Head,Tail).
scrollList([Head|Tail],A,Result):-scrollList(Tail,A,Result).

simpleCheck([],[],Current,Result):-!,Result = Current.
simpleCheck([],[B|_],Current,Result):-!,append(Current,[B],NewCurrent),simpleCheck([],[],NewCurrent,Result).
simpleCheck([Head|Tail],[Head|T],Current,Result):-!,simpleCheck(Tail,T,Current,Result).
simpleCheck([A|Tail],[B|T],Current,Result):-append(Current,[B],NewCurrent),scrollList(T,A,ResultT),simpleCheck(Tail,ResultT,NewCurrent,Result).

readData(Current,Result):-at_end_of_stream,!,Result = Current.
readData(Current,Result):-get0(Ch),(Ch<32,!,Result=Current;append(Current,[Ch],NewCurrent),readData(NewCurrent,Result)).

printResult([]).
printResult([Head|Tail]):-char_code(Ch,Head),write(Ch),printResult(Tail).
main:-readData([],Original),readData([],Sticky),msort(Original,OriginalSorted),msort(Sticky,StickySorted),simpleCheck(OriginalSorted,StickySorted,[],Keys),printResult(Keys).