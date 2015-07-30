#########################################################
###
### Calculate EOCT SGPs for ATI for Pre-Post test 2014-15
###
##########################################################

### Load SGP Package

require(SGP)
require(data.table)

### Load ATI SGP object

ATI_Data_LONG <- fread('Data/Base_Files/_ASU_2014-15_PrePost_072015.csv')

my.tmp.split <- strsplit(ATI_Data_LONG$TestDate, "/")
ATI_Data_LONG[, DATE := as.Date(sapply(seq_along(my.tmp.split), function(x) paste(c(my.tmp.split[[x]][3], my.tmp.split[[x]][1:2]), collapse = "-")))]
setnames(ATI_Data_LONG, "Year", "YEAR")
### Load EOCT configurations

source("SGP_CONFIG/2015/READING.2015_PrePost.config")
source("SGP_CONFIG/2015/MATHEMATICS.2015_PrePost.config")

ATI.config <- c(
		READING.2015.config,
		MATHEMATICS.2015.config)


####################################################################################
###
### SGP Analyses
###
####################################################################################

ATI_SGP <- abcSGP(
		ATI_Data_LONG,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
		sgp.config=ATI.config,
		sgp.percentiles=TRUE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline= FALSE,
		sgp.projections.lagged.baseline=FALSE,
		SGPt=TRUE,
		simulate.sgps=FALSE)


### Save results

save(ATI_SGP, file="Data/ATI_SGP_PrePost.Rdata")


###  Output Long file

outputSGP(ATI_SGP, output.type="LONG_Data")
