readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readRhyme(I,Result):-get0(Ch),(Ch is 10,!,Result is I;Ch is 32,!,I1 is I+1,readRhyme(I1,Result);readRhyme(I,Result)).

readChild(Current,Result):-get0(Ch),(Ch is 10,!,Result = Current;Ch is 32,!,Result = Current;append(Current,[Ch],NewC),readChild(NewC,Result)).

readChildren(N,N):-!,NN is N-1,retract(child(NN,Child,_)),assert(child(NN,Child,0)).
readChildren(I,N):-II is I+1,readChild([],Child),assert(child(I,Child,II)),readChildren(II,N).

getChildByRhyme(Rhyme,Rhyme,ChildIndex,NextIndex,Child,PrevIndex):-!,child(ChildIndex,Child,NextIndex),child(PrevIndex,PrevChild,ChildIndex),retract(child(PrevIndex,PrevChild,ChildIndex)),assert(child(PrevIndex,PrevChild,NextIndex)),retract(child(ChildIndex,Child,NextIndex)).
getChildByRhyme(I,N,Index,NextIndex,Child,_):-II is I+1,child(Index,_,NIndex),getChildByRhyme(II,N,NIndex,NextIndex,Child,Index).

solve(N,N,_,_,FirstList,FirstList,SecondList,SecondList).
solve(I,N,Rhyme,ChildIndex,CurrentFirst,FirstList,CurrentSecond,SecondList):-R is I rem 2,II is I+1,NN is N-1,getChildByRhyme(0,Rhyme,ChildIndex,NewIndex,Child,NN),(R is 0,!,append(CurrentFirst,[Child],NewCF),solve(II,N,Rhyme,NewIndex,NewCF,FirstList,CurrentSecond,SecondList);append(CurrentSecond,[Child],NewCC),solve(II,N,Rhyme,NewIndex,CurrentFirst,FirstList,NewCC,SecondList)).

writeName([]).
writeName([H|T]):-char_code(Ch,H),bufferedWrite(Ch),writeName(T).

writeList([]).
writeList([H|T]):-writeName(H),nl,writeList(T).

bufferedWrite(C):-with_output_to(user_output,write(C)).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readRhyme(0,R),readUInt(N),readChildren(0,N),solve(0,N,R,0,[],FirstList,[],SecondList),length(FirstList,F),writeln(F),writeList(FirstList),length(SecondList,S),writeln(S),writeList(SecondList).