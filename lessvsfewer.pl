readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch<48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

complexRule(6956596).
complexRule(5580588).

rule(6956596,51).
rule(5580588,61).
rule(68038,51).
rule(68038,61).
rule(6007038,51).
rule(658638,61).
rule(68013,51).
rule(68013,61).
rule(600696,51).
rule(66037,61).
rule(66593,51).
rule(68466,61).
rule(6001,51).
rule(6645453,61).

readNouns(N,N).
readNouns(I,N):-II is I+1,readUInt(Noun),readUInt(Category),assert(noun(Noun,Category)),readNouns(II,N).

processPhrases(N,N).
processPhrases(I,N):-II is I+1,readUInt(Rule),(complexRule(Rule),!,readUInt(_);true),readUInt(Noun),(rule(Rule,Category),noun(Noun,Category),!,bufferedWriteln('Correct!');bufferedWriteln('Not on my watch!')),processPhrases(II,N).

bufferedWriteln(C):-with_output_to(user_output,writeln(C)).

main:-set_stream(user_input,buffer_size(131072)),fill_buffer(user_input),readUInt(N),readUInt(P),readNouns(0,N),processPhrases(0,P).