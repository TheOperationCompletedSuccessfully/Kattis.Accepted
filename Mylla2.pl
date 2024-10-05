won(X):-board(0,0,X),board(0,1,X),board(0,2,X),!,true.
won(X):-board(0,0,X),board(1,0,X),board(2,0,X),!,true.
won(X):-board(0,0,X),board(1,1,X),board(2,2,X),!,true.
won(X):-board(0,1,X),board(1,1,X),board(2,1,X),!,true.
won(X):-board(1,0,X),board(1,1,X),board(1,2,X),!,true.
won(X):-board(2,0,X),board(2,1,X),board(2,2,X),!,true.
won(X):-board(0,2,X),board(1,2,X),board(2,2,X),!,true.
won(X):-board(0,2,X),board(1,1,X),board(2,0,X),!,true.
won(X):-X is 88.

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readCols(N,N,_).
readCols(I,N,Row):-II is I+1,get0(Ch),assert(board(I,Row,Ch)),readCols(II,N,Row).

readRows(N,N).
readRows(I,N):-II is I+1,readCols(0,3,I),readPending,readRows(II,N).

main:-readRows(0,3),won(X),(X is 88,!,writeln('Neibb');writeln('Jebb')).