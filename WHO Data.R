library(WHO)

CHO_Age_Stand <- get_data("CHOL_03")
CHO_Crude <- get_data("CHOL_04")
#CVD_Cerebrovascular_DALY <- get_data("SA_0000001689")
CVD_Cerebrovascular <- get_data("SA_0000001690")
#CVD_Ischaemic_DALY <- get_data("SA_0000001425")
CVD_Ischaemic <- get_data("SA_0000001444")

#Change the working directory
setwd("~/code-Stats/WHO")
save(CHO_Age_Stand, file="CHO_Age_Stand.RData")
save(CHO_Crude, file="CHO_Crude.RData")
#save(CVD_Cerebrovascular_DALY, file="CVD_Cerebrovascular_DALY.RData")
save(CVD_Cerebrovascular, file="CVD_Cerebrovascular.RData")
#save(CVD_Ischaemic_DALY, file="CVD_Ischaemic_DALY.RData")
save(CVD_Ischaemic, file="CVD_Ischaemic.RData")