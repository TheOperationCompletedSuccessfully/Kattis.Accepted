executeCommand(70,X,Y,NextX,NextY,ResultX,ResultY,ResultNextX,ResultNextY):-!,ResultX is NextX,ResultY is NextY,ResultNextX is NextX + (NextX-X),ResultNextY is NextY + (NextY-Y).
executeCommand(82,X,Y,NextX,NextY,ResultX,ResultY,ResultNextX,ResultNextY):-!,ResultX is X,ResultY is Y,ResultNextX is X -(NextY-Y),ResultNextY is Y + (NextX-X).
executeCommand(76,X,Y,NextX,NextY,ResultX,ResultY,ResultNextX,ResultNextY):-!,ResultX is X,ResultY is Y,ResultNextX is X +(NextY-Y),ResultNextY is Y - (NextX-X).
executeCommand(88,X,Y,NextX,NextY,ResultX,ResultY,ResultNextX,ResultNextY):-field(Fired,NextX,NextY),!,(Fired is 73,!, retract(field(73,NextX,NextY)),assert(field(46,NextX,NextY)),ResultX is X,ResultY is Y,ResultNextX is NextX,ResultNextY is NextY;ResultNextX is -1).
executeCommand(88,_,_,_,_,_,_,ResultNextX,_):-ResultNextX is -1.

executeCommands(-1,_,_,_,_,_):-!,writeln('Bug!').
executeCommands(8,_,_,_,_,_):-!,writeln('Bug!').
executeCommands(_,-1,_,_,_,_):-!,writeln('Bug!').
executeCommands(_,8,_,_,_,_):-!,writeln('Bug!').
executeCommands(X,Y,_,_,_,_):-field(73,X,Y),!,writeln('Bug!').
executeCommands(X,Y,_,_,_,_):-field(67,X,Y),!,writeln('Bug!').
executeCommands(X,Y,_,_,_,_):-at_end_of_stream,!,field(68,CD,CR),(X is CD,Y is CR,!,writeln('Diamond!');writeln('Bug!')).
executeCommands(X,Y,NextX,NextY,R,C):-get0(Command),(Command is 10,!,field(68,CD,CR),(X is CD,Y is CR,!,writeln('Diamond!');writeln('Bug!'));executeCommand(Command,X,Y,NextX,NextY,NewX,NewY,NewNextX,NewNextY),executeCommands(NewX,NewY,NewNextX,NewNextY,R,C)).

readPending:-at_end_of_stream,!,true.
readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readRow(N,N,_).
readRow(I,C,Row):-get0(Ch),assert(field(Ch,I,Row)),I1 is I+1,readRow(I1,C,Row).

readData(N,N,_).
readData(I,N,C):-I1 is I+1,readRow(0,C,I),readPending,readData(I1,N,C).

main:-readData(0,8,8),executeCommands(0,7,1,7,8,8).