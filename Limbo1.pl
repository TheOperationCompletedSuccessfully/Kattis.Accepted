readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

solve(N,N).
solve(I,N):-II is I+1,readUInt(L),readUInt(R),LR is L+R,Answer is 1+LR*(LR+1)//2 + R,bufferedWriteln(Answer),solve(II,N).

bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(N),solve(0,N).