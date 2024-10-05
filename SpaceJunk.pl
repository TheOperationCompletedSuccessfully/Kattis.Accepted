readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readInt(Number):-readInt(0,Number).
readInt(0,R):-!,get0(Ch),(Ch is 45,!,readInt(0,R1,0),R is -1*R1;Ch <48,!,readInt(0,R);I1 is Ch-48,readInt(I1,R,0)).
readInt(I,R,_):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readInt(I1,R,0)).

calcResult(TT,T,D):-(TT is 0,!,writeln('No collision');X1 is ((-1*T)-sqrt(D))/(2*TT),(X1 >=0,!,writeln(X1);X2 is ((-1*T)+sqrt(D))/(2*TT),(X2>=0,!,writeln(X2);writeln('No collision')))).

calcD(TT,T,T0,D):-D is T*T-4*TT*T0.

solveInner(X,Y,Z,R,VX,VY,VZ):-TT is VX*VX+VY*VY+VZ*VZ,T is 2*VX*X+2*VY*Y+2*VZ*Z,T0 is X*X+Y*Y+Z*Z-R*R,calcD(TT,T,T0,D),(D<0,!,writeln('No collision');calcResult(TT,T,D)).

readData(X,Y,Z,R,VX,VY,VZ):-readInt(X),readInt(Y),readInt(Z),readInt(R),readInt(VX),readInt(VY),readInt(VZ).

solve(N,N).
solve(I,N):-II is I+1,readData(CraftX,CraftY,CraftZ,CraftR,CraftVX,CraftVY,CraftVZ),readData(JunkX,JunkY,JunkZ,JunkR,JunkVX,JunkVY,JunkVZ),X is JunkX-CraftX,Y is JunkY-CraftY,Z is JunkZ-CraftZ,R is JunkR+CraftR,VX is JunkVX-CraftVX,VY is JunkVY-CraftVY,VZ is JunkVZ-CraftVZ,solveInner(X,Y,Z,R,VX,VY,VZ),solve(II,N).

main:-readUInt(Cases),solve(0,Cases).