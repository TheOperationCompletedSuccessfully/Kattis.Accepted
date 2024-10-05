readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

writePadded(N):-N<10,!,write('   '),write(N).
writePadded(N):-N<100,!,write('  '),write(N).
writePadded(N):-write(' '),write(N).

main:-readUInt(P),readUInt(W),(P is 0,!,SharpLen is 0;SharpLen is floor(W*P/100)),ZeroLen is W-SharpLen,write('['),string_concat('~',SharpLen,SS1),string_concat(SS1,'c',Format1),string_concat('~',ZeroLen,SS2),string_concat(SS2,'c',Format2),format(Format1,[35]),format(Format2,[45]),write('] |'),writePadded(P),writeln('%').