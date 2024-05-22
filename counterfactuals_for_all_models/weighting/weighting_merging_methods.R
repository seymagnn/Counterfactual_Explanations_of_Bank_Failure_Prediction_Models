# merging all couterfactuals as a .Rda File

# What-if Results #
all_cfactuals_ext$CE_Method <- rep("WhatIf", nrow(all_cfactuals_ext))
all_cfactuals_ext$Used_Model <- rep("Extratrees", nrow(all_cfactuals_ext))

all_cfactuals_dt$CE_Method <- rep("WhatIf", nrow(all_cfactuals_dt))
all_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(all_cfactuals_dt))
 
all_cfactuals_rf$CE_Method <- rep("WhatIf", nrow(all_cfactuals_rf))
all_cfactuals_rf$Used_Model <- rep("Randomforest", nrow(all_cfactuals_rf))

whatif_results <- rbind(all_cfactuals_ext, all_cfactuals_dt, all_cfactuals_rf, fill = TRUE)
whatif_results <- whatif_results[,-13]
save(whatif_results, file = "weighting_whatif_results.rda")

# MOC Results #

moc_cfactuals_ext$CE_Method <- rep("MOC", nrow(moc_cfactuals_ext))
moc_cfactuals_ext$Used_Model <- rep("Extratrees", nrow(moc_cfactuals_ext))

moc_cfactuals_dt$CE_Method <- rep("MOC", nrow(moc_cfactuals_dt))
moc_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(moc_cfactuals_dt))

moc_cfactuals_rf$CE_Method <- rep("MOC", nrow(moc_cfactuals_rf))
moc_cfactuals_rf$Used_Model <- rep("Randomforest", nrow(moc_cfactuals_rf))

moc_results <- rbind(moc_cfactuals_ext, moc_cfactuals_dt, moc_cfactuals_rf, fill = TRUE)
save(moc_results, file = "weighting_moc_results.rda")


# NICE Results #

nice_cfactuals_ext$CE_Method <- rep("NICE", nrow(nice_cfactuals_ext))
nice_cfactuals_ext$Used_Model <- rep("Extratrees", nrow(nice_cfactuals_ext))

nice_cfactuals_dt$CE_Method <- rep("NICE", nrow(nice_cfactuals_dt))
nice_cfactuals_dt$Used_Model <- rep("Decision tree", nrow(nice_cfactuals_dt))

nice_cfactuals_rf$CE_Method <- rep("NICE", nrow(nice_cfactuals_rf))
nice_cfactuals_rf$Used_Model <- rep("Randomforest", nrow(nice_cfactuals_rf))

nice_results <- rbind(nice_cfactuals_ext, nice_cfactuals_dt, nice_cfactuals_rf, fill = TRUE)
save(nice_results, file = "weighting_nice_results.rda")



