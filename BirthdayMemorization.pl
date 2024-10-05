readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

getAnswers([],Current,Result):-!,Result = Current.
getAnswers([Head|Tail],Current,Result):-data(Name,_,Head),append(Current,[Name],NewCurrent),getAnswers(Tail,NewCurrent,Result).

readName(Current,Result):-at_end_of_stream,!,Result = Current.
readName(Current,Result):-get0(Ch),(Ch is 10,!,Result = Current;Ch is 32,!,Result = Current;append(Current,[Ch],NewCurrent),readName(NewCurrent,Result)).

readData(N,N,Current,Result):-!,Result = Current.
readData(I,N,Current,Result):-I1 is I+1,readName([],Name),readUInt(Score),readName([],Date),(data(AN,S,Date),!,(S<Score,!,retract(data(AN,S,Date)),assert(data(Name,Score,Date)),NewCurrent = Current;NewCurrent = Current);assert(data(Name,Score,Date)),append(Current,[Date],NewCurrent)),readData(I1,N,NewCurrent,Result).

writeList([]).
writeList([Head|Tail]):-char_code(Ch,Head),write(Ch),writeList(Tail).

writeAnswer([]).
writeAnswer([Head|Tail]):-writeList(Head),nl,writeAnswer(Tail).

main:-readUInt(N),assert(data([],-1,[])),readData(0,N,[],Dates),length(Dates,Answer),writeln(Answer),getAnswers(Dates,[],Names),sort(Names,Sorted),writeAnswer(Sorted).