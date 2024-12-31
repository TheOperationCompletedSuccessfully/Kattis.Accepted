:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

isR(4009536629).
isR(3399669256).
isR(29507620501956).
isR(40095358025496).
isR(2861745496).
isR(3602996725496).
isR(2417015).
isR(23615797).
isR(40974362762797).

isA(236621017).
isA(283617479102).
isA(3655642375).


main:-initiateBufferedRead(256),readUInt(Next),(isR(Next),!,bufferedWriteln('Reykjavik');bufferedWriteln('Akureyri')).