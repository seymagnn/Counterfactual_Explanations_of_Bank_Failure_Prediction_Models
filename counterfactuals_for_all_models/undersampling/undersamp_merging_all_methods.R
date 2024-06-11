# merging all couterfactuals as a .Rda File

load("counterfactuals_for_all_models/undersampling/CEs/under_moc_cfactuals_ext.rda")
load("counterfactuals_for_all_models/undersampling/CEs/under_moc_cfactuals_rf.rda")
load("counterfactuals_for_all_models/undersampling/CEs/under_moc_cfactuals_dt.rda")
load("counterfactuals_for_all_models/undersampling/CEs/under_nice_cfactuals_rf.rda")
load("counterfactuals_for_all_models/undersampling/CEs/under_nice_cfactuals_ext.rda")
load("counterfactuals_for_all_models/undersampling/CEs/under_nice_cfactuals_dt.rda")
load("counterfactuals_for_all_models/undersampling/CEs/under_all_cfactuals_rf.rda")
load("counterfactuals_for_all_models/undersampling/CEs/under_all_cfactuals_ext.rda")
load("counterfactuals_for_all_models/undersampling/CEs/under_all_cfactuals_dt.rda")

# What-if Results #
under_all_cfactuals_ext$CE_Method <- rep("WhatIf", nrow(under_all_cfactuals_ext))
under_all_cfactuals_ext$Used_Model <- rep("Extra trees", nrow(under_all_cfactuals_ext))

under_all_cfactuals_dt$CE_Method <- rep("WhatIf", nrow(under_all_cfactuals_dt))
under_all_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(under_all_cfactuals_dt))

under_all_cfactuals_rf$CE_Method <- rep("WhatIf", nrow(under_all_cfactuals_rf))
under_all_cfactuals_rf$Used_Model <- rep("Random forest", nrow(under_all_cfactuals_rf))

undersamp_whatif_results <- rbind(under_all_cfactuals_ext, under_all_cfactuals_dt, under_all_cfactuals_rf, fill = TRUE)
# undersamp_whatif_results <- undersamp_whatif_results[,-13]
save(undersamp_whatif_results, file = "counterfactuals_for_all_models/undersampling/undersamp_whatif_results.rda")

# MOC Results #

under_moc_cfactuals_ext$CE_Method <- rep("MOC", nrow(under_moc_cfactuals_ext))
under_moc_cfactuals_ext$Used_Model <- rep("Extra trees", nrow(under_moc_cfactuals_ext))

under_moc_cfactuals_dt$CE_Method <- rep("MOC", nrow(under_moc_cfactuals_dt))
under_moc_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(under_moc_cfactuals_dt))

under_moc_cfactuals_rf$CE_Method <- rep("MOC", nrow(under_moc_cfactuals_rf))
under_moc_cfactuals_rf$Used_Model <- rep("Random forest", nrow(under_moc_cfactuals_rf))

undersamp_moc_results <- rbind(under_moc_cfactuals_ext, under_moc_cfactuals_dt, under_moc_cfactuals_rf, fill = TRUE)
save(undersamp_moc_results, file = "counterfactuals_for_all_models/undersampling/undersamp_moc_results.rda")


# NICE Results #

under_nice_cfactuals_ext$CE_Method <- rep("NICE", nrow(under_nice_cfactuals_ext))
under_nice_cfactuals_ext$Used_Model <- rep("Extra trees", nrow(under_nice_cfactuals_ext))

under_nice_cfactuals_dt$CE_Method <- rep("NICE", nrow(under_nice_cfactuals_dt))
under_nice_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(under_nice_cfactuals_dt))

under_nice_cfactuals_rf$CE_Method <- rep("NICE", nrow(under_nice_cfactuals_rf))
under_nice_cfactuals_rf$Used_Model <- rep("Random forest", nrow(under_nice_cfactuals_rf))

undersamp_nice_results <- rbind(under_nice_cfactuals_ext, under_nice_cfactuals_dt, under_nice_cfactuals_rf, fill = TRUE)
save(undersamp_nice_results, file = "counterfactuals_for_all_models/undersampling/undersamp_nice_results.rda")



