readRangeAndCalc(I,J,R1,Result):-get0(Ch),readRangeAndCalc(Ch,I,J,R1,Result).
readRangeAndCalc(Ch,_,_,0,Result):-Ch<45,!,Res is Result + 1,writeln(Res).
readRangeAndCalc(Ch,_,J,R1,Result):-Ch<45,!,Res is Result + J - R1+1,writeln(Res).
readRangeAndCalc(45,I,0,0,Result):-!,readRangeAndCalc(0,0,I,Result).
readRangeAndCalc(59,_,0,0,Result):-!,Res is Result + 1,readRangeAndCalc(0,0,0,Res).
readRangeAndCalc(59,_,J,R1,Result):-!,Res is Result + J - R1+1,readRangeAndCalc(0,0,0,Res).
readRangeAndCalc(Ch,I,J,0,Result):-I1 is I*10+Ch-48,readRangeAndCalc(I1,J,0,Result).
readRangeAndCalc(Ch,I,J,R1,Result):-J1 is J*10+Ch-48,readRangeAndCalc(I,J1,R1,Result).

main:-readRangeAndCalc(0,0,0,0).
