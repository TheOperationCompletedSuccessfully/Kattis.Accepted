readData(Current,Result):-at_end_of_stream,!,Result = Current.
readData(Current,Result):-get0(Ch),(Ch is 10,!,Result = Current;Ch is 32,!,Result = Current;append(Current,[Ch],NewC),readData(NewC,Result)).

writeAnswer([],[]).
writeAnswer([],[Head|Tail]):-char_code(Ch,Head),write(Ch),writeAnswer([],Tail).
writeAnswer([101,120],[Head|Tail]):-!,char_code(Ch,Head),write('ex'),write(Ch),writeAnswer([],Tail).
writeAnswer([97],[Head|Tail]):-!,char_code(Ch,Head),write('ex'),write(Ch),writeAnswer([],Tail).
writeAnswer([105],[Head|Tail]):-!,char_code(Ch,Head),write('ex'),write(Ch),writeAnswer([],Tail).
writeAnswer([111],[Head|Tail]):-!,char_code(Ch,Head),write('ex'),write(Ch),writeAnswer([],Tail).
writeAnswer([117],[Head|Tail]):-!,char_code(Ch,Head),write('ex'),write(Ch),writeAnswer([],Tail).
writeAnswer([101],[Head|Tail]):-!,char_code(Ch,Head),write('ex'),write(Ch),writeAnswer([],Tail).
writeAnswer([LastChar],[Head|Tail]):-char_code(LC,LastChar),char_code(Ch,Head),write(LC),write('ex'),write(Ch),writeAnswer([],Tail).
writeAnswer([Head|Tail],Second):-char_code(Ch,Head),write(Ch),writeAnswer(Tail,Second).

main:-readData([],Y),readData([],P),writeAnswer(Y,P).