readUInt(Number):-readUInt(-1,Number).
readUInt(-1,R):-!,get0(Ch),(Ch <48,!,readUInt(-1,R);I1 is Ch-48,readUInt(I1,R)).
readUInt(I,R):-get0(Ch),(Ch <48,!,R is I;I1 is I*10+Ch-48,readUInt(I1,R)).

readPendingLine:-at_end_of_stream,!,true.
readPendingLine:-get0(Ch),(Ch is 10,!,true;readPendingLine).

readData(N,N,CVY,CVN,CAYY,CAYN,CANY,CANN,CBYY,CBYN,CBNY,CBNN,CCYY,CCYN,CCNY,CCNN,VY,VN,AYY,AYN,ANY,ANN,BYY,BYN,BNY,BNN,CYY,CYN,CNY,CNN):-!,VY is CVY,VN is CVN,AYY is CAYY,AYN is CAYN,ANY is CANY,ANN is CANN,BYY is CBYY,BYN is CBYN,BNY is CBNY,BNN is CBNN,CYY is CCYY,CYN is CCYN,CNY is CCNY,CNN is CCNN.
readData(I,N,CVY,CVN,CAYY,CAYN,CANY,CANN,CBYY,CBYN,CBNY,CBNN,CCYY,CCYN,CCNY,CCNN,VY,VN,AYY,AYN,ANY,ANN,BYY,BYN,BNY,BNN,CYY,CYN,CNY,CNN):-I1 is I+1,get0(Ch1),get0(Ch2),get0(Ch3),get0(Ch4),readPendingLine,
(Ch1 is 78,!,NewCVY is CVY,NewCVN is CVN+1,
(Ch2 is 78,!,NewCANN is CANN + 1,NewCANY is CANY;NewCANN is CANN,NewCANY is CANY+1),
(Ch3 is 78,!,NewCBNN is CBNN+1,NewCBNY is CBNY;NewCBNN is CBNN,NewCBNY is CBNY + 1),
(Ch4 is 78,!,NewCCNN is CCNN+1,NewCCNY is CCNY;NewCCNN is CCNN,NewCCNY is CCNY+1),
NewCAYN is CAYN,NewCAYY is CAYY,NewCBYN is CBYN,NewCBYY is CBYY,NewCCYN is CCYN,NewCCYY is CCYY
;NewCVY is CVY+1,NewCVN is CVN,
(Ch2 is 78,!,NewCAYN is CAYN+1,NewCAYY is CAYY;NewCAYN is CAYN,NewCAYY is CAYY+1),
(Ch3 is 78,!,NewCBYN is CBYN+1,NewCBYY is CBYY;NewCBYN is CBYN,NewCBYY is CBYY+1),
(Ch4 is 78,!,NewCCYN is CCYN+1,NewCCYY is CCYY;NewCCYN is CCYN,NewCCYY is CCYY+1),
NewCANN is CANN,NewCANY is CANY,NewCBNN is CBNN,NewCBNY is CBNY,NewCCNY is CCNY,NewCCNN is CCNN),
readData(I1,N,NewCVY,NewCVN,NewCAYY,NewCAYN,NewCANY,NewCANN,NewCBYY,NewCBYN,NewCBNY,NewCBNN,NewCCYY,NewCCYN,NewCCNY,NewCCNN,VY,VN,AYY,AYN,ANY,ANN,BYY,BYN,BNY,BNN,CYY,CYN,CNY,CNN).

writeAnswer(VaccinatedInfectionRate,ControlGroupInfectionRate):-VaccinatedInfectionRate>=ControlGroupInfectionRate,!,writeln('Not Effective').
writeAnswer(VaccinatedInfectionRate,ControlGroupInfectionRate):-ReductionRate is 100-100*VaccinatedInfectionRate/ControlGroupInfectionRate,writeln(ReductionRate).

main:-readUInt(Count),readData(0,Count,0,0,0,0,0,0,0,0,0,0,0,0,0,0,VY,VN,AYY,AYN,ANY,ANN,BYY,BYN,BNY,BNN,CYY,CYN,CNY,CNN),VaccinatedInfectionRateA is AYY/VY,VaccinatedInfectionRateB is BYY/VY,VaccinatedInfectionRateC is CYY/VY,ControlGroupInfectionRateA is ANY/VN,ControlGroupInfectionRateB is BNY/VN,ControlGroupInfectionRateC is CNY/VN,writeAnswer(VaccinatedInfectionRateA,ControlGroupInfectionRateA),writeAnswer(VaccinatedInfectionRateB,ControlGroupInfectionRateB),writeAnswer(VaccinatedInfectionRateC,ControlGroupInfectionRateC).