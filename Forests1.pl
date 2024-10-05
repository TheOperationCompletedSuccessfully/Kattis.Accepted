readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);II is Ch-48,readUInt(II,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;II is I*10+Ch-48,readUInt(II,R)).

assignNewOpinion(OldOpinion,NewOpinion):-(data(OldOpinion,OldCount),!,retract(data(OldOpinion,OldCount));OldCount is 1),NewC is OldCount-1,(NewC is 0,!,true;assert(data(OldOpinion,NewC))),(data(NewOpinion,NCount),!,retract(data(NewOpinion,NCount)),NewCount is NCount+1;NewCount is 1),assert(data(NewOpinion,NewCount)).
stream_lines(In, Lines) :-
    read_string(In, _, Str),
    split_string(Str, "\n ", "\n ", Lines).

readData([]).
readData([P,O|T]):-atom_number(P, Person),atom_number(O, Opinion),(person(Person,OldOpinion),!,retract(person(Person,OldOpinion));OldOpinion = [0,0]),OldOpinion=[A,B],(Opinion=<50,!,NewA is A,NewB is B+(2**Opinion);NewA is A+(2**(Opinion-50)),NewB is B),NewOpinion = [NewA,NewB],assert(person(Person,NewOpinion)),assignNewOpinion(OldOpinion,NewOpinion),readData(T).

main:-readUInt(P),readUInt(_),assert(person(-1,[0,0])),assert(data([0,0],0)),(at_end_of_stream,!,RR is 1;stream_lines(user_input, Lines),readData(Lines),retractall(data([0,0],_)),retractall(person(-1,_)),aggregate_all(count,PI,person(PI,_),PR),aggregate_all(count,Index,data(Index,_),Result),(PR<P,!,RR is Result+1;RR is Result)),writeln(RR).