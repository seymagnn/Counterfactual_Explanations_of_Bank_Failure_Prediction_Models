### data for forecast ###

predictionData <- activeData

predictionData <- predictionData %>%
  group_by(IDRSSD, Date) %>%
  mutate(TICRC = IDT1RWAJR / ASSET) %>%
  select(-IDT1RWAJR, -ASSET)

predictionDataDT <- setDT(predictionData)

predictionDataDT <- predictionDataDT[Date <= as.Date("2023-12-31") & Date >= as.Date("2014-01-01")]

predictionDataDT <- na.omit(predictionDataDT)


modelData_for_prediction <- predictionDataDT %>%
  group_by(IDRSSD) %>%
  select(-Date) %>%
  unique() %>%
  na.omit() %>%
  distinct(IDRSSD, .keep_all = TRUE)

modelData_for_prediction$Label <- as.factor(modelData_for_prediction$Label)

IDRSSD_Prediction <- modelData_for_prediction$IDRSSD

### Decision Tree Model ###
# SMOTE
set.seed(123)
train_data2$Label <- as.numeric(train_data2$Label)
new_df2 <- SMOTE(train_data2, train_data2$Label)

new_df2$data <- new_df2$data[,-7]

new_df2$data$Label <- ifelse(new_df2$data$Label == "1", "0", "1")

model_dt_smote_2 <- train(Label ~ .,
                          data = new_df2$data,
                          method = "rpart")

smote_forecast_dt2 <- predict(model_dt_smote_2, modelData_for_prediction, type = "prob" )

smote_df_forecast_dt2 <- data.frame(IDRSSD = IDRSSD_Prediction,
                                   Prob_dt = smote_forecast_dt2
) 

smote_df_forecast_dt2 <- smote_df_forecast_dt2 %>%
  mutate(Prediction_dt = ifelse(Prob_dt.0 > Prob_dt.1, 0, 1)) %>%
  mutate(Prob_dt = ifelse(Prediction_dt == 0, Prob_dt.0, Prob_dt.1))

smote_df_forecast_dt2 <- smote_df_forecast_dt2[-c(2,3)]

smote_df_forecast_dt2$Prediction_dt <- as.factor(smote_df_forecast_dt2$Prediction_dt)

### RandomForest Model ###
# SMOTE
set.seed(123)
train_data2$Label <- as.numeric(train_data2$Label)
new_df2 <- SMOTE(train_data2, train_data2$Label)
new_df2$data <- new_df2$data[-7]
new_df2$data$Label <- ifelse(new_df2$data$Label == "1", "0", "1")
new_df2$data$Label <- as.factor(new_df2$data$Label)

model_smote2_rf <- ranger(Label ~ .,
                         data = new_df2$data,
                         probability = TRUE)

smote_forecast_rf2 <- predict(model_smote2_rf, modelData_for_prediction)

smote_df_forecast_rf2 <- data.frame(IDRSSD = IDRSSD_Prediction,
                                   Prob_rf = smote_forecast_rf2
) 

smote_df_forecast_rf2 <- smote_df_forecast_rf2 %>%
  mutate(Prediction_rf = ifelse(Prob_rf.X0 > Prob_rf.X1, 0, 1)) %>%
  mutate(Prob_rf = ifelse(Prediction_rf == 0, Prob_rf.X0, Prob_rf.X1)) 


smote_df_forecast_rf2 <- smote_df_forecast_rf2[-c(2,3)]

smote_df_forecast_rf2$Prediction_rf <- as.factor(smote_df_forecast_rf2$Prediction_rf)

### ExtraTrees Model ###
# SMOTE
set.seed(123)
model_smote2_ext <- ranger(Label ~ .,
                          splitrule = "extratrees",
                          data = new_df2$data,
                          probability = TRUE)

smote_forecast_ext2 <- predict(model_smote2_ext, modelData_for_prediction)

smote_df_forecast_ext2 <- data.frame(IDRSSD = IDRSSD_Prediction,
                                    Prob_ext = smote_forecast_ext2
) 

smote_df_forecast_ext2 <- smote_df_forecast_ext2 %>% 
  mutate(Prediction_ext = ifelse(Prob_ext.X0 > Prob_ext.X1, 0, 1)) %>%
  mutate(Prob_ext = ifelse(Prediction_ext == 0, Prob_ext.X0, Prob_ext.X1))

smote_df_forecast_ext2 <- smote_df_forecast_ext2[-c(2,3)]

smote_df_forecast_ext2$Prediction_ext <- as.factor(smote_df_forecast_ext2$Prediction_ext)


# merging models
smote_merge_dt_rf2 <- merge(smote_df_forecast_dt2, smote_df_forecast_rf2, by="IDRSSD")
smote_merge_dt_rf_ext2 <- merge(smote_merge_dt_rf2, smote_df_forecast_ext2, by="IDRSSD")


smote_df_results2 <- smote_merge_dt_rf_ext2 %>%
  mutate(OverAllProb = round((Prob_dt+Prob_rf+Prob_ext)/3,3)) %>%
  mutate(Prob_dt=round(Prob_dt,3),Prob_rf=round(Prob_rf,3),Prob_ext=round(Prob_ext,3))%>%
  mutate(OverAllPrediction = as.numeric(Prediction_dt)+as.numeric(Prediction_rf)+
           as.numeric(Prediction_ext)-3)
smote_df_results2
