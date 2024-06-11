# merging all couterfactuals as a .Rda File

load("counterfactuals_for_all_models/smote/CEs/smote_moc_cfactuals_rf.rda")
load("counterfactuals_for_all_models/smote/CEs/smote_moc_cfactuals_ext.rda")
load("counterfactuals_for_all_models/smote/CEs/smote_moc_cfactuals_dt.rda")
load("counterfactuals_for_all_models/smote/CEs/smote_nice_cfactuals_rf.rda")
load("counterfactuals_for_all_models/smote/CEs/smote_nice_cfactuals_ext.rda")
load("counterfactuals_for_all_models/smote/CEs/smote_nice_cfactuals_dt.rda")
load("counterfactuals_for_all_models/smote/CEs/smote_all_cfactuals_rf.rda")
load("counterfactuals_for_all_models/smote/CEs/smote_all_cfactuals_ext.rda")
load("counterfactuals_for_all_models/smote/CEs/smote_all_cfactuals_dt.rda")

# What-if Results #
smote_all_cfactuals_ext$CE_Method <- rep("WhatIf", nrow(smote_all_cfactuals_ext))
smote_all_cfactuals_ext$Used_Model <- rep("Extra trees", nrow(smote_all_cfactuals_ext))

smote_all_cfactuals_dt$CE_Method <- rep("WhatIf", nrow(smote_all_cfactuals_dt))
smote_all_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(smote_all_cfactuals_dt))

smote_all_cfactuals_rf$CE_Method <- rep("WhatIf", nrow(smote_all_cfactuals_rf))
smote_all_cfactuals_rf$Used_Model <- rep("Random forest", nrow(smote_all_cfactuals_rf))

smote_whatif_results <- rbind(smote_all_cfactuals_ext, smote_all_cfactuals_dt, smote_all_cfactuals_rf, fill = TRUE)
save(smote_whatif_results, file = "counterfactuals_for_all_models/smote/smote_whatif_results.rda")

# MOC Results #

smote_moc_cfactuals_ext$CE_Method <- rep("MOC", nrow(smote_moc_cfactuals_ext))
smote_moc_cfactuals_ext$Used_Model <- rep("Extra trees", nrow(smote_moc_cfactuals_ext))

smote_moc_cfactuals_dt$CE_Method <- rep("MOC", nrow(smote_moc_cfactuals_dt))
smote_moc_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(smote_moc_cfactuals_dt))

smote_moc_cfactuals_rf$CE_Method <- rep("MOC", nrow(smote_moc_cfactuals_rf))
smote_moc_cfactuals_rf$Used_Model <- rep("Random forest", nrow(smote_moc_cfactuals_rf))

smote_moc_results <- rbind(smote_moc_cfactuals_ext, smote_moc_cfactuals_dt, smote_moc_cfactuals_rf, fill = TRUE)
save(smote_moc_results, file = "counterfactuals_for_all_models/smote/smote_moc_results.rda")


# NICE Results #

smote_nice_cfactuals_ext$CE_Method <- rep("NICE", nrow(smote_nice_cfactuals_ext))
smote_nice_cfactuals_ext$Used_Model <- rep("Extra trees", nrow(smote_nice_cfactuals_ext))

smote_nice_cfactuals_dt$CE_Method <- rep("NICE", nrow(smote_nice_cfactuals_dt))
smote_nice_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(smote_nice_cfactuals_dt))

smote_nice_cfactuals_rf$CE_Method <- rep("NICE", nrow(smote_nice_cfactuals_rf))
smote_nice_cfactuals_rf$Used_Model <- rep("Random forest", nrow(smote_nice_cfactuals_rf))

smote_nice_results <- rbind(smote_nice_cfactuals_ext, smote_nice_cfactuals_dt, smote_nice_cfactuals_rf, fill = TRUE)
save(smote_nice_results, file = "counterfactuals_for_all_models/smote/smote_nice_results.rda")



