readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

buildFibonacci(N,N).
buildFibonacci(I,N):-I1 is I+1,I11 is I-1,I12 is I-2,fibonacci(I11,F1),fibonacci(I12,F2),F is F1+F2,assert(fibonacci(I,F)),buildFibonacci(I1,N).

findRepeat(I,N,Q,Answer):-I1 is I+1,fibonacci(I,F),FF is F rem Q,(data(FF,Answer),!,true;assert(data(FF,I)),findRepeat(I1,N,Q,Answer)).

solve(N,N).
solve(I,N):-I1 is I+1,readUInt(Q),findRepeat(2,2000,Q,K),writeln(K),retractall(data(_,_)),solve(I1,N).

main:-assert(data(-1,-1)),assert(fibonacci(0,1)),assert(fibonacci(1,1)),buildFibonacci(2,2000),readUInt(N),solve(0,N).