readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

transform(Sum,N,Result):-Res is Sum/N,RR is Sum//N,FF is 2*(Res-RR),(FF is 1.0,!,R is round(2*Res) rem 2,(R is 1,!,Result is floor(Res);Result is round(Res));Result is round(Res)).

solve(0,0,0,0).
solve(N,N,ResultX,ResultY):-transform(ResultX,N,FinalX),transform(ResultY,N,FinalY),bufferedWrite(FinalX),bufferedWrite(' '),bufferedWriteln(FinalY),readUInt(Next),solve(0,Next,0,0).
solve(I,N,ResultX,ResultY):-II is I+1,readUInt(NextX),readUInt(NextY),NewX is ResultX+NextX,NewY is ResultY+NextY,solve(II,N,NewX,NewY).  

bufferedWrite(C):-with_output_to(user_output,write(C)).
bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-set_stream(user_input,buffer_size(16384)),fill_buffer(user_input),readUInt(N),solve(0,N,0,0).