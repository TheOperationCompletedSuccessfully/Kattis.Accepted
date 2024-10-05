readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPending:-at_end_of_stream,!,true.
readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readColumn(N,N,_,_,CurrentWord,Current,Result):-!,(CurrentWord=[],!,Result = Current; append(Current,[CurrentWord],Result)).
readColumn(I,N,Column,PrevChar,CurrentWord,Current,Result):-crosswordItem(Ch,Column,I),(Ch is 35,!,(CurrentWord =[],!,NewCurrent = Current;append(Current,[CurrentWord],NewCurrent)),NewWord = [],NewPrevChar is Ch;PrevChar is 35,!,NewPrevChar is Ch,NewWord = CurrentWord,NewCurrent = Current;PrevChar is 0,!,NewPrevChar is 0,append(CurrentWord,[Ch],NewWord),NewCurrent = Current;append(CurrentWord,[PrevChar,Ch],NewWord),NewCurrent=Current,NewPrevChar is 0),I1 is I+1,readColumn(I1,N,Column,NewPrevChar,NewWord,NewCurrent,Result).

readVerticalData(N,_,N,Current,Result):-!,Result = Current.
readVerticalData(I,N,ColumnNumber,Current,Result):-I1 is I+1,readColumn(0,N,I,35,[],[],RowData),(RowData = [],!,NewC = Current;append(Current,RowData,NewC)),readVerticalData(I1,N,ColumnNumber,NewC,Result).

readRow(N,N,_,_,CurrentWord,Current,Result):-!,(CurrentWord=[],!,Result = Current; append(Current,[CurrentWord],Result)).
readRow(I,N,Row,PrevChar,CurrentWord,Current,Result):-get0(Ch),(Ch is 35,!,(CurrentWord =[],!,NewCurrent = Current;append(Current,[CurrentWord],NewCurrent)),NewWord = [],NewPrevChar is Ch;PrevChar is 35,!,NewPrevChar is Ch,NewWord = CurrentWord,NewCurrent = Current;PrevChar is 0,!,NewPrevChar is 0,append(CurrentWord,[Ch],NewWord),NewCurrent = Current;append(CurrentWord,[PrevChar,Ch],NewWord),NewCurrent=Current,NewPrevChar is 0),assert(crosswordItem(Ch,I,Row)),I1 is I+1,readRow(I1,N,Row,NewPrevChar,NewWord,NewCurrent,Result).

readData(N,_,N,Current,Result):-!,Result = Current.
readData(I,N,RowNumber,Current,Result):-I1 is I+1,readRow(0,N,I,35,[],[],RowData),readPending,(RowData = [],!,NewC = Current;append(Current,RowData,NewC)),readData(I1,N,RowNumber,NewC,Result).

writeAnswer([]).
writeAnswer([Head|Tail]):-char_code(Ch,Head),write(Ch),writeAnswer(Tail).

main:-readUInt(R),readUInt(C),readData(0,C,R,[],Data),!,readVerticalData(0,R,C,Data,NewData),!,sort(NewData,Sorted),Sorted = [Head|_],writeAnswer(Head).