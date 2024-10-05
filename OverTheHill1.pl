readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readMatrix(_,N,N).
readMatrix(N,K,N):-!,KK is K+1,readMatrix(0,KK,N).
readMatrix(I,K,N):-I1 is I+1,readUInt(Next),assert(matrixItem(Next,I,K)),readMatrix(I1,K,N).

addPadding(N,N,_).
addPadding(I,N,CC):-I1 is I+1,assert(data(36,CC,32)),CCC is CC+1,addPadding(I1,N,CCC).

readData(Current,Length,N):-at_end_of_stream,!,NN is Current rem N,(NN is 0,!,NNN is 0;NNN is N-NN),addPadding(0,NNN,Current),Length is Current+NNN.
readData(Current,Length,N):-get0(Ch),(Ch is 10,!,NN is Current rem N,(NN is 0,!,NNN is 0;NNN is N-NN),addPadding(0,NNN,Current),Length is Current+NNN;Ch is 32,!,assert(data(36,Current,Ch)),CC is Current+1,readData(CC,Length,N);Ch>64,!,C is Ch-65,assert(data(C,Current,Ch)),CC is Current+1,readData(CC,Length,N);C is Ch-22,assert(data(C,Current,Ch)),CC is Current+1,readData(CC,Length,N)).

encryptData(G,G,_,_,_,_).
encryptData(IG,G,_,N,N,_):-!,NewG is IG+1,J1 is NewG*N,encryptData(NewG,G,0,N,0,J1).
encryptData(IG,G,N,N,Row,_):-!,RR is Row+1,J1 is IG*N,encryptData(IG,G,0,N,RR,J1).
encryptData(IG,G,I,N,Row,J):-I1 is I+1,J1 is J+I,data(D,J1,_),matrixItem(M,I,Row),JJ is J+Row,(encrypted(E,JJ),!,Next is (E+D*M) rem 37,retract(encrypted(E,JJ));Next is (D*M) rem 37),assert(encrypted(Next,JJ)),encryptData(IG,G,I1,N,Row,J).

solve(65,0).
solve(66,1).
solve(67,2).
solve(68,3).
solve(69,4).
solve(70,5).
solve(71,6).
solve(72,7).
solve(73,8).
solve(74,9).
solve(75,10).
solve(76,11).
solve(77,12).
solve(78,13).
solve(79,14).
solve(80,15).
solve(81,16).
solve(82,17).
solve(83,18).
solve(84,19).
solve(85,20).
solve(86,21).
solve(87,22).
solve(88,23).
solve(89,24).
solve(90,25).
solve(48,26).
solve(49,27).
solve(50,28).
solve(51,29).
solve(52,30).
solve(53,31).
solve(54,32).
solve(55,33).
solve(56,34).
solve(57,35).
solve(32,36).

writeAnswer(N,N).
writeAnswer(I,N):-I1 is I+1,encrypted(D,I),solve(W,D),char_code(Ch,W),write(Ch),writeAnswer(I1,N).

main:-readUInt(N),readMatrix(0,0,N),readData(0,Len,N),DR is Len rem N,(DR is 0,!,LL is Len;LL is Len+1),G is LL//N,!,assert(data(-1,-1,-1)),assert(encrypted(-1,-1)),encryptData(0,G,0,N,0,0),!,writeAnswer(0,Len).