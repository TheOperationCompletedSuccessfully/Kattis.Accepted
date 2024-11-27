:-use_module(moduleMyNumbers, [readUInt/1,readInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).
findSolution(CurrentYear,_,_,_,_,_,Result):-CurrentYear>5000,!,Result is 5001.

findSolution(CurrentYear,_,YS,DS,YM,DM,Result):-Srem is (CurrentYear+DS) rem YS,Drem is (CurrentYear+DM) rem YM,Srem is Drem,!,Result is CurrentYear.
findSolution(CurrentYear,CurrentYear,YS,DS,YM,DM,Result):-!,Srem is (CurrentYear+DS) rem YS,Drem is (CurrentYear+DM) rem YM,DiffS is YS-Srem,DiffM is YM-Drem,NextMove is max(DiffS,DiffM),NewYear is CurrentYear+NextMove,findSolution(NewYear,CurrentYear,YS,DS,YM,DM,Result).
findSolution(CurrentYear,DD,YS,DS,YM,DM,Result):-Srem is (CurrentYear+DS) rem YS,Drem is (CurrentYear+DM) rem YM,DiffS is YS-Srem,DiffM is YM-Drem,NextMove is max(DiffS,DiffM),NewYear is CurrentYear+NextMove,findSolution(NewYear,DD,YS,DS,YM,DM,Result).

main:-initiateBufferedRead(256),readUInt(DS),readUInt(YS),readUInt(DM),readUInt(YM),ExpS is YS-DS,ExpM is YM-DM,(DS is DM,!,GSM is gcd(YM,YS),TT is YM*YS//GSM,NextTime is TT-DS;ExpS is ExpM,!,NextTime is ExpS;DD is max(ExpS,ExpM),findSolution(DD,DD,YS,DS,YM,DM,NextTime)),bufferedWriteln(NextTime).