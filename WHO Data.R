library(dplyr)
library(ggplot2)
library(WHO)

#options(dplyr.width = Inf)

#codes <- get_codes()

 #codes[grepl("[Cc]holesterol", codes$display), ]
 #CHOL_03 = Mean Total Cholesterol (Age Standardized estimate)
 #CHOL_04 Mean Total Cholesterol (crude estimate) 

CHO_Age_Stand <- get_data("CHOL_03")
CHO_Age_Stand$value <- gsub( " *\\[.*?\\] *", "", CHO_Age_Stand$value)
which(is.na(as.numeric(as.character(CHO_Age_Stand[[8]]))))
CHO_Age_Stand$value <- as.numeric(CHO_Age_Stand$value)

CHO_Crude <- get_data("CHOL_04")
CHO_Crude$value <- gsub( " *\\[.*?\\] *", "", CHO_Crude$value)
CHO_Crude$value <- as.numeric(CHO_Crude$value)

#just for testing / inspection
#unique(CHO_Crude$region)

#Cardiovascular Death Rates
#codes[grepl("[Cc]erebrovascular", codes$display), ]
# DALY = http://www.who.int/healthinfo/global_burden_disease/metrics_daly/en/
 #SA_0000001689 Age-standardized DALYs, cerebrovascular disease, per 100,000
 #SA_0000001690 Age-standardized death rates, cerebrovascular disease, per 100,000
CVD_Cerebrovascular_DALY <- get_data("SA_0000001689")

#unique(CVD_Cerebrovascular_DALY$year) #only 2004 data

CVD_Cerebrovascular <- get_data("SA_0000001690")
#unique(CVD_Cerebrovascular$year) #only 2004 data

#codes[grepl("[Ii]schaemic", codes$display), ]
# DALY = http://www.who.int/healthinfo/global_burden_disease/metrics_daly/en/
 #SA_0000001425 Age-standardized DALYs, ischaemic heart disease, per 100,000
 #SA_0000001444 Age-standardized death rates, ischaemic heart disease, per 100,000
CVD_Ischaemic_DALY <- get_data("SA_0000001425")
CVD_Ischaemic <- get_data("SA_0000001444")

CVD_ALL <- merge(CVD_Cerebrovascular, CVD_Ischaemic, by=c("year", "region", "country", "sex", "publishstate"))
CVD_ALL$totalCVDvalue = CVD_ALL$value.x + CVD_ALL$value.y
colnames(CVD_ALL)[7] <- "cerrbrovascularValue"
colnames(CVD_ALL)[9] <- "ischaemicValue"
CVD_ALL$gho.y <- NULL
CVD_ALL$gho.x <- NULL

db <- merge(CVD_ALL, CHO_Crude, by=c("year", "region", "country", "sex", "publishstate"))
colnames(db)[11] <- "choCrudeValue"
db$gho <- NULL

db2 <- merge(db, CHO_Age_Stand, by=c("year", "region", "country", "sex", "publishstate", "agegroup"))
colnames(db2)[12] <- "choAgeStandValue"
db2$gho <- NULL
db2$publishstate <- NULL
db2$agegroup <- NULL

#Change the working directory
setwd("~/code-Stats/WHO")
filename <- "db.RData"

save(db2, file=filename)
