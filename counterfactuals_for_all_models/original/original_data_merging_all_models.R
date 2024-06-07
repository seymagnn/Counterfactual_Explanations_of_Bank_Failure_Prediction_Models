# merging all couterfactuals as a .Rda File

# What-if Results #
org_all_cfactuals_ext$CE_Method <- rep("WhatIf", nrow(org_all_cfactuals_ext))
org_all_cfactuals_ext$Used_Model <- rep("Extratrees", nrow(org_all_cfactuals_ext))

org_all_cfactuals_dt$CE_Method <- rep("WhatIf", nrow(org_all_cfactuals_dt))
org_all_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(org_all_cfactuals_dt))

org_all_cfactuals_rf$CE_Method <- rep("WhatIf", nrow(org_all_cfactuals_rf))
org_all_cfactuals_rf$Used_Model <- rep("Randomforest", nrow(org_all_cfactuals_rf))

org_whatif_results <- rbind(org_all_cfactuals_ext, org_all_cfactuals_dt, org_all_cfactuals_rf, fill = TRUE)
save(org_whatif_results, file = "org_whatif_results.rda")

# MOC Results #

org_moc_cfactuals_ext$CE_Method <- rep("MOC", nrow(org_moc_cfactuals_ext))
org_moc_cfactuals_ext$Used_Model <- rep("Extratrees", nrow(org_moc_cfactuals_ext))

org_moc_cfactuals_dt$CE_Method <- rep("MOC", nrow(org_moc_cfactuals_dt))
org_moc_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(org_moc_cfactuals_dt))

org_moc_cfactuals_rf$CE_Method <- rep("MOC", nrow(org_moc_cfactuals_rf))
org_moc_cfactuals_rf$Used_Model <- rep("Randomforest", nrow(org_moc_cfactuals_rf))

org_moc_results <- rbind(org_moc_cfactuals_ext, org_moc_cfactuals_dt, org_moc_cfactuals_rf, fill = TRUE)
save(org_moc_results, file = "org_moc_results.rda")


# NICE Results #

org_nice_cfactuals_ext$CE_Method <- rep("NICE", nrow(org_nice_cfactuals_ext))
org_nice_cfactuals_ext$Used_Model <- rep("Extratrees", nrow(org_nice_cfactuals_ext))

org_nice_cfactuals_dt$CE_Method <- rep("NICE", nrow(org_nice_cfactuals_dt))
org_nice_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(org_nice_cfactuals_dt))

org_nice_cfactuals_rf$CE_Method <- rep("NICE", nrow(org_nice_cfactuals_rf))
org_nice_cfactuals_rf$Used_Model <- rep("Randomforest", nrow(org_nice_cfactuals_rf))

org_nice_results <- rbind(org_nice_cfactuals_ext, org_nice_cfactuals_dt, org_nice_cfactuals_rf, fill = TRUE)
save(org_nice_results, file = "org_nice_results.rda")



