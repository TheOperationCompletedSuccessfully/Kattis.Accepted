readUInt(Number):-readUInt(0,Number).
readUInt(0,R):-!,get0(Ch),(Ch <48,!,readUInt(0,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(_,N,N,_,A):-(A is 0,!,writeln('good job');true).
solve(N,A,A,N,_).
solve(I,J,N,NN,A):-I1 is I+1,readUInt(Next),J1 is J+1,(Next is I1,!,solve(I1,J1,N,NN,A);writeln(I1),MM is max(Next,NN),solve(I1,J1,N,MM,Next,1)).

solve(N,A,A,N,_,_).

solve(I,J,N,NN,Current,_):-I1 is I+1,(Current is I1,!,solve(I1,J,N,NN,1);writeln(I1),solve(I1,J,N,NN,Current,1)).

main:-readUInt(Cases),solve(0,0,Cases,Cases,0).