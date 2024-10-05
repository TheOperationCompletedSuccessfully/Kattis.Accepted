readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

printRow(N,N).
printRow(I,N):-II is I+1,bufferedWrite(' '),printRow(II,N).

printRows(N,N).
printRows(I,N):-II is I+1,bufferedWrite('|'),printRow(0,N),bufferedWriteln('|'),printRows(II,N).

printHRow(N,N).
printHRow(I,N):-II is I+1,bufferedWrite('-'),printHRow(II,N).

bufferedWrite(C):-with_output_to(user_output,write(C)).
bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-readUInt(N),bufferedWrite('+'),printHRow(0,N),bufferedWriteln('+'),printRows(0,N),bufferedWrite('+'),printHRow(0,N),bufferedWriteln('+').