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
set.seed(123)
model_dt_weights2 <- train(
  Label ~ .,
  data = train_data2,
  method = "rpart",
  weights = ifelse(train_data2$Label == 1, 5, 1)
)

forecast_dt2 <- predict(model_dt_weights2, modelData_for_prediction, type = "prob" )

df_forecast_dt2 <- data.frame(IDRSSD = IDRSSD_Prediction,
                              Prob_dt = forecast_dt2
) 

df_forecast_dt2 <- df_forecast_dt2 %>%
  mutate(Prediction_dt = ifelse(Prob_dt.0 > Prob_dt.1, 0, 1)) %>%
  mutate(Prob_dt = ifelse(Prediction_dt == 0, Prob_dt.0, Prob_dt.1))

df_forecast_dt2 <- df_forecast_dt2[-c(2,3)]

df_forecast_dt2$Prediction_dt <- as.factor(df_forecast_dt2$Prediction_dt)

### RandomForest Model ###
set.seed(123)
model_weights2_rf <- ranger(Label ~ .,
                            data = train_data2,
                            case.weights = ifelse(train_data2$Label == 1, 5, 1),
                            probability = TRUE)

forecast_rf2 <- predict(model_weights2_rf, modelData_for_prediction)

df_forecast_rf2 <- data.frame(IDRSSD = IDRSSD_Prediction,
                              Prob_rf = forecast_rf2
) 

df_forecast_rf2 <- df_forecast_rf2 %>%
  mutate(Prediction_rf = ifelse(Prob_rf.X0 > Prob_rf.X1, 0, 1)) %>%
  mutate(Prob_rf = ifelse(Prediction_rf == 0, Prob_rf.X0, Prob_rf.X1)) 


df_forecast_rf2 <- df_forecast_rf2[-c(2,3)]

df_forecast_rf2$Prediction_rf <- as.factor(df_forecast_rf2$Prediction_rf)

### ExtraTrees Model ###
set.seed(123)
model_weights2_ext <- ranger(
  Label ~ .,
  splitrule = "extratrees",
  data = train_data2,
  probability = TRUE,
  case.weights = ifelse(train_data2$Label == 1, 5, 1)
)


forecast_ext2 <- predict(model_weights2_ext, modelData_for_prediction)

df_forecast_ext2 <- data.frame(IDRSSD = IDRSSD_Prediction,
                               Prob_ext = forecast_ext2
) 

df_forecast_ext2 <- df_forecast_ext2 %>% 
  mutate(Prediction_ext = ifelse(Prob_ext.X0 > Prob_ext.X1, 0, 1)) %>%
  mutate(Prob_ext = ifelse(Prediction_ext == 0, Prob_ext.X0, Prob_ext.X1))

df_forecast_ext2 <- df_forecast_ext2[-c(2,3)]

df_forecast_ext2$Prediction_ext <- as.factor(df_forecast_ext2$Prediction_ext)


# merging models
merge_dt_rf2 <- merge(df_forecast_dt2,df_forecast_rf2,by="IDRSSD")
merge_dt_rf_ext2 <- merge(merge_dt_rf2,df_forecast_ext2,by="IDRSSD")


df_results2 <- merge_dt_rf_ext2 %>%
  mutate(OverAllProb = round((Prob_dt+Prob_rf+Prob_ext)/3,3)) %>%
  mutate(Prob_dt=round(Prob_dt,3),Prob_rf=round(Prob_rf,3),Prob_ext=round(Prob_ext,3))%>%
  mutate(OverAllPrediction = as.numeric(Prediction_dt)+as.numeric(Prediction_rf)+
           as.numeric(Prediction_ext)-3)
df_results2
