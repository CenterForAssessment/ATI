#########################################################
###
### Calculate EOCT SGPs for ATI for 2015-15
###
##########################################################

### Load SGP Package

require(SGP)
require(data.table)

### Load ATI SGP object

ATI_Data_LONG <- fread('Data/Base_Files/ATI_2014-15_MidYear.csv')


### Load EOCT configurations

source("SGP_CONFIG/2015/READING.2015.config")
source("SGP_CONFIG/2015/MATHEMATICS.2015.config")

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
		simulate.sgps=FALSE)


### Save results

save(ATI_SGP, file="Data/ATI_SGP.Rdata")
