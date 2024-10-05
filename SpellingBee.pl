readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPending:-at_end_of_stream,!,true.
readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readAndCheck(0,I,Data):-get0(Ch),I1 is I+1,(Ch is 10,!,true;important(Ch),!,append(Data,[Ch],NewData),readAndCheck(1,I1,NewData);know(Ch),!,append(Data,[Ch],NewData),readAndCheck(0,I1,NewData);readPending).
readAndCheck(1,I,Data):-get0(Ch),I1 is I+1,(Ch is 10,!,(I>=4,!,writeAnswer(Data);true);know(Ch),!,append(Data,[Ch],NewData),readAndCheck(1,I1,NewData);readPending).

writeAnswer([]):-!,nl.
writeAnswer([Head|Tail]):-char_code(Ch,Head),write(Ch),writeAnswer(Tail).
solve(N,N).
solve(I,N):-I1 is I+1,readAndCheck(0,0,[]),solve(I1,N).

main:-get0(Ch0),assert(important(Ch0)),assert(know(Ch0)),get0(Ch1),assert(know(Ch1)),get0(Ch2),assert(know(Ch2)),get0(Ch3),assert(know(Ch3)),get0(Ch4),assert(know(Ch4)),get0(Ch5),assert(know(Ch5)),get0(Ch6),assert(know(Ch6)),readUInt(N),solve(0,N).