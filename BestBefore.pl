readUInt(Number,Result):-readUInt(-1,Number,[],Result).
readUInt(-1,R,Current,Result):-!,get0(Ch),append(Current,[Ch],NewC),(Ch <48,!,readUInt(-1,R,NewC,Result);I1 is Ch-48,readUInt(I1,R,NewC,Result)).
readUInt(I,R,Current,Result):-get0(Ch),append(Current,[Ch],NewC),(Ch <48,!,R is I,Result=Current;I1 is I*10+Ch-48,readUInt(I1,R,NewC,Result)).

validDate(Year,2,29):-!,(Year<2000,!,YY is 2000+Year;YY is Year),R is YY rem 4,R is 0,(0 is YY rem 100,!,(0 is YY rem 400;false);true).
validDate(Year,Month,Day):-(Year<2000,!,YY is 2000+Year;YY is Year),date_time_stamp(date(YY,Month,Day,0,0,0,0,_,_),Stamp),stamp_date_time(Stamp, D, 0),date_time_value(year, D, YY),date_time_value(month, D, Month),date_time_value(day, D, Day).

findDate(Min,Av,Max,Result):-(validDate(Min,Av,Max),!,Result=[Min,Av,Max];validDate(Av,Min,Max),!,Result=[Av,Min,Max];validDate(Av,Max,Min),!,Result=[Av,Max,Min];validDate(Max,Min,Av),!,Result=[Max,Min,Av];validDate(Max,Av,Min),!,Result=[Max,Av,Min];Result=[]).

writeData([]).
writeData([H|T]):-char_code(Ch,H),bufferedWrite(Ch),writeData(T).

writeResult([0,M,D]):-bufferedWrite(2000),!,bufferedWrite('-'),(M<10,!,bufferedWrite(0);true),bufferedWrite(M),bufferedWrite('-'),(D<10,!,bufferedWrite(0);true),bufferedWriteln(D).
writeResult([Y,M,D]):-Y<10,!,bufferedWrite(200),bufferedWrite(Y),!,bufferedWrite('-'),(M<10,!,bufferedWrite(0);true),bufferedWrite(M),bufferedWrite('-'),(D<10,!,bufferedWrite(0);true),bufferedWriteln(D).
writeResult([Y,M,D]):-(Y<2000,!,bufferedWrite('20');true),bufferedWrite(Y),bufferedWrite('-'),(M<10,!,bufferedWrite(0);true),bufferedWrite(M),bufferedWrite('-'),(D<10,!,bufferedWrite(0);true),bufferedWriteln(D).

bufferedWrite(C):-with_output_to(user_output,write(C)).
bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-set_stream(user_input,buffer_size(256)),fill_buffer(user_input),readUInt(A,AO),readUInt(B,BO),readUInt(C,CO),L=[A,B,C],msort(L,LS),LS=[Min,Av,Max],findDate(Min,Av,Max,Result),(Result=[],!,writeData(AO),bufferedWrite('/'),writeData(BO),bufferedWrite('/'),writeData(CO),bufferedWriteln(' is illegal');writeResult(Result)).
