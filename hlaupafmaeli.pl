:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

findAnswer(Year,_,_,0):-!,Answer is Year//4 - 505 - (Year-2000)//100 + (Year-2000)//400,bufferedWriteln(Answer).
findAnswer(_,0,0,_):-!,bufferedWriteln('Neibb').
findAnswer(Year,0,_,_):-!,Answer is Year//4 - 505 - (Year-2000)//100 + (Year-2000)//400,bufferedWriteln(Answer).
findAnswer(_,_,_,_):-bufferedWriteln('Neibb').

main:-initiateBufferedRead(256),readUInt(Year),Is100Leap is Year rem 400, IsSimpleLeap1 is Year rem 4, IsSimpleLeap2 is Year rem 100,findAnswer(Year,IsSimpleLeap1,IsSimpleLeap2,Is100Leap).