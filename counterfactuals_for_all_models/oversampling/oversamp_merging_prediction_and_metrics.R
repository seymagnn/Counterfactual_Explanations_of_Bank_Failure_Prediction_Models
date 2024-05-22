# merging prediction and metrics with IDRSSD

# DT
over_merged_df <- merge(over_df_results2, modelData_for_prediction, by = "IDRSSD")

over_merged_dt_data <- over_merged_df[, !(names(over_merged_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_rf", "Prediction_ext", "Prob_rf", "Prob_ext"))]

head(over_merged_dt_data)

over_filtered_dt <- over_merged_dt_data[over_merged_dt_data$Prediction_dt == 1, ]

head(over_filtered_dt)


# EXT
over_merged_ext_data <- over_merged_df[, !(names(over_merged_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_rf", "Prediction_dt", "Prob_rf", "Prob_dt"))]
colnames(over_merged_ext_data)[colnames(over_merged_ext_data) == "Prediction_ext"] <- "Label"
over_merged_ext_data <- over_merged_ext_data[,-8]
head(over_merged_ext_data)

over_filtered_ext <- over_merged_ext_data[over_merged_ext_data$Label == 1, ]

head(over_filtered_ext)


# RF
over_merged_rf_data <- over_merged_df[, !(names(over_merged_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_ext", "Prediction_dt", "Prob_ext", "Prob_dt"))]
colnames(over_merged_rf_data)[colnames(over_merged_rf_data) == "Prediction_rf"] <- "Label"
over_merged_rf_data <- over_merged_rf_data[,-8]

head(over_merged_rf_data)

over_filtered_rf <- over_merged_rf_data[over_merged_rf_data$Label == 1, ]

head(over_filtered_rf)

