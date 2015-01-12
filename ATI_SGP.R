#########################################################
###
### Calculate EOCT SGPs for ATI for 2013
###
##########################################################

### Load SGP Package

require(SGP)


### Load ATI SGP object

load("Data/ATI_Data_LONG.Rdata")


### Load EOCT configurations

source("SGP_CONFIG/2014/READING.2014.config")
source("SGP_CONFIG/2014/MATHEMATICS.2014.config")

ATI.config <- c(
		READING.2014.config,
		MATHEMATICS.2014.config)


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
