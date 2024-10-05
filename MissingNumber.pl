readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPendingLine:-get0(Ch),(Ch is 10;readPendingLine).

readData(100,100).
readData(I,Result):-I<10,!,II is I+1,get0(Ch),(I is Ch-48,!,readData(II,Result);Result is I).
readData(I,Result):-I>9,I<100,at_end_of_stream,!,Result is I.
readData(I,Result):-I>9,I<100,II is I+1,get0(Ch1),(Ch1 is 10,!,Result is I;get0(Ch2),!,(I is 10*(Ch1-48)+Ch2-48,!,readData(II,Result);Result is I)).


main:-readUInt(_),readData(1,Answer),(var(Answer),!,writeln(100);writeln(Answer)).