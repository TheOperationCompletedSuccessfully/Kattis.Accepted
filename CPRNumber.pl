readDigit(Number):-readDigit(-1,Number).
readDigit(-1,R):-!,get0(Ch),(Ch <48,!,readDigit(-1,R);R is Ch-48).

valid(0,4).
valid(1,3).
valid(2,2).
valid(3,7).
valid(4,6).
valid(5,5).
valid(6,4).
valid(7,3).
valid(8,2).
valid(9,1).

readData(N,N,Result,Result).
readData(I,N,CurrentSum,Result):-II is I+1,readDigit(D),valid(I,K),NewSum is CurrentSum + K*D,readData(II,N,NewSum,Result).


main:-readData(0,10,0,Sum),S is Sum rem 11,(S is 0,!,writeln(1);writeln(0)).