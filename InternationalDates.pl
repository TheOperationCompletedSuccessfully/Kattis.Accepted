:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

checkEU(A,B,Result):-(A<32,B<13,!,Result is 1;Result is 0).
checkUS(A,B,Result):-(A<13,B<32,!,Result is 1;Result is 0).

main:-initiateBufferedRead(256),readUInt(A),readUInt(B),readUInt(_),checkEU(A,B,R1),checkUS(A,B,R2),Result is 10*R1+R2,(Result is 11,!,bufferedWriteln('either');Result is 10,!,bufferedWriteln('EU');bufferedWriteln('US')).