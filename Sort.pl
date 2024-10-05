readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

p([],_,_,_).
p([Head|Tail],P,S,B):-
    (  Head = [N|_],P = [PN|_],(N<PN)->S=[Head|R],p(Tail,P,R,B);B=[Head|R],p(Tail,P,S,R)).
sortList([],Result):-Result =[].
sortList([Head|Tail],Result):-p(Tail,Head,S,B),sortList(S,SR),sortList(B,BR),append(SR,[Head],SR1),append(SR1,BR,Result).

solve(N,N,_,Current,Result):-!,Result is Current.
solve(I,N,Category,Current,Result):-I1 is I+1,readUInt(Next),(metItem(Next,Met),!,retract(metItem(Next,Met)),NextMet is Met+1,NewCategory is Category;NextMet is 1,assert(category(Next,Category)),NewCategory is Category+1),assert(metItem(Next,NextMet)),NextCurrent is max(NextMet,Current),solve(I1,N,NewCategory,NextCurrent,Result).

writeItem(Item,1):-!,(wroteData(1),!,write(' ');true),write(Item).
writeItem(Item,I):-I1 is I-1,(wroteData(1),!,write(' ');true),write(Item),(wroteData(1),!,true;assert(wroteData(1))),writeItem(Item,I1).

writeList([[_,Head]],I):-!,writeItem(Head,I).
writeList([[_,Head]|Tail],I):-writeItem(Head,I),writeList(Tail,I).

writeAnswer(0,1,_).
writeAnswer(I,1,Found):-(metItem(Item,I),!,category(Item,Category),append(Found,[[Category,Item]],NewFound),retract(metItem(Item,I)),writeAnswer(I,1,NewFound);(Found \=[],!,sortList(Found,Sorted),writeList(Sorted,I);true),I1 is I-1,writeAnswer(I1,1,[])).
main:-readUInt(N),readUInt(_),assert(metItem(-1,-1)),assert(wroteData(0)),solve(0,N,1,0,MaxItem),writeAnswer(MaxItem,1,[]).