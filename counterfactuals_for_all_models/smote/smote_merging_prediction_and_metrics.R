# merging prediction and metrics with IDRSSD

# DT
smote_merged_df <- merge(smote_df_results2, modelData_for_prediction, by = "IDRSSD")

smote_merged_dt_data <- smote_merged_df[, !(names(smote_merged_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_rf", "Prediction_ext", "Prob_rf", "Prob_ext"))]

head(smote_merged_dt_data)

smote_filtered_dt <- smote_merged_dt_data[smote_merged_dt_data$Prediction_dt == 1, ]

head(smote_filtered_dt)


# EXT
smote_merged_ext_data <- smote_merged_df[, !(names(smote_merged_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_rf", "Prediction_dt", "Prob_rf", "Prob_dt"))]
colnames(smote_merged_ext_data)[colnames(smote_merged_ext_data) == "Prediction_ext"] <- "Label"
smote_merged_ext_data <- smote_merged_ext_data[,-8]
head(smote_merged_ext_data)

smote_filtered_ext <- smote_merged_ext_data[smote_merged_ext_data$Label == 1, ]

head(smote_filtered_ext)


# RF
smote_merged_rf_data <- smote_merged_df[, !(names(smote_merged_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_ext", "Prediction_dt", "Prob_ext", "Prob_dt"))]
colnames(smote_merged_rf_data)[colnames(smote_merged_rf_data) == "Prediction_rf"] <- "Label"
smote_merged_rf_data <- smote_merged_rf_data[,-8]

head(smote_merged_rf_data)

smote_filtered_rf <- smote_merged_rf_data[smote_merged_rf_data$Label == 1, ]

head(smote_filtered_rf)

