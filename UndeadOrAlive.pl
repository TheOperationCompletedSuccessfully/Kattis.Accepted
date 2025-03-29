:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

valid([0,A,U],58,[1,A,U]).
valid([1,A,U],58,[1,A,U]).
valid([1,A,_],40,[0,A,1]).
valid([1,_,U],41,[0,1,U]).
valid([1,A,U],_,[0,A,U]).

getData(Current,Result):-at_end_of_stream,!,Result=Current.
getData(Current,Result):-get0(Ch),(Ch is 10,!,Result=Current;valid(Current,Ch,NewCurrent),getData(NewCurrent,Result);getData(Current,Result)).

main:-initiateBufferedRead(256),getData([0,0,0],Result),(Result=[_,1,1],!,bufferedWriteln('double agent');Result=[_,0,1],!,bufferedWriteln('undead');Result=[_,1,0],!,bufferedWriteln('alive');Result=[_,0,0],!,bufferedWriteln('machine')).