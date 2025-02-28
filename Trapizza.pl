:-use_module(moduleMyNumbers, [readUInt/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

main:-initiateBufferedRead(256),readUInt(D),readUInt(M1),readUInt(M2),readUInt(H),R is D/2,S1 is pi*R*R,S2 is H*(M1+M2)/2,(S1 < S2,!,bufferedWriteln('Trapizza!');S1>S2,!,bufferedWriteln('Mahjong!');bufferedWriteln('Jafn storar!')).