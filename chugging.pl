readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

findSolution2(N,N):-!,writeln('=').
findSolution2(A,B):-A<B,!,writeln('Alice').
findSolution2(_,_):-writeln('Bob').

findSolution(TA,_,TA,_,1):-!,writeln('=').
findSolution(TA,DA,TA,DA,_):-!,writeln('=').
findSolution(TA,DA,TB,DB,_):-TA<TB,DA=<DB,!,writeln('Alice').
findSolution(TA,DA,TB,DB,_):-TA=<TB,DA<DB,!,writeln('Alice').
findSolution(TA,DA,TB,DB,_):-TA>TB,DA>=DB,!,writeln('Bob').
findSolution(TA,DA,TB,DB,_):-TA>=TB,DA>DB,!,writeln('Bob').
findSolution(TA,DA,TB,DB,N):-NN is N-1,NNN is NN*(NN+1)//2,TSA is TA*N+NNN*DA,TSB is TB*N + NNN*DB,findSolution2(TSA,TSB).

main:-set_stream(user_input,buffer_size(4096)),fill_buffer(user_input),readUInt(N),readUInt(TA),readUInt(DA),readUInt(TB),readUInt(DB),findSolution(TA,DA,TB,DB,N).