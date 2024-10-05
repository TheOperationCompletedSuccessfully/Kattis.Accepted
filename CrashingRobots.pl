readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

turnRight(78,78,0).
turnRight(78,69,1).
turnRight(78,83,2).
turnRight(78,87,3).

turnRight(69,69,0).
turnRight(69,83,1).
turnRight(69,87,2).
turnRight(69,78,3).

turnRight(83,83,0).
turnRight(83,87,1).
turnRight(83,78,2).
turnRight(83,69,3).

turnRight(87,87,0).
turnRight(87,78,1).
turnRight(87,69,2).
turnRight(87,83,3).

turnLeft(78,78,0).
turnLeft(78,87,1).
turnLeft(78,83,2).
turnLeft(78,69,3).

turnLeft(69,69,0).
turnLeft(69,78,1).
turnLeft(69,87,2).
turnLeft(69,83,3).

turnLeft(83,83,0).
turnLeft(83,69,1).
turnLeft(83,78,2).
turnLeft(83,87,3).

turnLeft(87,87,0).
turnLeft(87,83,1).
turnLeft(87,69,2).
turnLeft(87,78,3).

checkCrash(X,Y,Result):-(robot(RobotId,X,Y,_),!,Result is RobotId;Result is 0).

move(N,N,X,Y,Direction,Result):-!,Result = [X,Y,Direction].
move(I,N,X,Y,83,Result):-II is I+1,NewX is X,NewY is Y-1,checkCrash(NewX,NewY,R),(NewY is 0,!,Result = [-1,-1];R>0,!,Result = [R];move(II,N,NewX,NewY,83,Result)).
move(I,N,X,Y,78,Result):-II is I+1,wall(_,MaxY),NewX is X,NewY is Y+1,checkCrash(NewX,NewY,R),(NewY > MaxY,!,Result = [-1,-1];R>0,!,Result = [R];move(II,N,NewX,NewY,78,Result)).
move(I,N,X,Y,87,Result):-II is I+1,NewX is X-1,NewY is Y,checkCrash(NewX,NewY,R),(NewX is 0,!,Result = [-1,-1];R>0,!,Result = [R];move(II,N,NewX,NewY,87,Result)).
move(I,N,X,Y,69,Result):-II is I+1,wall(MaxX,_),NewX is X+1,NewY is Y,!,checkCrash(NewX,NewY,R),(NewX > MaxX,!,Result = [-1,-1];R>0,!,Result = [R];move(II,N,NewX,NewY,69,Result)).

logRobot(RobotNumber,X,Y,Direction):-write('Robot '),write(RobotNumber),write(' '),write(X),write(' '),write(Y),write(' '),writeln(Direction).
performCommand(RobotNumber,70,Repeat,Result):-robot(RobotNumber,X,Y,Direction),move(0,Repeat,X,Y,Direction,MoveResult),(MoveResult=[-1,-1],!,Result is -1;MoveResult=[RobotId],!,Result is RobotId;MoveResult=[NewX,NewY,Direction],retract(robot(RobotNumber,X,Y,Direction)),assert(robot(RobotNumber,NewX,NewY,Direction)),Result is 0).
performCommand(RobotNumber,76,Repeat,Result):-TrueRepeat is Repeat rem 4,robot(RobotNumber,X,Y,Direction),turnLeft(Direction,NewDirection,TrueRepeat),retract(robot(RobotNumber,X,Y,Direction)),assert(robot(RobotNumber,X,Y,NewDirection)),Result is 0.
performCommand(RobotNumber,82,Repeat,Result):-TrueRepeat is Repeat rem 4,robot(RobotNumber,X,Y,Direction),turnRight(Direction,NewDirection,TrueRepeat),retract(robot(RobotNumber,X,Y,Direction)),assert(robot(RobotNumber,X,Y,NewDirection)),Result is 0.

readRobots(N,N).
readRobots(I,N):-II is I+1,readUInt(X),readUInt(Y),get0(Direction),assert(robot(II,X,Y,Direction)),readRobots(II,N).

reportError(-1,RobotId):-!,write('Robot '),write(RobotId),writeln(' crashes into the wall').
reportError(AnotherRobotId,RobotId):-!,write('Robot '),write(RobotId),write(' crashes into robot '),writeln(AnotherRobotId).

readCommands(N,N).
readCommands(I,N):-II is I+1,readUInt(_),get0(_),readUInt(_),readCommands(II,N).

performCommands(N,N):-!,writeln('OK').
performCommands(I,N):-II is I+1,readUInt(RobotNumber),get0(Command),readUInt(Repeat),performCommand(RobotNumber,Command,Repeat,Result),(Result is 0,!,performCommands(II,N);reportError(Result,RobotNumber),readCommands(II,N)).

solve(N,N).
solve(I,N):-II is I+1,readUInt(X),readUInt(Y),assert(wall(X,Y)),readUInt(Robots),readUInt(Commands),readRobots(0,Robots),performCommands(0,Commands),retractall(robot(_,_,_,_)),retractall(wall(_,_)),solve(II,N).


main:-readUInt(Cases),solve(0,Cases).