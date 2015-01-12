#################################################################################
###
### Initial script for reading in csv data and creating LONG data file
###
#################################################################################

### Load Data

ATI_Data_LONG <- read.csv("Data/Base_Files/SampleData_102414.csv", stringsAsFactors=FALSE)


### Tidy up date

ATI_Data_LONG$YEAR <- as.character(ATI_Data_LONG$YEAR)
ATI_Data_LONG$YEAR[ATI_Data_LONG$YEAR=="2013"] <- "2013.2"
ATI_Data_LONG$YEAR[ATI_Data_LONG$YEAR=="2014"] <- "2014.1"

ATI_Data_LONG$GRADE <- as.character(ATI_Data_LONG$GRADE)
ATI_Data_LONG$GRADE[ATI_Data_LONG$YEAR=="2013.2"] <- paste(ATI_Data_LONG$GRADE[ATI_Data_LONG$YEAR=="2013.2"], "2", sep=".")
ATI_Data_LONG$GRADE[ATI_Data_LONG$YEAR=="2014.1"] <- paste(ATI_Data_LONG$GRADE[ATI_Data_LONG$YEAR=="2014.1"], "1", sep=".")

ATI_Data_LONG$SCALE_SCORE <- as.numeric(ATI_Data_LONG$SCALE_SCORE)



### Save results

save(ATI_Data_LONG, file="Data/ATI_Data_LONG.Rdata")
