# merging prediction and metrics with IDRSSD

# DT
merged_org_df <- merge(df_org_results2, modelData_for_prediction, by = "IDRSSD")

merged_org_dt_data <- merged_org_df[, !(names(merged_org_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_rf", "Prediction_ext", "Prob_rf", "Prob_ext"))]

head(merged_org_dt_data)

filtered_org_dt <- merged_org_dt_data[merged_org_dt_data$Prediction_dt == 1, ]

head(filtered_org_dt)


# EXT
merged_org_ext_data <- merged_org_df[, !(names(merged_org_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_rf", "Prediction_dt", "Prob_rf", "Prob_dt"))]
colnames(merged_org_ext_data)[colnames(merged_org_ext_data) == "Prediction_ext"] <- "Label"
merged_org_ext_data <- merged_org_ext_data[,-8]
head(merged_org_ext_data)

filtered_org_ext <- merged_org_ext_data[merged_org_ext_data$Label == 1, ]

head(filtered_org_ext)


# RF
merged_org_rf_data <- merged_org_df[, !(names(merged_org_df) %in% c("OverAllProb", "OverAllPrediction", "Prediction_ext", "Prediction_dt", "Prob_ext", "Prob_dt"))]
colnames(merged_org_rf_data)[colnames(merged_org_rf_data) == "Prediction_rf"] <- "Label"
merged_org_rf_data <- merged_org_rf_data[,-8]

head(merged_org_rf_data)

filtered_org_rf <- merged_org_rf_data[merged_org_rf_data$Label == 1, ]

head(filtered_org_rf)

