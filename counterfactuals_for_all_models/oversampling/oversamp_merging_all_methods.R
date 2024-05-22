# merging all couterfactuals as a .Rda File

# What-if Results #
over_all_cfactuals_ext$CE_Method <- rep("WhatIf", nrow(over_all_cfactuals_ext))
over_all_cfactuals_ext$Used_Model <- rep("Extratrees", nrow(over_all_cfactuals_ext))

over_all_cfactuals_dt$CE_Method <- rep("WhatIf", nrow(over_all_cfactuals_dt))
over_all_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(over_all_cfactuals_dt))

over_all_cfactuals_rf$CE_Method <- rep("WhatIf", nrow(over_all_cfactuals_rf))
over_all_cfactuals_rf$Used_Model <- rep("Randomforest", nrow(over_all_cfactuals_rf))

oversamp_whatif_results <- rbind(over_all_cfactuals_ext, over_all_cfactuals_dt, over_all_cfactuals_rf, fill = TRUE)
save(oversamp_whatif_results, file = "oversamp_whatif_results.rda")

# MOC Results #

over_moc_cfactuals_ext$CE_Method <- rep("MOC", nrow(over_moc_cfactuals_ext))
over_moc_cfactuals_ext$Used_Model <- rep("Extratrees", nrow(over_moc_cfactuals_ext))

over_moc_cfactuals_dt$CE_Method <- rep("MOC", nrow(over_moc_cfactuals_dt))
over_moc_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(over_moc_cfactuals_dt))

over_moc_cfactuals_rf$CE_Method <- rep("MOC", nrow(over_moc_cfactuals_rf))
over_moc_cfactuals_rf$Used_Model <- rep("Randomforest", nrow(over_moc_cfactuals_rf))

oversamp_moc_results <- rbind(over_moc_cfactuals_ext, over_moc_cfactuals_dt, over_moc_cfactuals_rf, fill = TRUE)
save(oversamp_moc_results, file = "oversamp_moc_results.rda")


# NICE Results #

over_nice_cfactuals_ext$CE_Method <- rep("NICE", nrow(over_nice_cfactuals_ext))
over_nice_cfactuals_ext$Used_Model <- rep("Extratrees", nrow(over_nice_cfactuals_ext))

over_nice_cfactuals_dt$CE_Method <- rep("NICE", nrow(over_nice_cfactuals_dt))
over_nice_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(over_nice_cfactuals_dt))

over_nice_cfactuals_rf$CE_Method <- rep("NICE", nrow(over_nice_cfactuals_rf))
over_nice_cfactuals_rf$Used_Model <- rep("Randomforest", nrow(over_nice_cfactuals_rf))

oversamp_nice_results <- rbind(over_nice_cfactuals_ext, over_nice_cfactuals_dt, over_nice_cfactuals_rf, fill = TRUE)
save(oversamp_nice_results, file = "oversamp_nice_results.rda")



