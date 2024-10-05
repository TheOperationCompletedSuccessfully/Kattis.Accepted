readPendingLine:-at_end_of_stream,!,true.
readPendingLine:-get0(Ch),(Ch is 10,!,true;readPendingLine).

solve(0,0,0,0):-!,writeln(1).
solve(0,0,0,_):-!,writeln(2).
solve(0,0,_,0):-!,writeln(2).
solve(0,_,0,0):-!,writeln(2).
solve(_,0,0,0):-!,writeln(2).
solve(0,0,_,_):-!,writeln(4).
solve(0,_,0,_):-!,writeln(4).
solve(_,0,0,_):-!,writeln(4).
solve(0,_,_,0):-!,writeln(4).
solve(_,0,_,0):-!,writeln(4).
solve(_,_,0,0):-!,writeln(4).
solve(0,_,_,_):-!,writeln(8).
solve(_,0,_,_):-!,writeln(8).
solve(_,_,0,_):-!,writeln(8).
solve(_,_,_,0):-!,writeln(8).
solve(_,_,_,_):-writeln(16).

main:-get0(Ch11),get0(Ch12),get0(Ch13),get0(Ch14),readPendingLine,get0(Ch21),get0(Ch22),get0(Ch23),get0(Ch24),Ch1 is abs(Ch11-Ch21),Ch2 is abs(Ch12-Ch22),Ch3 is abs(Ch13-Ch23),Ch4 is (Ch14-Ch24),solve(Ch1,Ch2,Ch3,Ch4).