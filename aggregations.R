##################################################################
# Stunden daten aufbauen fuer VITALPARAMETER (Aggregation = mean)
##################################################################
vitals.ARTs <- aggregate(ARTs ~ PatientID + hours, data = vitals, FUN = mean, na.action = na.omit)
vitals.ARTm <- aggregate(ARTm ~ PatientID + hours, data = vitals, mean, na.action = na.omit)
vitals.ARTd <- aggregate(ARTd ~ PatientID + hours, data = vitals, mean, na.action = na.omit)

vitals.NIBPsys <- aggregate(NIBPsys ~ PatientID + hours, data = vitals, mean, na.action = na.omit)
vitals.NIBPdia <- aggregate(NIBPdia ~ PatientID + hours, data = vitals, mean, na.action = na.omit)

vitals.HF <- aggregate(HF ~ PatientID + hours, data = vitals, mean, na.action = na.omit)
vitals.Temp1 <- aggregate(Temp1 ~ PatientID + hours, data = vitals, mean, na.action = na.omit)
vitals.Temp2 <- aggregate(Temp2 ~ PatientID + hours, data = vitals, mean, na.action = na.omit)
vitals.TempManuell <- aggregate(TempManuell ~ PatientID + hours, data = vitals, mean, na.action = na.omit)

vitals.AFspont <- aggregate(AFspont ~ PatientID + hours, data = vitals, mean, na.action = na.omit)
vitals.AFImped <- aggregate(AFImped ~ PatientID + hours, data = vitals, mean, na.action = na.omit)
vitals.SpO2 <- aggregate(SpO2 ~ PatientID + hours, data = vitals, mean, na.action = na.omit)

##################################################################
# Stunden daten aufbauen fuer SEDATIVA - Aggregation = mean
##################################################################
sedatives.dose <- aggregate(GivenDose ~ PatientID + hours + PreparationName + PreparationID, data = sedatives, FUN = sum, na.action = na.omit)


##################################################################
# Sammelframe bauen
##################################################################
tmp<-0
tmp <-merge(vitals.ARTs, vitals.ARTm, all=TRUE)
tmp <-merge(tmp, vitals.ARTd, all=TRUE)
tmp <-merge(tmp, vitals.NIBPsys, all=TRUE)
tmp <-merge(tmp, vitals.NIBPdia, all=TRUE)
tmp <-merge(tmp, vitals.HF, all=TRUE)
tmp <-merge(tmp, vitals.Temp1, all=TRUE)
tmp <-merge(tmp, vitals.Temp2, all=TRUE)
tmp <-merge(tmp, vitals.TempManuell, all=TRUE)
tmp <-merge(tmp, vitals.AFspont, all=TRUE)
tmp <-merge(tmp, vitals.AFImped, all=TRUE)
vitals.h <-merge(tmp, vitals.SpO2, all=TRUE)
vitals.comb <-merge(vitals.h,l.times, all=TRUE)
vitals.comb$hours <- as.POSIXlt(vitals.comb$hours, format="%Y-%m-%d %H:%M:%S")

rm(vitals.h, tmp, vitals.ARTs, vitals.ARTm, vitals.ARTd, vitals.NIBPsys, vitals.NIBPdia, vitals.HF, vitals.Temp1, vitals.Temp2, vitals.TempManuell, vitals.AFspont, vitals.AFImped, vitals.SpO2)




##################################################################
# Differenzzeit in Minuten ausrechen
##################################################################
vitals.comb$dTL.first <- difftime(vitals.comb$hours, vitals.comb$TL_timefirst, units="mins")
vitals.comb$dTL.last <- difftime(vitals.comb$hours, vitals.comb$TL_timelast, units="mins")
vitals.comb$dCat.first <- difftime(vitals.comb$hours, vitals.comb$cat_first, units="mins")
vitals.comb$dCat.last <- difftime(vitals.comb$hours, vitals.comb$cat_last, units="mins")

vitals.comb$dTub.start <- difftime(vitals.comb$hours, vitals.comb$tubus_starttime, units="mins")
vitals.comb$dTub.end <- difftime(vitals.comb$hours, vitals.comb$tubus_endtime, units="mins")

vitals.comb$dAdm <- difftime(vitals.comb$hours, vitals.comb$AdmTime, units="mins")
vitals.comb$dD <- difftime(vitals.comb$hours, vitals.comb$Todeszeitpunkt, units="mins")


##################################################################
#Daten exportieren
##################################################################
vitals.exp <- vitals.comb
vitals.exp$hours <- format(vitals.exp$hours, "%d-%b-%Y %H:%M:%S")
vitals.exp$TL_timefirst <- format(vitals.exp$TL_timefirst, "%d-%b-%Y %H:%M:%S")
vitals.exp$TL_timelast <- format(vitals.exp$TL_timelast, "%d-%b-%Y %H:%M:%S")
vitals.exp$cat_first <- format(vitals.exp$cat_first, "%d-%b-%Y %H:%M:%S")
vitals.exp$cat_last <- format(vitals.exp$cat_last, "%d-%b-%Y %H:%M:%S")
vitals.exp$tubus_starttime <- format(vitals.exp$tubus_starttime, "%d-%b-%Y %H:%M:%S")
vitals.exp$tubus_endtime <- format(vitals.exp$tubus_endtime, "%d-%b-%Y %H:%M:%S")
vitals.exp$AdmTime <- format(vitals.exp$AdmTime, "%d-%b-%Y %H:%M:%S")
vitals.exp$Todeszeitpunkt <- format(vitals.exp$Todeszeitpunkt, "%d-%b-%Y %H:%M:%S")


write.table(vitals.exp, "D:\\projects\\ELC NCC\\data\\raw\\rainer export\\vitalsexp.txt", row.names = FALSE, sep=";")
#library("foreign", lib.loc="C:/science/R/R-3.2.1/library")
#write.foreign(vitals.exp, "D:\\projects\\ELC NCC\\data\\raw\\rainer export\\vitalsexp.txt", "D:\\projects\\ELC NCC\\data\\raw\\rainer export\\vitalsexp.sav", package="SPSS")


###################################################################
### Merge Test
###################################################################
tmp1 <- data.frame(ID=c(rep("Hansi",5),rep("Susi",3),rep("Mausi",7)),time=c(1:5,1:3,1:7), data=1:15)
tmp2 <- data.frame(ID=c(rep("Hansi",3),rep("Susi",7),rep("Mausi",5)),time=c(2:4,4:10,6:10), data1=21:35)
tmp3 <- merge(tmp1,tmp2,all = TRUE)
####################### works


