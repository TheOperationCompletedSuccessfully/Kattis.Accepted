readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

vowel(97).
vowel(101).
vowel(105).
vowel(111).
vowel(117).

removeVowels(I,0,0,LI,Result):-data(I,H),!,II is I+1,removeVowels(II,0,H,LI,Result).
removeVowels(I,0,Ch,LI,Result):-not(data(I,_)),!,assert(processed(LI,Ch)),LL is LI+1,Result is LL.
removeVowels(I,0,Ch,LI,Result):-data(I,H),!,II is I+1,removeVowels(II,Ch,H,LI,Result).
removeVowels(I,32,Ch,LI,Result):-not(data(I,_)),!,assert(processed(LI,32)),LL is LI+1,assert(processed(LL,Ch)),LLL is LL+1,Result is LLL.
removeVowels(I,32,Ch,LI,Result):-data(I,H),!,II is I+1,assert(processed(LI,32)),LL is LI+1,removeVowels(II,Ch,H,LL,Result).
removeVowels(I,Pre,Ch,LI,Result):-data(I,32),!,II is I+1,assert(processed(LI,Pre)),LL is LI+1,removeVowels(II,Ch,32,LL,Result).
removeVowels(I,Pre,32,LI,Result):-data(I,H),!,II is I+1,assert(processed(LI,Pre)),LL is LI+1,removeVowels(II,32,H,LL,Result).
removeVowels(I,Pre,Ch,LI,Result):-not(data(I,_)),!,(vowel(Pre),!,Result is LI;Pre is 0,!,assert(processed(LI,Ch)),LL is LI+1,Result is LL;assert(processed(LI,Pre)),LL is LI+1,assert(processed(LL,Ch)),LLL is LL+1,Result is LLL).
removeVowels(I,Pre,Ch,LI,Result):-data(I,H),!,II is I+1,(vowel(Ch),!,removeVowels(II,Pre,H,LI,Result);assert(processed(LI,Pre)),LL is LI+1,removeVowels(II,Ch,H,LL,Result)).

/*
removeVowels(0,0,[H|T],[],Result):-!,removeVowels(0,H,T,[],Result).
removeVowels(0,Ch,[],[],Result):-!,Result = [Ch].
removeVowels(0,Ch,[H|T],[],Result):-!,removeVowels(Ch,H,T,[],Result).
removeVowels(32,Ch,[],Current,Result):-append(Current,[32,Ch],Result).
removeVowels(32,Ch,[H|T],Current,Result):-append(Current,[32],NewC),removeVowels(Ch,H,T,NewC,Result).
removeVowels(Pre,Ch,[32|T],Current,Result):-append(Current,[Pre],NewC),removeVowels(Ch,32,T,NewC,Result).
removeVowels(Pre,32,[H|T],Current,Result):-append(Current,[Pre],NewC),removeVowels(32,H,T,NewC,Result).
removeVowels(Pre,Ch,[],Current,Result):-!,(vowel(Pre),!,Result = Current;Pre is 0,!,append(Current,[Ch],Result);append(Current,[Pre,Ch],Result)).
removeVowels(Pre,Ch,[H|T],Current,Result):-(vowel(Ch),!,removeVowels(Pre,H,T,Current,Result);append(Current,[Pre],NewC),removeVowels(Ch,H,T,NewC,Result)).
*/

readData(_,_):-at_end_of_stream,!,true.
readData(I,PrevChar):-II is I+1,get0(Ch),(Ch is 10,!,assert(data(I,PrevChar));Ch is PrevChar,!,NewP is PrevChar,readData(I,NewP);PrevChar is 0,!,NewP is Ch,readData(I,NewP);assert(data(I,PrevChar)),NewP is Ch,readData(II,NewP)).

bufferedWrite(C):-with_output_to(user_output,write(C)).
bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

printAnswer(N,N).
printAnswer(I,N):-II is I+1,processed(I,H),char_code(Ch,H),bufferedWrite(Ch),printAnswer(II,N).

main:-set_stream(user_input,buffer_size(16384)),readUInt(_),fill_buffer(user_input),readData(0,0),removeVowels(0,0,0,0,N),printAnswer(0,N).