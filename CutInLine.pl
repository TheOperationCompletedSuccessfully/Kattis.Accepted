readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

cut(Name1,Name2,Index):-people(I,Name2),assert(people(Index,Name1)),queue(II,I),retract(queue(II,I)),assert(queue(II,Index)),assert(queue(Index,I)).
leave(Name):-people(Index,Name),queue(II,Index),retract(people(Index,Name)),retract(queue(II,Index)),(queue(Index,I),!,retract(queue(Index,I)),assert(queue(II,I));true).

processEvents(N,N).
processEvents(I,N):-II is I+1,readName([],Command),readName([],Name1),(Command=[99|_],!,readName([],Name2),cut(Name1,Name2,I);leave(Name1)),processEvents(II,N).

readName(Current,Result):-get0(Ch),(Ch is 10,!,Result = Current;Ch is 32,!,Result = Current;append(Current,[Ch],NewCurrent),readName(NewCurrent,Result)).

readData(N,N).
readData(I,N):-II is I+1,readName([],Name),assert(people(I,Name)),IP is I-1,assert(queue(IP,I)),readData(II,N).

writeName([]):-!,nl.
writeName([H|T]):-char_code(Ch,H),bufferedWrite(Ch),writeName(T).

writeAnswers(I):-(queue(I,Next),!,people(Next,Name),writeName(Name),writeAnswers(Next);true).

bufferedWrite(C):-with_output_to(user_output,write(C)).

main:-set_stream(user_input,buffer_size(32768)),fill_buffer(user_input),readUInt(N),readData(0,N),readUInt(C),CN is C+N,processEvents(N,CN),writeAnswers(-1).