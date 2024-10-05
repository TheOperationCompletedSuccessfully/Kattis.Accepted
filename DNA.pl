readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

bufferedWrite(C):-with_output_to(user_output,write(C)).

readData(I):-get0(Ch),II is I-1,III is I+1,dnaCounts(II,A,T,G,C),(Ch<65,!,true;Ch is 65,!,NewA is A+1,NewT is T,NewG is G,NewC is C;Ch is 84,!,NewA is A,NewT is T+1,NewG is G,NewC is C;Ch is 71,!,NewA is A,NewT is T,NewG is G+1,NewC is C;Ch is 67,!,NewA is A,NewT is T,NewG is G,NewC is C+1),(Ch>=65,!,assert(dnaCounts(I,NewA,NewT,NewG,NewC)),readData(III);true).

printAnswer([]).
printAnswer([H|T]):-printAnswer(T),H=[_,_,ToPrint],bufferedWrite(ToPrint).

solve(N,N).
solve(I,N):-II is I+1,readUInt(Start),BB is Start-1,dnaCounts(BB,AS,TS,GS,CS),readUInt(End),dnaCounts(End,AE,TE,GE,CE),AA is AE-AS,TT is TE-TS,CC is CE-CS,GG is GE-GS,Data=[[AA,4,'A'],[TT,3,'T'],[GG,2,'G'],[CC,1,'C']],msort(Data,Sorted),printAnswer(Sorted),nl,solve(II,N).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),assert(dnaCounts(0,0,0,0,0)),readData(1),readUInt(N),solve(0,N).

