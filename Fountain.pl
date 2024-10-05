readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPending:-at_end_of_stream,!,true.
readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readData(Columns,Columns,Rows,Rows,Current,Result):-!,Result = Current.
readData(Columns,Columns,J,Rows,Current,Result):-!,readPending,J1 is J+1,readData(0,Columns,J1,Rows,Current,Result).
readData(I,Columns,J,Rows,Current,Result):-I1 is I+1,get0(Ch),assert(field(I,J,Ch)),(Ch is 86,!,append(Current, [[I,J]],NewC);NewC = Current),readData(I1,Columns,J,Rows,NewC,Result).

flowLeft([[0,R]|Tail],_,_,NewWater):-!,NewWater = [[0,R]|Tail].
flowLeft([[I,Rows]|Tail],Rows,_,NewWater):-!,NewWater = [[I,Rows]|Tail].
flowLeft([[I,J]|Tail],_,_,NewWater):-NextRow is J+1,PreviousColumn is I-1,(field(I,NextRow,35),field(PreviousColumn,J,46),!,retract(field(PreviousColumn,J,46)),assert(field(PreviousColumn,J,86)),append([[I,J]|Tail],[[PreviousColumn,J]],NewWater);NewWater = [[I,J]|Tail]).

flowRight([[Columns,J]|Tail],_,Columns,NewWater):-!,NewWater = [[Columns,J]|Tail].
flowRight([[I,Rows]|Tail],Rows,_,NewWater):-!,NewWater = [[I,Rows]|Tail].
flowRight([[I,J]|Tail],_,_,NewWater):-NextRow is J+1,NextColumn is I+1,(field(I,NextRow,35),field(NextColumn,J,46),!,retract(field(NextColumn,J,46)),assert(field(NextColumn,J,86)),append([[I,J]|Tail],[[NextColumn,J]],NewWater);NewWater = [[I,J]|Tail]).

flowDown([[_,Rows]|Tail],Rows,_,NewWater):-!,NewWater = Tail.
flowDown([[I,J]|Tail],_,_,NewWater):-NextRow is J+1,(field(I,NextRow,46),!,retract(field(I,NextRow,46)),assert(field(I,NextRow,86)),append(Tail,[[I,NextRow]],NewWater);NewWater = Tail).

waterFlow([],_,_).
waterFlow(Water,Columns,Rows):-flowLeft(Water,Rows,Columns,NewWater1),flowRight(NewWater1,Rows,Columns,NewWater2),flowDown(NewWater2,Rows,Columns,NewWater3),waterFlow(NewWater3,Columns,Rows).

writeAnswer(Columns,Columns,Rows,Rows).
writeAnswer(Columns,Columns,J,Rows):-!,NextRow is J+1,nl,writeAnswer(0,Columns,NextRow,Rows).
writeAnswer(I,Columns,J,Rows):-field(I,J,Ch),char_code(C,Ch),write(C),NextColumn is I+1,writeAnswer(NextColumn,Columns,J,Rows).

main:-readUInt(Rows),RR is Rows-1,readUInt(Columns),assert(field(-1,-1,46)),readData(0,Columns,0,RR,[],Water),waterFlow(Water,Columns,RR),writeAnswer(0,Columns,0,RR).