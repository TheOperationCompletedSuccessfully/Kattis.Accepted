readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

printFail:-!,writeln(0).

checkColumns(N,N):-!,writeln(1).
checkColumns(I,N):-II is I+1,columnData(I,D),(abs(D)<4,!,checkColumns(II,N);printFail).

solveRow(N,N,Sum,Sum,SS,SS).
solveRow(I,N,Current,Result,NC,SS):-II is I+1,get0(Ch),(Ch is 66,!,C is -1;C is 1),NewCurrent is Current+C,NN is NC*C,(NN<0,abs(NC)<4,!,NewNC is C;abs(NC)<4,!,NewNC is 2*NC+C;NewNC is NC),(columnData(I,D),!,DD is D*C,(DD<0,abs(D)<4,!,NewD is C;abs(D)<4,!,NewD is 2*D+C;NewD is D),retract(columnData(I,D)),assert(columnData(I,NewD));assert(columnData(I,C))),solveRow(II,N,NewCurrent,Result,NewNC,SS).

readPending:-at_end_of_stream,!,true.
readPending:-get0(Ch),(Ch is 10,!,true;readPending).

solveMatrix(N,N):-!,checkColumns(0,N).
solveMatrix(I,N):-II is I+1,solveRow(0,N,0,Sum,0,SS),readPending,(Sum is 0,abs(SS)<4,!,solveMatrix(II,N);printFail).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(N),assert(columnData(-1,-1)),solveMatrix(0,N).