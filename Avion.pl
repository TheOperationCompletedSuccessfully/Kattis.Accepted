valid(0,'F').
valid(1,'B').
valid(2,'I').

readPendingLine:-at_end_of_stream,!,true.
readPendingLine:-get0(Ch),(Ch is 10,!,true;readPendingLine).
readLine(I,3,_,Data):-!,append(Data,[I],NewData),readPendingLine,II is I+1,readLine(II,0,0,NewData).
readLine(_,_,_,Data):-at_end_of_stream,!,writeResult(Data).
readLine(I,Found,_,Data):-get0(Ch),(Ch is 10,!,II is I+1,readLine(II,0,10,Data);char_code(C,Ch),(valid(Found,C),!,F is Found+1,readLine(I,F,Ch,Data);readLine(I,0,Ch,Data))).

writeSubResults([]).
writeSubResults([H|T]):-(T=[],!,write(H);write(H),write(' ')),writeSubResults(T).

writeResult([]):-!,writeln('HE GOT AWAY!').
writeResult(Data):-writeSubResults(Data).

main:-readLine(1,0,0,[]).