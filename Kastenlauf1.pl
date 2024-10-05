readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readInt(Number):-readInt(0,Number).
readInt(0,R):-!,get0(Ch),(Ch is 45,!,readInt(0,R1,0),R is -1*R1;Ch <48,!,readInt(0,R);I1 is Ch-48,readInt(I1,R,0)).
readInt(I,R,_):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readInt(I1,R,0)).

readStores(N,N).
readStores(I,N):-II is I+1,readInt(StoreX),readInt(StoreY),assert(store(StoreX,StoreY)),readStores(II,N).

markVisited([],_).
markVisited([H|T],Mark):-H = [X,Y],assert(visited(Mark,X,Y)),assert(visited1(X,Y)),markVisited(T,Mark).


checkReachable(Mark,X,Y):-visited(Mark,VX,VY),store(X,Y),not(visited1(X,Y)),Dist is abs(VX-X)+abs(VY-Y),Dist<1001,retract(store(X,Y)).

retractData:-retractall(visited(_,_,_)),retractall(visited1(_,_)),retractall(store(_,_)),retractall(checked(_,_,_,_)).

bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

findSolution(I,_,_):-I>101,!,bufferedWriteln('sad').
findSolution(I,TargetX,TargetY):-findall([NewX,NewY],checkReachable(I,NewX,NewY),L),(L=[],!,bufferedWriteln('sad');member([TargetX,TargetY],L),!,bufferedWriteln('happy');II is I+1,markVisited(L,II),findSolution(II,TargetX,TargetY)).

solve(N,N).
solve(I,N):-fill_buffer(user_input),II is I+1,readUInt(Stores),readInt(HomeX),readInt(HomeY),readStores(0,Stores),readInt(TargetX),readInt(TargetY),assert(checked(HomeX,HomeY,HomeX,HomeY)),assert(visited(0,HomeX,HomeY)),assert(visited1(HomeX,HomeY)),assert(store(TargetX,TargetY)),(HomeX is TargetX,HomeY is TargetY,!,bufferedWriteln('happy');findSolution(0,TargetX,TargetY),retractData),solve(II,N).

main:-set_stream(user_input,buffer_size(16384)),readUInt(Cases),solve(0,Cases).