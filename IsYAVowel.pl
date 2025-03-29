:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

validN(97).
validN(101).
validN(105).
validN(111).
validN(117).

validY(Ch):-(validN(Ch);Ch is 121).

readData(CN,CY):-at_end_of_stream,!,bufferedWrite(CN),bufferedWrite(' '),bufferedWriteln(CY).
readData(CN,CY):-get0(Ch),(Ch is 10,!,bufferedWrite(CN),bufferedWrite(' '),bufferedWriteln(CY);validN(Ch),!,NewCN is CN+1,NewCY is CY+1,readData(NewCN,NewCY);validY(Ch),!,NewCY is CY+1,readData(CN,NewCY);readData(CN,CY)).

main:-initiateBufferedRead(256),readData(0,0).