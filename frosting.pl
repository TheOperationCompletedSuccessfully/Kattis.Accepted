:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

assignNext(0,C0,RC0,C1,RC1,C2,RC2,Next):-!,RC0 is C0 + Next,RC1 is C1,RC2 is C2.
assignNext(1,C0,RC0,C1,RC1,C2,RC2,Next):-!,RC1 is C1 + Next,RC0 is C0,RC2 is C2.
assignNext(2,C0,RC0,C1,RC1,C2,RC2,Next):-!,RC2 is C2 + Next,RC1 is C1,RC0 is C0.



readAData(N,N,Result1,Result1,Result2,Result2,Result3,Result3):-!,true.
readAData(I,N,C0,Result0,C1,Result1,C2,Result2):-II is I+1,readUInt(Next),R is II rem 3,assignNext(R,C0,NewC0,C1,NewC1,C2,NewC2,Next),readAData(II,N,NewC0,Result0,NewC1,Result1,NewC2,Result2).

/*
assignBNext(0,ColColor0,_,_,C0,NewC0,C1,NewC1,C2,NewC2,Next):-!,NewC0 is C0 + ColColor0*Next,NewC1 is C1, NewC2 is C2.
assignBNext(1,_,ColColor1,_,C0,NewC0,C1,NewC1,C2,NewC2,Next):-!,NewC1 is C1 + ColColor1*Next,NewC0 is C0, NewC2 is C2.
assignBNext(2,_,_,ColColor2,C0,NewC0,C1,NewC1,C2,NewC2,Next):-!,NewC2 is C2 + ColColor2*Next,NewC1 is C1, NewC0 is C0.

readBData(N,N,_,_,_,Result0,Result0,Result1,Result1,Result2,Result2):-!,true.
readBData(I,N,ColColor0,ColColor1,ColColor2,Color0,Result0,Color1,Result1,Color2,Result2):-II is I+1,readUInt(Next),R is II rem 2,assignBNext(R,ColColor0,ColColor1,ColColor2,Color0,NewColor0,Color1,NewColor1,Color2,NewColor2,Next),readBData(II,N,ColColor0,ColColor1,ColColor2,NewColor0,Result0,NewColor1,Result1,NewColor2,Result2).
*/
calcMain(ColColor0,RowColor0,ColColor1,RowColor1,ColColor2,RowColor2,SumColor0,SumColor1,SumColor2):-SumColor0 is ColColor0*RowColor0 + ColColor2*RowColor1+ ColColor1*RowColor2,SumColor1 is ColColor0*RowColor1+ColColor1*RowColor0+ColColor2*RowColor2,SumColor2 is ColColor0*RowColor2+ColColor2*RowColor0+ColColor1*RowColor1.

main:-initiateBufferedRead(1048576),readUInt(N),readAData(0,N,0,ColColor0,0,ColColor1,0,ColColor2),readAData(0,N,0,RowColor0,0,RowColor1,0,RowColor2),calcMain(ColColor0,RowColor0,ColColor1,RowColor1,ColColor2,RowColor2,SumColor0,SumColor1,SumColor2),bufferedWrite(SumColor0),bufferedWrite(' '),bufferedWrite(SumColor1),bufferedWrite(' '),bufferedWriteln(SumColor2).