readUInt(Number):-readUInt(0,Number).
readUInt(I,R):-at_end_of_stream,!,R is I.
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

main:-readUInt(A),readUInt(B),(A<B,!,write(A),write(' '),writeln(B);write(B),write(' '),writeln(A)).