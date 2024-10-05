readText(I,N,Data):-at_end_of_stream,!,(Data = [],!,N is I;assert(word(I,Data)),II is I+1,N is II).
readText(I,N,Data):-get0(Ch),(Ch is 10,!,(Data = [],!,N is I;assert(word(I,Data)),II is I+1,N is II);Ch is 32,!,assert(word(I,Data)),II is I+1,readText(II,N,[]);(forbidden(Ch),!,assert(forbiddenWord(I));true),append(Data,[Ch],NewData),readText(I,N,NewData)).

readForbiddenChars:-get0(Ch),(Ch is 10,!,true;assert(forbidden(Ch)),readForbiddenChars).

writeData([]).
writeData([H|T]):-char_code(Ch,H),bufferedWrite(Ch),writeData(T).

writeForbidden(N,N).
writeForbidden(I,N):-II is I+1,bufferedWrite('*'),writeForbidden(II,N).

writeText(N,N):-!,true.
writeText(0,N):-word(0,Data),(forbiddenWord(0),!,length(Data,Len),writeForbidden(0,Len);writeData(Data)),writeText(1,N).
writeText(I,N):-II is I+1,word(I,Data),bufferedWrite(' '),(forbiddenWord(I),!,length(Data,Len),writeForbidden(0,Len);writeData(Data)),writeText(II,N).

bufferedWrite(C):-with_output_to(user_output,write(C)).

main:-set_stream(user_input,buffer_size(131072)),fill_buffer(user_input),assert(forbiddenWord(-1)),readForbiddenChars,readText(0,N,[]),writeText(0,N).