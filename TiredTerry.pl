readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

getDataAndCalcNewSum(I,Sum,NewSum):-get0(Ch),assert(data(I,Ch)),(Ch is 87,!,NewSum is Sum;NewSum is Sum+1).
getNewAnswer(I,P,NewSum,D):-SN is I-P,(P>0,!,sum(SN,OldSum),NS is NewSum-OldSum;NS is NewSum),(NS<D,!,total(OldAnswer),retract(total(OldAnswer)),NewAnswer is OldAnswer+1,assert(total(NewAnswer));true).

solve(N,_,_,N,_,_).
solve(I,P,N,NN,D,Sum):-II is I+1,I<P,!,getDataAndCalcNewSum(I,Sum,NewSum),assert(sum(I,NewSum)),solve(II,P,N,NN,D,NewSum).
solve(I,P,N,NN,D,Sum):-I<N,!,getDataAndCalcNewSum(I,Sum,NewSum),assert(sum(I,NewSum)),getNewAnswer(I,P,NewSum,D),II is I+1,solve(II,P,N,NN,D,NewSum).
solve(I,P,N,NN,D,Sum):-Index is I-N,sum(Index,OSum),SS is Sum+OSum,getNewAnswer(I,P,SS,D),II is I+1,solve(II,P,N,NN,D,Sum).

main:-set_stream(user_input,buffer_size(131072)),fill_buffer(user_input),readUInt(N),readUInt(P),readUInt(D),assert(total(0)),NN is N+P,solve(0,P,N,NN,D,0),total(Answer),writeln(Answer).