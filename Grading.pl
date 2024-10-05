readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(A,_,_,_,_,_,A):-!,writeln('A').
solve(_,B,_,_,_,_,B):-!,writeln('B').
solve(_,_,C,_,_,_,C):-!,writeln('C').
solve(_,_,_,D,_,_,D):-!,writeln('D').
solve(_,_,_,_,E,_,E):-!,writeln('E').
solve(_,_,_,_,_,F,F):-!,writeln('F').
solve(_,_,_,_,E,_,Score):-E-Score>0,!,writeln('F').
solve(_,_,_,D,_,_,Score):-D-Score>0,!,writeln('E').
solve(_,_,C,_,_,_,Score):-C-Score>0,!,writeln('D').
solve(_,B,_,_,_,_,Score):-B-Score>0,!,writeln('C').
solve(A,_,_,_,_,_,Score):-A-Score>0,!,writeln('B').
solve(_,_,_,_,_,_,_):-!,writeln('A').

main:-readUInt(A),readUInt(B),readUInt(C),readUInt(D),readUInt(E),readUInt(Mark),solve(A,B,C,D,E,0,Mark).