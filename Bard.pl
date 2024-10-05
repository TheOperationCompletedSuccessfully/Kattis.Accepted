readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).


setupVillagers(N,N,_).
setupVillagers(I,N,E):-II is I+1,(II is 1,!,EE is 2^E-1,assert(villager(1,EE));assert(villager(II,0))),setupVillagers(II,N,E).

checkResult(N,N,_).
checkResult(I,N,SC):-II is I+1,villager(II,D),(D is D \/ SC,!,bufferedWriteln(II);true),checkResult(II,N,SC).

setVillagers([],_).
setVillagers([H|T],Result):-villager(H,Old),New is Result \/ Old,retract(villager(H,Old)),assert(villager(H,New)),setVillagers(T,Result).

getVillagers(N,N,Result,Result,S,S,Villagers,Villagers).
getVillagers(I,N,Current,Result,S,SongCount,CurrentV,Villagers):-II is I+1,readUInt(Villager),(Villager is 1,!,NewS is S+1,Result is 2^S,NewCurrentV = CurrentV;NewS is S,append(CurrentV,[Villager],NewCurrentV),(var(Result),!,villager(Villager,D),NewC is Current \/ D;NewC is Result)),getVillagers(II,N,NewC,Result,NewS,SongCount,NewCurrentV,Villagers).

solve(N,N,S,S).
solve(I,N,S,SongCount):-II is I+1, readUInt(K),getVillagers(0,K,0,Result,S,NewS,[],Villagers),setVillagers(Villagers,Result),solve(II,N,NewS,SongCount).

bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(N),readUInt(E),setupVillagers(0,N,E),solve(0,E,0,SongCount),SC is 2^SongCount - 1,checkResult(0,N,SC).