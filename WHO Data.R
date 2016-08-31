library(dplyr)
library(WHO)

CHO_Age_Stand <- get_data("CHOL_03")
CHO_Age_Stand$value <- gsub( " *\\[.*?\\] *", "", CHO_Age_Stand$value)
which(is.na(as.numeric(as.character(CHO_Age_Stand[[8]]))))
CHO_Age_Stand$value <- as.numeric(CHO_Age_Stand$value)

CHO_Crude <- get_data("CHOL_04")
CHO_Crude$value <- gsub( " *\\[.*?\\] *", "", CHO_Crude$value)
CHO_Crude$value <- as.numeric(CHO_Crude$value)

CVD_Cerebrovascular_DALY <- get_data("SA_0000001689")
CVD_Cerebrovascular <- get_data("SA_0000001690")
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

choDeathData <- merge(db, CHO_Age_Stand, by=c("year", "region", "country", "sex", "publishstate", "agegroup"))
colnames(choDeathData)[12] <- "choAgeStandValue"
choDeathData$gho <- NULL
choDeathData$publishstate <- NULL
choDeathData$agegroup <- NULL
choDeathData$sex <- as.factor((choDeathData$sex))

#Change the working directory
setwd("~/code-Stats/WHO")
filename <- "choDeathData.RData"

save(choDeathData, file=filename)
