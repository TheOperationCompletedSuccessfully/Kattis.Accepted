:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

solve(N,N).
solve(I,N):-II is I+1,bufferedWriteln('Hipp hipp hurra!'),solve(II,N).

main:-solve(0,20).