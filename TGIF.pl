:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic year/2.
:-dynamic leapYear/2.

month(['J','A','N'],1).
month(['F','E','B'],2).
month(['M','A','R'],3).
month(['A','P','R'],4).
month(['M','A','Y'],5).
month(['J','U','N'],6).
month(['J','U','L'],7).
month(['A','U','G'],8).
month(['S','E','P'],9).
month(['O','C','T'],10).
month(['N','O','V'],11).
month(['D','E','C'],12).

dayOfWeek(['M','O','N'],1).
dayOfWeek(['T','U','E'],2).
dayOfWeek(['W','E','D'],3).
dayOfWeek(['T','H','U'],4).
dayOfWeek(['F','R','I'],5).
dayOfWeek(['S','A','T'],6).
dayOfWeek(['S','U','N'],7).

readPending:-get0(Ch),(Ch is 10,!,true;readPending).

readData(Result):-get0(Code1),char_code(Ch1,Code1),get0(Code2),char_code(Ch2,Code2),get0(Code3),char_code(Ch3,Code3),Result=[Ch1,Ch2,Ch3].

fillYears(N,N,_).
fillYears(I,N,CY):- R is CY rem 4,(R>0,!, D = date(CY,1,1),day_of_the_week(D,DOW),(year(DOW,_),!,NewI is I;assert(year(DOW,CY)),NewI is I+1);NewI is I),NewCY is CY-1,fillYears(NewI,N,NewCY).

fillLeapYears(N,N,_).
fillLeapYears(I,N,CY):-D = date(CY,1,1),day_of_the_week(D,DOW),(leapYear(DOW,_),!,NewI is I;assert(leapYear(DOW,CY)),NewI is I+1),NewCY is CY-4,fillLeapYears(NewI,N,NewCY).

checkAnswer(5,5):-!,bufferedWriteln('TGIF').
checkAnswer(5,_):-!,bufferedWriteln('not sure').
checkAnswer(_,5):-!,bufferedWriteln('not sure').
checkAnswer(_,_):-bufferedWriteln(':(').

main:-initiateBufferedRead(256),readUInt(N),readData(Month),readPending,readData(DOW),month(Month,M),dayOfWeek(DOW,D),fillYears(0,7,2023),fillLeapYears(0,7,2024),year(D,Year),leapYear(D,LY),D1 = date(Year,M,N),D2 = date(LY,M,N),day_of_the_week(D1,DOW1),day_of_the_week(D2,DOW2),checkAnswer(DOW1,DOW2).