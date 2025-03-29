:-use_module(moduleMyNumbers, [readUInt/1, readUIntUnsafe/1]).
:-use_module(moduleBufferedIO, [initiateBufferedRead/1,bufferedWrite/1,bufferedWriteln/1]).

astrologicalSign(['Aries'],114,144).
astrologicalSign(['Taurus'],145,175).
astrologicalSign(['Gemini'],176,207).
astrologicalSign(['Cancer'],208,239).
astrologicalSign(['Leo'],240,270).
astrologicalSign(['Virgo'],271,300).
astrologicalSign(['Libra'],301,332).
astrologicalSign(['Scorpio'],333,363).
astrologicalSign(['Sagittarius'],364,393).
astrologicalSign(['Capricorn'],394,500).
astrologicalSign(['Capricorn'],0,51).
astrologicalSign(['Aquarius'],52,81).
astrologicalSign(['Pisces'],82,113).

month(3152,1).
month(2780,2).
month(3456,3).
month(2406,4).
month(3463,5).
month(3352,6).
month(3350,7).
month(2445,8).
month(4094,9).
month(3678,10).
month(3700,11).
month(2581,12).

getSign(Key,Answer):-astrologicalSign(Sign,Key,_),!,Answer = Sign.
getSign(Key,Answer):-astrologicalSign(Sign,_,Key),!,Answer = Sign.
getSign(Key,Answer):-astrologicalSign(Sign,StartDay,EndDay),EndDay>Key,StartDay<Key,Answer = Sign.

writeAnswer(Answer):-Answer = [RawAnswer],bufferedWriteln(RawAnswer).

solve(N,N).
solve(I,N):-II is I+1,readUInt(Day),readUIntUnsafe(RawMonth),month(RawMonth,Month),Key is Month*31+Day,getSign(Key,Sign),writeAnswer(Sign),solve(II,N).

main:-initiateBufferedRead(8192),readUInt(T),solve(0,T).