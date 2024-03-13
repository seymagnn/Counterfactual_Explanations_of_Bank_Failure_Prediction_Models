load("~/Documents/UYIK2024_Counterfactual_Explanations_of_Bank_Failure_Prediction_Models/activeData.Rda")
load("~/Documents/UYIK2024_Counterfactual_Explanations_of_Bank_Failure_Prediction_Models/failureData.Rda")


# adding labels to active and failure dataset
activeData$Label <- 0
failureData$Label <- 1

df_edited2 <- data.frame()
maxDate <- max(activeData$Date)

# transforming them into data table and arranging dates
set.seed(123)
second_active_test_dt <- as.data.table(activeData) %>%
  filter(Date >= "2008-01-01" & Date <= "2013-12-31") %>%
  mutate(quarter = as.yearqtr(Date, format = "%Y-%m-%d"))

second_failure_test_dt <- as.data.table(failureData) %>%
  filter(Date >= "2008-01-01" & Date <= "2013-12-31") %>%
  mutate(quarter = as.yearqtr(Date, format = "%Y-%m-%d"))

second_failure_test_dt$lag1 <-
  lag(second_failure_test_dt$Date, n = 1)
second_failure_test_dt$lag1 <-
  second_failure_test_dt$Date - years(1)



df_list2 <- list(second_failure_test_dt, second_active_test_dt)

df_edited2 <- rbindlist(df_list2, fill = TRUE)

df_edited2$Label <- as.factor(df_edited2$Label)
df_edited2$Date <- as.Date(df_edited2$Date)

combined_df2 <- df_edited2 %>%
  select(-CERT)

combined_df2 <- combined_df2 %>%
  group_by(IDRSSD, Date) %>%
  mutate(TICRC = IDT1RWAJR / ASSET) %>%
  select(-IDT1RWAJR,-ASSET)


combined_df2$lag1 <-
  ifelse(combined_df2$Label == 0,
         as.Date(combined_df2$Date),
         as.Date(combined_df2$lag1))

combined_df2$lag1 <- as.Date(combined_df2$lag1)

combined_df2 <- combined_df2[!duplicated(combined_df2$IDRSSD),]
