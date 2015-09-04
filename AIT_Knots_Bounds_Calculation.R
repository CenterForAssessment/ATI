#########################################################
###
### Calculate Knots and Boundaries for ATI test data
###
##########################################################

### Load SGP Package

require(SGP)

### Load ATI data

ATI_Knots_Data <- fread('Data/Base_Files/_ASU_2014-15_PreMYPost_2015-08-18.csv')

###  Change the GRADE variable to remove the .1, .2 and .3 suffixes - calculate each grade's knots/bounds using entire data set
grade <- strsplit(ATI_Knots_Data$GRADE, "[.]")
grade <- sapply(grade, function(x) x[[1]][1])
ATI_Knots_Data[, GRADE := grade]

###  Create knots and boundaries
ATI_Knots_Bounds <- createKnotsBoundaries(ATI_Knots_Data)
str(ATI_Knots_Bounds)

###  Create a modified list that includes an entry with the .1, .2 and .3 suffixes for each grade
ATI_Knots_Boundaries <- list()
for(ca in c("MATHEMATICS", "READING")) {
	for (grade in 3:8) {
		for (year in 1:3) {
			ATI_Knots_Boundaries[[ca]][[paste("knots_", grade, ".", year, sep="")]] <- ATI_Knots_Bounds[[ca]][[paste("knots_", grade, sep="")]]
			ATI_Knots_Boundaries[[ca]][[paste("boundaries_", grade, ".", year, sep="")]] <- ATI_Knots_Bounds[[ca]][[paste("boundaries_", grade, sep="")]]
			ATI_Knots_Boundaries[[ca]][[paste("loss.hoss_", grade, ".", year, sep="")]] <- ATI_Knots_Bounds[[ca]][[paste("loss.hoss_", grade, sep="")]]
		}
	}
}

SGPstateData[["ATI"]][["Achievement"]][["Knots_Boundaries"]] <- ATI_Knots_Boundaries

save(ATI_Knots_Boundaries, file = 'ATI_Knots_Boundaries.Rda')


simpleMessage(c("\n\n\nSGPstateData[[\"ATI\"]][[\"Achievement\"]][[\"Knots_Boundaries\"]] <- list(", str(ATI_Knots_Boundaries), ")\n\n\n"))
