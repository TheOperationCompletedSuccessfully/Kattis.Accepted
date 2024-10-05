readUInt(Number):-readUInt(-1,Number).
readUInt(I,R):-at_end_of_stream,!,R is I.
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readAndGenerate(N,N).
readAndGenerate(I,N):-II is I+1, readUInt(X),readUInt(Y),assert(box(I,X,Y)),assert(box(I,Y,X)),S is X*Y,assert(area(I,S)),readAndGenerate(II,N).

unite(A,B,Area,Sign):-box(A,AX,AY),box(B,BX,BY),DX is max(AX,BX),DY is AY+BY,DD is DX*DY+Area,bestResult(Best),(DD>=Best,fail;box2(Sign,DX,DY),true;assert(box2(Sign,DX,DY))),(box2(Sign,DY,DX),true;assert(box2(Sign,DY,DX))).
unite(A,B,Area,Sign):-box(A,AX,AY),box(B,BX,BY),DX is AX+BX,DY is max(AY,BY),DD is DX*DY+Area,bestResult(Best),(DD>=Best,fail;box2(Sign,DX,DY),true;assert(box2(Sign,DX,DY))),(box2(Sign,DY,DX),true;assert(box2(Sign,DY,DX))).
unite2(C,Sign):-box(C,CX,CY),box2(Sign,DX,DY),EX is max(CX,DX),EY is CY+DY,bestResult(Old),New is EX*EY,(Old>New,retract(bestResult(Old)),assert(bestResult(New));true).
unite2(C,Sign):-box(C,CX,CY),box2(Sign,DX,DY),EX is CX+DX,EY is max(CY,DY),bestResult(Old),New is EX*EY,(Old>New,retract(bestResult(Old)),assert(bestResult(New));true).

checkStop:-area(0,AreaA),area(1,AreaB),area(2,AreaC),bestResult(Best),Best is AreaA+AreaB+AreaC.

makeUnions(A,B,C):-area(C,Area),assert(box2(-1,-1,-1)),findall(_,unite(A,B,Area,0),_),retract(box2(-1,-1,-1)),assert(box3(-1,-1)),findall(_,unite2(C,0),_),retract(box3(-1,-1)).
makeUnions(A,B,C):-(checkStop,!,fail;true),area(B,Area),assert(box2(-1,-1,-1)),findall(_,unite(A,C,Area,1),_),retract(box2(-1,-1,-1)),assert(box3(-1,-1)),findall(_,unite2(B,1),_),retract(box3(-1,-1)).
makeUnions(A,B,C):-(checkStop,!,fail;true),area(A,Area),assert(box2(-1,-1,-1)),findall(_,unite(B,C,Area,2),_),retract(box2(-1,-1,-1)),assert(box3(-1,-1)),findall(_,unite2(A,2),_),retract(box3(-1,-1)).
makeUnions(A,B,C):-(checkStop,!,fail;true),area(C,Area),assert(box2(-1,-1,-1)),findall(_,unite(B,A,Area,3),_),retract(box2(-1,-1,-1)),assert(box3(-1,-1)),findall(_,unite2(C,3),_),retract(box3(-1,-1)).
makeUnions(A,B,C):-(checkStop,!,fail;true),area(B,Area),assert(box2(-1,-1,-1)),findall(_,unite(C,A,Area,4),_),retract(box2(-1,-1,-1)),assert(box3(-1,-1)),findall(_,unite2(B,4),_),retract(box3(-1,-1)).
makeUnions(A,B,C):-(checkStop,!,fail;true),area(A,Area),assert(box2(-1,-1,-1)),findall(_,unite(C,B,Area,5),_),retract(box2(-1,-1,-1)),assert(box3(-1,-1)),findall(_,unite2(A,5),_),retract(box3(-1,-1)).

findSolution:-findall(_,makeUnions(0,1,2),_),bestResult(Result),bufferedWriteln(Result).

retractData:-retractall(box(_,_,_)),retractall(box2(_,_,_)),retractall(box3(_,_)),retractall(bestResult(_)),retractall(area(_,_)),assert(bestResult(3000000000000000000)).

bufferedWrite(C):-with_output_to(user_output,write(C)).
bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

solve(N,N).
solve(I,N):-II is I+1,fill_buffer(user_input),readAndGenerate(0,3),findSolution,retractData,solve(II,N).

main:-set_stream(user_input,buffer_size(16384)),readUInt(N),assert(bestResult(3000000000000000000)),solve(0,N).