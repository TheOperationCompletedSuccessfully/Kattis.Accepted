readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N,Current,Result):-!,Result is Current+1.
solve(I,N,Current,Result):-I>N,!,Result is Current.
solve(I,N,Current,Result):-I1 is I+1,I2 is I+2,I3 is I+3,solve(I1,N,Current,Result1),solve(I2,N,Current,Result2),solve(I3,N,Current,Result3),Result is Result1 + Result2 + Result3.

solveQuick(24,1389537).
solveQuick(23,755476).
solveQuick(22,410744).

main:-readUInt(PlankLength),(PlankLength>21,!,solveQuick(PlankLength,Result);solve(1,PlankLength,0,Result1),solve(2,PlankLength,0,Result2),solve(3,PlankLength,0,Result3), Result is Result1 + Result2 + Result3),writeln(Result).