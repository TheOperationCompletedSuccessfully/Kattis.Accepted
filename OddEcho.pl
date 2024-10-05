readInt(Number):-readInt(0,Number).
readInt(0,R):-!,get0(Ch),(Ch is 45,!,readInt(0,R1),R is -1*R1;Ch <48,!,readInt(0,R);I1 is Ch-48,readInt(I1,R)).
readInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readInt(I1,R)).

readWord(CurrentData,Result):-at_end_of_stream,!,Result = CurrentData.
readWord(CurrentData,Result):-get0(Ch),(Ch<65,!,Result = CurrentData;append(CurrentData,[Ch],NewC),readWord(NewC,Result)).

printData([]):-!,writeln('').
printData([Head|Tail]):-char_code(C,Head),write(C),printData(Tail).

solve(N,N).
solve(I,N):-I1 is I+1, readWord([],Word),R is rem(I1,2),(R is 0,!,true;printData(Word)),solve(I1,N).

main:-readInt(Cases),solve(0,Cases).