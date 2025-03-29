:-use_module(moduleMyNumbers, [readUInt/1, readInt/1,readUIntSafe/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

circleSizeArea(Size,Area):-(var(Size),!,Size is sqrt(Area/pi) ;Area is pi*Size*Size).
squareSizeArea(Size,Area):-(var(Size),!,Size is sqrt(Area);Area is Size*Size).
diamondSizeArea(Size,Area):-squareSizeArea(Size,Area).

circleSizePerimeter(Size,Perimeter):-(var(Size),!,Size is Perimeter/(2*pi) ;Perimeter is 2*pi*Size).
squareSizePerimeter(Size,Perimeter):-(var(Size),!,Size is Perimeter/4;Perimeter is 4*Size).
diamondSizePerimeter(Size,Perimeter):-squareSizePerimeter(Size,Perimeter).

readShapes(N,N).
readShapes(I,N):-II is I+1,get0(Ch),assert(shape(I,Ch)),readShapes(II,N).

getArea(Index,Area,Size):-shape(Index,67),!,circleSizeArea(Size,Area).
getArea(Index,Area,Size):-shape(Index,68),!,diamondSizeArea(Size,Area).
getArea(_,Area,Size):-squareSizeArea(Size,Area).

getPerimeter(Index,Area,Size):-shape(Index,67),!,circleSizePerimeter(Size,Area).
getPerimeter(Index,Area,Size):-shape(Index,68),!,diamondSizePerimeter(Size,Area).
getPerimeter(_,Area,Size):-squareSizePerimeter(Size,Area).

inscribe(67,83,CircleSize,SquareSize):-SquareSize is CircleSize*sqrt(2).
inscribe(67,68,CircleSize,DiamondSize):-DiamondSize is CircleSize*sqrt(2).
inscribe(68,67,DiamondSize,CircleSize):-CircleSize is DiamondSize/2.
inscribe(68,83,DiamondSize,SquareSize):-SquareSize is DiamondSize*sqrt(2)/2.
inscribe(83,67,SquareSize,CircleSize):-CircleSize is SquareSize/2.
inscribe(83,68,SquareSize,DiamondSize):-DiamondSize is SquareSize*sqrt(2)/2.

calcData(N,N,Size,65,Result):-!,NN is N-1,getArea(NN,Result,Size).
calcData(N,N,Size,_,Result):-NN is N-1,getPerimeter(NN,Result,Size).

calcData(I,N,Size,Target,Result):-II is I+1,shape(I,PrevShape),(shape(II,Shape),inscribe(PrevShape,Shape,Size,NewSize);NewSize is Size),calcData(II,N,NewSize,Target,Result).

main:-initiateBufferedRead(1024),readUInt(Shapes),readShapes(0,Shapes),readPending,get0(Ch),readUIntSafe(Data),(Ch is 65,!,getArea(0,Data,Size);getPerimeter(0,Data,Size)),readPending,get0(Target),calcData(0,Shapes,Size,Target,Result),bufferedWriteln(Result).