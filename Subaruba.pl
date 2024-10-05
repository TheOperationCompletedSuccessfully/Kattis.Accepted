readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

vowel(Ch):-(bigVowel(Ch);smallVowel(Ch)).

smallVowel(97).
smallVowel(101).
smallVowel(105).
smallVowel(111).
smallVowel(117).
smallVowel(121).
bigVowel(65).
bigVowel(69).
bigVowel(73).
bigVowel(79).
bigVowel(85).
bigVowel(89).

enc1(Ch):-(bigEnc1(Ch);smallEnc1(Ch)).

bigEnc1(85).
smallEnc1(117).

enc2(66).
enc2(98).


trans([A,B,C],Result):-enc1(A),enc2(B),vowel(C),!,Result = [C].
trans([A,B,C],Result):-!,Result = [A,B,C].

translate(N,N,_,_).
translate(I,N,[],65):-!,get0(Ch),!,(Ch < 32,!,II is I+1,nl,translate(II,N,[],65);translate(I,N,[Ch],65)).
translate(I,N,[A],65):-!,get0(Ch),!,(Ch < 32,!,II is I+1,char_code(C,A),bufferedWriteln(C),translate(II,N,[],65);translate(I,N,[A,Ch],65)).
translate(I,N,[A,B],65):-!,get0(Ch),!,(Ch < 32,!,II is I+1,char_code(C,A),bufferedWrite(C),char_code(D,B),bufferedWriteln(D),translate(II,N,[],65);trans([A,B,Ch],Tr),Tr = [H|T],!,char_code(C,H),bufferedWrite(C),translate(I,N,T,65)).

translate(I,N,[],68):-!,get0(Ch),!,(Ch < 32,!,II is I+1,nl,translate(II,N,[],68);char_code(AA,Ch),(bigVowel(Ch),!,bigEnc1(H),char_code(HH,H),bufferedWrite(HH),bufferedWrite('b'),bufferedWrite(AA);smallVowel(Ch),!,smallEnc1(H),char_code(HH,H),bufferedWrite(HH),bufferedWrite('b'),bufferedWrite(AA);bufferedWrite(AA)),translate(I,N,[],68)).

bufferedWrite(C):-with_output_to(user_output,write(C)).
bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-set_stream(user_input,buffer_size(262144)),fill_buffer(user_input),get0(TranslateDirection),readUInt(Lines),translate(0,Lines,[],TranslateDirection).