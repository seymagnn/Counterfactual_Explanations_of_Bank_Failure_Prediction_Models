# merging prediction and metrics with IDRSSD

# DT
merged_df <- merge(df_results2, modelData_for_prediction, by = "IDRSSD")

merged_dt_data <- merged_df[, !(names(merged_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_rf", "Prediction_ext", "Prob_rf", "Prob_ext"))]

head(merged_dt_data)

filtered_dt <- merged_dt_data[merged_dt_data$Prediction_dt == 1, ]

head(filtered_dt)


# EXT
merged_ext_data <- merged_df[, !(names(merged_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_rf", "Prediction_dt", "Prob_rf", "Prob_dt"))]
colnames(merged_ext_data)[colnames(merged_ext_data) == "Prediction_ext"] <- "Label"
merged_ext_data <- merged_ext_data[,-8]
head(merged_ext_data)

filtered_ext <- merged_ext_data[merged_ext_data$Label == 1, ]

head(filtered_ext)


# RF
merged_rf_data <- merged_df[, !(names(merged_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_ext", "Prediction_dt", "Prob_ext", "Prob_dt"))]
colnames(merged_rf_data)[colnames(merged_rf_data) == "Prediction_rf"] <- "Label"
merged_rf_data <- merged_rf_data[,-8]

head(merged_rf_data)

filtered_rf <- merged_rf_data[merged_rf_data$Label == 1, ]

head(filtered_rf)

