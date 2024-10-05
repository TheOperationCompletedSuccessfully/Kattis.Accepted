readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

even(N):-R is N rem 4,R is 0.
odd(N):-R is N rem 4,R is 2.
main:-readUInt(N),(even(N),!,writeln('Even');odd(N),!,writeln('Odd');writeln('Either')).