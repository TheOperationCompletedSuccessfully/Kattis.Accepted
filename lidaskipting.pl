:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

readData(Current,Result):-at_end_of_stream,!,Result is Current.
readData(Current,Result):-get0(Ch),(Ch<48,!,Result is Current;NewC is Current + Ch - 48,readData(NewC,Result)).

main:-initiateBufferedRead(256),readData(0,N),(0 is N rem 3,!,bufferedWriteln('Jebb');bufferedWriteln('Neibb')).