check1(1,1,1,_,_,_,_,_,_).
check1(_,_,_,1,1,1,_,_,_).
check1(_,_,_,_,_,_,1,1,1).
check1(1,_,_,1,_,_,1,_,_).
check1(_,1,_,_,1,_,_,1,_).
check1(_,_,1,_,_,1,_,_,1).
check1(1,_,_,_,1,_,_,_,1).
check1(_,_,1,_,1,_,1,_,_).

check2(2,2,2,_,_,_,_,_,_).
check2(_,_,_,2,2,2,_,_,_).
check2(_,_,_,_,_,_,2,2,2).
check2(2,_,_,2,_,_,2,_,_).
check2(_,2,_,_,2,_,_,2,_).
check2(_,_,2,_,_,2,_,_,2).
check2(2,_,_,_,2,_,_,_,2).
check2(_,_,2,_,2,_,2,_,_).

readData(N,N,Result,Result).
readData(I,N,Current,Result):-II is I+1,get0(Ch),(Ch is 10,!,readData(I,N,Current,Result);Ch is 32,!,readData(I,N,Current,Result);Ch is 88,!,append(Current,[1],NewC),readData(II,N,NewC,Result);Ch is 79,!,append(Current,[2],NewC),readData(II,N,NewC,Result);append(Current,[0],NewC),readData(II,N,NewC,Result)).

bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-set_stream(user_input,buffer_size(128)),fill_buffer(user_input),readData(0,9,[],Result),Result = [A1,A2,A3,A4,A5,A6,A7,A8,A9],(check1(A1,A2,A3,A4,A5,A6,A7,A8,A9),!,bufferedWriteln('Johan har vunnit');check2(A1,A2,A3,A4,A5,A6,A7,A8,A9),!,bufferedWriteln('Abdullah har vunnit');bufferedWriteln('ingen har vunnit')).
