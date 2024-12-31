:-use_module(moduleMyNumbers, [readUInt/1,readUFloat/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).
/*
idea is the formula
V0 speed when falls on L length
with V0 speed he falls and overcomes S-L meters, however the resulting force is K*DeltaL-M*G
V0*T + (K*(S-L)/M -G)*T*T/2 = (S-L)

*/

solveV(V):-(V>10,!,bufferedWriteln('Killed by the impact.');bufferedWriteln('James Bond survives.')).

findSolution(_,L,S,_):-S=<L,!,T is sqrt(2*S/9.81),V is 9.81*T,solveV(V).
findSolution(K,L,S,W):-T0 is sqrt(2*L/9.81),V0 is 9.81*T0,DD is 4*V0*V0-8*(S-L)*((S-L)*K/(2*W)-9.81),(DD <0,!,bufferedWriteln('Stuck in the air.');D is sqrt(DD),T1 is (V0-D)/((K*(S-L)/(2*W) -9.81)),V is V0-(K*(S-L)/(2*W) - 9.81)*T1,VV is V/2,solveV(VV)).
/*
findSolution(K,L,S,W):-GG is 2*9.81, DeltaL is max(S-L,0),T is sqrt(4*S/(GG-K*DeltaL/W)),V is (GG-K*DeltaL/W)*T/4,(V>10,!,bufferedWriteln('Killed by the impact.');bufferedWriteln('James Bond survives.')).
*/
main:-initiateBufferedRead(65536),readUFloat(K),readUFloat(L),readUFloat(S),readUFloat(W),(K is 0,!,true;findSolution(K,L,S,W),main).