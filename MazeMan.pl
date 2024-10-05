readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readRow(N,N,_).
readRow(I,N,Row):-II is I+1,get0(Ch),assert(data(Row,I,Ch)),(Ch is 88,!,assert(visited(Row,I));Ch>64,Ch<88,!,assert(visited(Row,I));true),readRow(II,N,Row).

readData(N,N,_).
readData(I,N,Columns):-II is I+1,readRow(0,Columns,I),readPending,readData(II,N,Columns).

enqueue(Index,Row,Col):-(visited(Row,Col),!,true;queue(_,Row,Col),!,true;assert(queue(Index,Row,Col))).


moveUp(Row,Col,I):-NewRow is Row-1,(NewRow>=0,!,enqueue(I,NewRow,Col);true).
moveLeft(Row,Col,I):-NewCol is Col-1,(NewCol>=0,!,enqueue(I,Row,NewCol);true).
moveDown(Row,Col,I,Rows):-NewRow is Row+1,(NewRow<Rows,!,enqueue(I,NewRow,Col);true).
moveRight(Row,Col,I,Cols):-NewCol is Col+1,(NewCol<Cols,!,enqueue(I,Row,NewCol);true).


performMoves(Row,Col,I,Rows,Cols):-moveUp(Row,Col,I),moveDown(Row,Col,I,Rows),moveLeft(Row,Col,I),moveRight(Row,Col,I,Cols).

processQueue(N,N,_,_,_):-!,true.
processQueue(I,N,Sign,Rows,Cols):-II is I+1,(queue(I,Row,Col),!,retract(queue(I,Row,Col)),(visited(Row,Col),!,true;assert(visited(Row,Col)),(data(Row,Col,46),!,retract(data(Row,Col,46)),assert(collected(Sign));true),performMoves(Row,Col,II,Rows,Cols)),processQueue(I,N,Sign,Rows,Cols);queue(II,_,_),!,processQueue(II,N,Sign,Rows,Cols);true).

traverseMaze(N,N,_,_,_):-!,true.
traverseMaze(I,N,Rows,Cols,CC):-RC is Rows*Cols//2,II is I+1,(data(Row,Col,I),!,retract(visited(Row,Col)),enqueue(0,Row,Col),processQueue(0,RC,[I,CC],Rows,Cols),assert(visited(Row,Col)),retract(data(Row,Col,I)),assert(data(Row,Col,88));true),(data(_,_,I),traverseMaze(I,N,Rows,Cols,1);traverseMaze(II,N,Rows,Cols,0)).

findSolution(N,N,Groups,Groups,NotReached):-!,(data(_,_,46),!,aggregate_all(count,data(_,_,46),NotReached);NotReached is 0).
findSolution(I,N,CG,Groups,NotReached):-II is I+1,(collected([I,CC]),!,NewCG is CG+1,retractall(collected([I,CC])),findSolution(I,N,NewCG,Groups,NotReached);findSolution(II,N,CG,Groups,NotReached)).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(Rows),readUInt(Columns),readData(0,Rows,Columns),assert(queue(-1,-1,-1)),assert(visited(-1,-1)),assert(collected(-1)),traverseMaze(65,88,Rows,Columns,0),findSolution(65,88,0,Groups,NotReached),write(Groups),write(' '),writeln(NotReached).