readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(0,_,_,_):-!,writeln('NO').
solve(_,0,_,_):-!,writeln('NO').
solve(_,_,0,_):-!,writeln('NO').
solve(A,B,C,N):-NN is A+B+C,NN<N,!,writeln('NO').
solve(_,_,_,N):-N<3,!,writeln('NO').
solve(_,_,_,_):-writeln('YES').

main:-readUInt(A),readUInt(B),readUInt(C),readUInt(N),solve(A,B,C,N).