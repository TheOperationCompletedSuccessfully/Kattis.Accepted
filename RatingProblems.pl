readInt(Number):-readInt(0,Number).
readInt(0,R):-!,get0(Ch),(Ch is 45,!,readInt(0,R1,0),R is -1*R1;Ch <48,!,readInt(0,R);I1 is Ch-48,readInt(I1,R,0)).
readInt(I,R,_):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readInt(I1,R,0)).

getData(N,N,Current,Result):-!,Result is Current.
getData(I,N,Current,Result):-I1 is I+1, readInt(Next),NewCurrent is Current+Next,getData(I1,N,NewCurrent,Result).

solve(I,N,WeHave,Total):-MinRating is ((-3)*(N-I) + WeHave)/Total,write(MinRating),write(' '),MaxRating is (3*(N-I) + WeHave)/Total,writeln(MaxRating).

main:-readInt(N),readInt(K),getData(0,K,0,Already),D is N-K,solve(0,D,Already,N).