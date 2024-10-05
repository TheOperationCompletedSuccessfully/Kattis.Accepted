soundex(66,1).
soundex(70,1).
soundex(80,1).
soundex(86,1).

soundex(67,2).
soundex(71,2).
soundex(74,2).
soundex(75,2).
soundex(81,2).
soundex(83,2).
soundex(88,2).
soundex(90,2).

soundex(68,3).
soundex(84,3).

soundex(76,4).

soundex(77,5).
soundex(78,5).

soundex(82,6).

readData(_):-at_end_of_stream,!,true.
readData(Previous):-get0(Ch),(Ch is 10,!,nl,readData(0);(soundex(Ch,I),(I is Previous,!,readData(Previous);write(I),readData(I));readData(0))).
main:-readData(0).
