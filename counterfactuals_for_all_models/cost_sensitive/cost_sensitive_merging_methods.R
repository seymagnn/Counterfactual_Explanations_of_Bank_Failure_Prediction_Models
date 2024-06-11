# merging all couterfactuals as a .Rda File

load("counterfactuals_for_all_models/cost_sensitive/CEs/moc_cfactuals_rf.rda")
load("counterfactuals_for_all_models/cost_sensitive/CEs/moc_cfactuals_ext.rda")
load("counterfactuals_for_all_models/cost_sensitive/CEs/moc_cfactuals_dt.rda")
load("counterfactuals_for_all_models/cost_sensitive/CEs/nice_cfactuals_rf.rda")
load("counterfactuals_for_all_models/cost_sensitive/CEs/nice_cfactuals_ext.rda")
load("counterfactuals_for_all_models/cost_sensitive/CEs/nice_cfactuals_dt.rda")
load("counterfactuals_for_all_models/cost_sensitive/CEs/all_cfactuals_rf.rda")
load("counterfactuals_for_all_models/cost_sensitive/CEs/all_cfactuals_ext.rda")
load("counterfactuals_for_all_models/cost_sensitive/CEs/all_cfactuals_dt.rda")

# What-if Results #
all_cfactuals_ext$CE_Method <- rep("WhatIf", nrow(all_cfactuals_ext))
all_cfactuals_ext$Used_Model <- rep("Extra trees", nrow(all_cfactuals_ext))

all_cfactuals_dt$CE_Method <- rep("WhatIf", nrow(all_cfactuals_dt))
all_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(all_cfactuals_dt))
 
all_cfactuals_rf$CE_Method <- rep("WhatIf", nrow(all_cfactuals_rf))
all_cfactuals_rf$Used_Model <- rep("Random forest", nrow(all_cfactuals_rf))

whatif_results <- rbind(all_cfactuals_ext, all_cfactuals_dt, all_cfactuals_rf, fill = TRUE)
save(whatif_results, file = "counterfactuals_for_all_models/cost_sensitive/cost_sensitive_whatif_results.rda")

# MOC Results #

moc_cfactuals_ext$CE_Method <- rep("MOC", nrow(moc_cfactuals_ext))
moc_cfactuals_ext$Used_Model <- rep("Extra trees", nrow(moc_cfactuals_ext))

moc_cfactuals_dt$CE_Method <- rep("MOC", nrow(moc_cfactuals_dt))
moc_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(moc_cfactuals_dt))

moc_cfactuals_rf$CE_Method <- rep("MOC", nrow(moc_cfactuals_rf))
moc_cfactuals_rf$Used_Model <- rep("Random forest", nrow(moc_cfactuals_rf))

moc_results <- rbind(moc_cfactuals_ext, moc_cfactuals_dt, moc_cfactuals_rf, fill = TRUE)
save(moc_results, file = "counterfactuals_for_all_models/cost_sensitive/cost_sensitive_moc_results.rda")


# NICE Results #

nice_cfactuals_ext$CE_Method <- rep("NICE", nrow(nice_cfactuals_ext))
nice_cfactuals_ext$Used_Model <- rep("Extra trees", nrow(nice_cfactuals_ext))

nice_cfactuals_dt$CE_Method <- rep("NICE", nrow(nice_cfactuals_dt))
nice_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(nice_cfactuals_dt))

nice_cfactuals_rf$CE_Method <- rep("NICE", nrow(nice_cfactuals_rf))
nice_cfactuals_rf$Used_Model <- rep("Random forest", nrow(nice_cfactuals_rf))

nice_results <- rbind(nice_cfactuals_ext, nice_cfactuals_dt, nice_cfactuals_rf, fill = TRUE)
save(nice_results, file = "counterfactuals_for_all_models/cost_sensitive/cost_sensitive_nice_results.rda")



