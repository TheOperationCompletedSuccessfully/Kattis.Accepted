readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

findClosest2(A,Result):-L is floor(log(A)/log(2)),Result is (2**L).

solveInner(R,C):-RR is R-1,CC is C-1,MaxRC is max(max(RR,CC),1),findClosest2(MaxRC,XX),(R=<XX,!,AddC is (C-XX-1)*XX+R,Result is (XX*XX-1)+AddC;AddR is (R-1)*2*XX+C,Result is AddR-1),bufferedWriteln(Result).

solve(N,N).
solve(I,N):-II is I+1,readUInt(R),readUInt(C),RR is R+1,CC is C+1,solveInner(RR,CC),solve(II,N).

bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(T),solve(0,T).