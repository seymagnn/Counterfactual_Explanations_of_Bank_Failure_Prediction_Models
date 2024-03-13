# Splitting data into two different subset as train and validation test set
set.seed(123)
combined_df2 <- combined_df2[,-c(5, 6, 8, 9)]
trainIndex <-
  createDataPartition(combined_df2$Label, p = 0.8, list = FALSE)
train_data2 <- combined_df2[trainIndex,]
validation_test_data2 <- combined_df2[-trainIndex, ]

train_data2 <- na.omit(train_data2)
validation_test_data2 <- na.omit(validation_test_data2)