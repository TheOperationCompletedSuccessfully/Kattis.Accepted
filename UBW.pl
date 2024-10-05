readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

valid(0,['.','.','.','.']).
valid(1,['.','.','.','*']).
valid(2,['.','.','*','.']).
valid(3,['.','.','*','*']).
valid(4,['.','*','.','.']).
valid(5,['.','*','.','*']).
valid(6,['.','*','*','.']).
valid(7,['.','*','*','*']).
valid(8,['*','.','.','.']).
valid(9,['*','.','.','*']).

printData([],[],[],[]).
printData([A1|T1],[A2|T2],[A3|T3],[A4|T4]):-write(A1),write(' '),write(A2),write(' '),write(' '),write(' '),write(A3),write(' '),writeln(A4),printData(T1,T2,T3,T4).

main:-readUInt(Data),H1 is Data//1000,H2 is (Data-H1*1000)//100,M1 is (Data - H1*1000 - H2*100)//10,M2 is Data-H1*1000-H2*100-M1*10,valid(H1,HL1),valid(H2,HL2),valid(M1,ML1),valid(M2,ML2),printData(HL1,HL2,ML1,ML2).