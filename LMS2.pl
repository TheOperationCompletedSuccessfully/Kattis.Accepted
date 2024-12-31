:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

:-dynamic rule/2.
:-dynamic definedRule/1.

rule(Code,0):-!,char_code(Ch,Code),bufferedWrite(Ch).
rule(Code,_):-not(definedRule(Code)),!,char_code(Ch,Code),bufferedWrite(Ch).


logResult([]):-!,nl.
logResult([H|T]):-char_code(Ch,H),write(Ch),logResult(T).

readRule(Current):-at_end_of_stream,!,append(Current,[46],NewC),read_from_chars(NewC,T),assert(T).
readRule([]):-!,get0(Ch),(Ch is 10,!,true;Ch >=65,Ch=<90,!,number_to_chars(Ch,CharsA),assert(definedRule(Ch)),append([114,117,108,101,40],CharsA,List1),append(List1,[44,73,41,58,45,83,32,105,115,32,73,45,49],List),readRule(List);readRule([])).
readRule(Current):-get0(Ch),(Ch is 10,!,append(Current,[46],NewC),read_from_chars(NewC,T),assert(T);Ch >=65,Ch=<90,!,number_to_chars(Ch,CharsA),append(Current,[44,114,117,108,101,40],List1),append(List1,CharsA,List2),append(List2,[44,83,41],NewC),readRule(NewC);readRule(Current)).

readRules(N,N).
readRules(I,N):-II is I+1,readRule([]),readRules(II,N).

readData(_):-at_end_of_stream,!,true.
readData(M):-get0(Ch),(Ch is 10,!,nl;rule(Ch,M),readData(M)).

main:-initiateBufferedRead(4096),readUInt(N),readUInt(M),readRules(0,N),readData(M).