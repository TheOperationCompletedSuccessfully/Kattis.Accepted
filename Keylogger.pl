readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

key(65,[99,108,97,110,107],1).
key(66,[98,111,110,103],1).
key(67,[99,108,105,99,107],1).
key(68,[116,97,112],1).
key(69,[112,111,105,110,103],1).
key(70,[99,108,111,110,107],1).
key(71,[99,108,97,99,107],1).
key(72,[112,105,110,103],1).
key(73,[116,105,112],1).
key(74,[99,108,111,105,110,103],1).
key(75,[116,105,99],1).
key(76,[99,108,105,110,103],1).
key(77,[98,105,110,103],1).
key(78,[112,111,110,103],1).
key(79,[99,108,97,110,103],1).
key(80,[112,97,110,103],1).
key(81,[99,108,111,110,103],1).
key(82,[116,97,99],1).
key(83,[98,111,105,110,103],1).
key(84,[98,111,105,110,107],1).
key(85,[99,108,111,105,110,107],1).
key(86,[114,97,116,116,108,101],1).
key(87,[99,108,111,99,107],1).
key(88,[116,111,99],1).
key(89,[99,108,105,110,107],1).
key(90,[116,117,99],1).

key(97,[99,108,97,110,107],0).
key(98,[98,111,110,103],0).
key(99,[99,108,105,99,107],0).
key(100,[116,97,112],0).
key(101,[112,111,105,110,103],0).
key(102,[99,108,111,110,107],0).
key(103,[99,108,97,99,107],0).
key(104,[112,105,110,103],0).
key(105,[116,105,112],0).
key(106,[99,108,111,105,110,103],0).
key(107,[116,105,99],0).
key(108,[99,108,105,110,103],0).
key(109,[98,105,110,103],0).
key(110,[112,111,110,103],0).
key(111,[99,108,97,110,103],0).
key(112,[112,97,110,103],0).
key(113,[99,108,111,110,103],0).
key(114,[116,97,99],0).
key(115,[98,111,105,110,103],0).
key(116,[98,111,105,110,107],0).
key(117,[99,108,111,105,110,107],0).
key(118,[114,97,116,116,108,101],0).
key(119,[99,108,111,99,107],0).
key(120,[116,111,99],0).
key(121,[99,108,105,110,107],0).
key(122,[116,117,99],0).

shiftStart([100,105,110,107]).
shiftEnd([116,104,117,109,98]).
capsLock([98,117,109,112]).
space([119,104,97,99,107]).
deleteSymbol([112,111,112]).

readData(Current,Result):-at_end_of_stream,!,Result = Current.
readData(Current,Result):-get0(Ch),(Ch is 10,!,Result = Current;append(Current,[Ch],NewC),readData(NewC,Result)).

solve(N,N,_,_,Current,Result):-!,Result = Current.
solve(I,N,CapsOn,ShiftOn,Current,Result):-I1 is I+1,readData([],Data),Caps is (CapsOn+ShiftOn) rem 2,(key(Key,Data,Caps),!,append([Key],Current,NewC),NewCapsOn is CapsOn,NewShiftOn is ShiftOn;shiftStart(Data),!,NewC = Current,NewCapsOn is CapsOn,NewShiftOn is 1;shiftEnd(Data),!,NewC = Current,NewCapsOn is CapsOn,NewShiftOn is 0;capsLock(Data),!,NewC = Current,NewCapsOn is 1-CapsOn,NewShiftOn is ShiftOn;space(Data),!,append([32],Current,NewC),NewCapsOn is CapsOn,NewShiftOn is ShiftOn;deleteSymbol(Data),!,(Current = [],!,NewC = [];Current=[_|NewC]),NewCapsOn is CapsOn,NewShiftOn is ShiftOn),solve(I1,N,NewCapsOn,NewShiftOn,NewC,Result).

writeAnswer([]).
writeAnswer([Head|Tail]):-char_code(Ch,Head),write(Ch),writeAnswer(Tail).

main:-readUInt(N),solve(0,N,0,0,[],Message),reverse(Message,TrueMessage),writeAnswer(TrueMessage).