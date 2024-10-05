validateStarColumns(N,N).
validateStarColumns(I,N):-II is I+1,stars(42,I,Y1,I1),retract(stars(42,I,Y1,I1)),stars(42,I,Y2,I2),retract(stars(42,I,Y2,I2)),!,not(stars(42,I,_,_)),!,assert(stars(42,I,Y2,I2)),assert(stars(42,I,Y1,I1)),validateStarColumns(II,N).

validateStarPositions:-stars(42,X1,Y1,_),stars(42,X2,Y2,_),DX is abs(X1-X2),DY is abs(Y1-Y2),DX<2,DY<2,DX+DY>0. 

validateStarRows(N,N).
validateStarRows(I,N):-II is I+1,stars(42,X1,I,I1),retract(stars(42,X1,I,I1)),stars(42,X2,I,I2),retract(stars(42,X2,I,I2)),!,not(stars(42,_,I,_)),!,assert(stars(42,X2,I,I2)),assert(stars(42,X1,I,I1)),validateStarRows(II,N).

validateStarAreas(N,N).
validateStarAreas(I,N):-I1 is I+1,stars(42,X,Y,I),retract(stars(42,X,Y,I)),stars(42,XX,YY,I),retract(stars(42,XX,YY,I)),!,not(stars(42,_,_,I)),!,assert(stars(42,XX,YY,I)),assert(stars(42,X,Y,I)),validateStarAreas(I1,N).

readPending:-at_end_of_stream,!,true.
readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readStarRow(N,N,_).
readStarRow(I,C,Row):-get0(Ch),field(F,I,Row),assert(stars(Ch,I,Row,F)),I1 is I+1,readStarRow(I1,C,Row).

readStars(N,N,_).
readStars(I,N,C):-I1 is I+1,readStarRow(0,C,I),readPending,readStars(I1,N,C).

readRow(N,N,_).
readRow(I,C,Row):-get0(Ch),CC is Ch-48,assert(field(CC,I,Row)),I1 is I+1,readRow(I1,C,Row).

readData(N,N,_).
readData(I,N,C):-I1 is I+1,readRow(0,C,I),readPending,readData(I1,N,C).

main:-assert(field(-1,-1,-1)),readData(0,10,10),readStars(0,10,10),(validateStarAreas(0,10),validateStarRows(0,10),validateStarColumns(0,10),(validateStarPositions,!,writeln('invalid'),true;writeln('valid'),true);writeln('invalid')).