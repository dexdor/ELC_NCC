library("class", lib.loc="C:/science/R/R-3.2.1/library")


################################################
# Import limitation times and recode Date
################################################
l.times <- read.csv("D:/projects/ELC NCC/data/raw/rainer export/Limitation_times_wH.txt", sep=";")

l.times$TL_timefirst <- as.POSIXlt(l.times$TL_timefirst, format="%m/%d/%Y %H:%M:%S")
l.times$TL_timelast <- as.POSIXlt(l.times$TL_timelast, format="%m/%d/%Y %H:%M:%S")

l.times$cat_first <- as.POSIXlt(l.times$cat_first, format="%m/%d/%Y %H:%M:%S")
l.times$cat_last <- as.POSIXlt(l.times$cat_last, format="%m/%d/%Y %H:%M:%S")

l.times$tubus_starttime <- as.POSIXlt(l.times$tubus_starttime, format="%m/%d/%Y %H:%M:%S")
l.times$tubus_endtime <- as.POSIXlt(l.times$tubus_endtime, format="%m/%d/%Y %H:%M:%S")

l.times$AdmTime <- as.POSIXlt(l.times$AdmTime, format="%m/%d/%Y %H:%M:%S")
l.times$Todeszeitpunkt <- as.POSIXlt(l.times$Todeszeitpunkt, format="%m/%d/%Y %H:%M:%S")

################################################
# Import Vital parameters and recode Date
################################################
vitals <- read.csv("D:/projects/ELC NCC/data/raw/rainer export/Vitals_wH.txt", sep=";")
vitals$PatientID <- as.factor(vitals$PatientID)
vitals$Datetime <- as.POSIXlt(vitals$Datetime, format="%Y-%m-%d %H:%M:%S")
vitals$hours <- format(vitals$Datetime, "%Y-%m-%d %H:00:00")
#no Posix tranform for hours otherwise aggregate function will not work
#vitals$hours <- as.POSIXlt(vitals$hours, format="%m/%d/%Y %H:%M:%S")
vitals$Datetime <- as.POSIXlt(vitals$Datetime, format="%m/%d/%Y %H:%M:%S")

################################################
# Import sedatives and recode Date
################################################
sedatives <- read.csv("D:/projects/ELC NCC/data/raw/rainer export/vital_sedatives_ELC_all.csv", sep=";")
sedatives$GivenAt <- as.POSIXlt(sedatives$GivenAt, format="%Y-%m-%d %H:%M:%S")
sedatives$hours <- format(sedatives$GivenAt, "%Y-%m-%d %H:00:00")
#no Posix tranform for hours otherwise aggregate function will not work
#sedatives$hours <- as.POSIXlt(sedatives$hours, format="%Y-%m-%d %H:%M:%S")
sedatives$GivenAt <- as.POSIXlt(sedatives$GivenAt, format="%m/%d/%Y %H:%M:%S")
sedatives$PatientID <- as.factor(sedatives$PatientID)
sedatives$PreparationID <- as.factor(sedatives$PreparationID)
sedatives$PreparationName <- as.factor(sedatives$PreparationName)

