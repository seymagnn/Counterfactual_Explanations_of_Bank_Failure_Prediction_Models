# NICE (Nearest Instance Counterfactual Explanation) Documentation

# This script demonstrates the usage of Nearest Instance Counterfactual Explanation (NICE) 
# to find counterfactual instances for failed banks using ExtraTrees, Decision Tree, and RandomForest models.

### Extratrees ###

# Train the ExtraTrees model with case weights
set.seed(123)
model_weights2_ext <- ranger(
  Label ~ .,
  splitrule = "extratrees",
  data = train_data2,
  probability = TRUE,
  case.weights = ifelse(train_data2$Label == 1, 5, 1)
)

# Choose a sample from failed banks for counterfactual analysis
label_1_samples <- validation_test_data2[validation_test_data2$Label == 1, ]
# Creating a 'predictor' object, which serves as a wrapper for different model types.
predictor_ext <- Predictor$new(model_weights2_ext)

x_interest <- label_1_samples[5L,]
predictor_ext$predict(x_interest)

# Use NICEClassif to find counterfactuals for ExtraTrees
nice_classif <- NICEClassif$new(
  predictor_ext,
  optimization = "sparsity", # sparsity (default), proximity or plausibility.
  x_nn_correct = FALSE,
  return_multiple = TRUE,
  finish_early = TRUE,
  distance_function = "gower")

nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))


nice_cfactuals$data
nice_cfactuals$evaluate()
nice_cfactuals$predict()

nice_cfactuals$plot_freq_of_feature_changes()
nice_cfactuals$get_freq_of_feature_changes()


nice_cfactuals$plot_parallel(feature_names = c("INTEXPYQ", "NIMY", "RBC1AAJ", "ROE", "TICRC"))
nice_cfactuals$plot_surface(feature_names = c("INTEXPYQ", "NIMY"))



### Decision Tree ###

set.seed(123)
model_dt_weights2 <- train(
  Label ~ .,
  data = train_data2,
  method = "rpart",
  weights = ifelse(train_data2$Label == 1, 5, 1)
)


label_1_samples <- validation_test_data2[validation_test_data2$Label == 1, ]
predictor_dt <- Predictor$new(model_dt_weights2, type = "prob")

x_interest <- label_1_samples[5L,]
predictor_dt$predict(x_interest)

nice_classif <- NICEClassif$new(
  predictor_dt,
  optimization = "sparsity", # sparsity (default), proximity or plausibility.
  x_nn_correct = FALSE,
  return_multiple = TRUE,
  finish_early = TRUE,
  distance_function = "gower")

nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))


nice_cfactuals$data
nice_cfactuals$evaluate()
nice_cfactuals$predict()

nice_cfactuals$plot_freq_of_feature_changes()
nice_cfactuals$get_freq_of_feature_changes()


nice_cfactuals$plot_parallel(feature_names = c("INTEXPYQ", "NIMY", "RBC1AAJ", "ROE", "TICRC"))
nice_cfactuals$plot_surface(feature_names = c("INTEXPYQ", "NIMY"))



### Randomforest ###

set.seed(123)
model_weights2_rf <- ranger(Label ~ .,
                            data = train_data2,
                            case.weights = ifelse(train_data2$Label == 1, 5, 1),
                            probability = TRUE)



label_1_samples <- validation_test_data2[validation_test_data2$Label == 1, ]
predictor_ext <- Predictor$new(model_weights2_rf)

x_interest <- label_1_samples[5L,]
predictor_rf$predict(x_interest)

nice_classif <- NICEClassif$new(
  predictor_rf,
  optimization = "proximity", # sparsity (default), proximity or plausibility.
  x_nn_correct = FALSE,
  return_multiple = TRUE,
  finish_early = TRUE,
  distance_function = "gower")

nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))


nice_cfactuals$data
nice_cfactuals$evaluate()
nice_cfactuals$predict()

nice_cfactuals$plot_freq_of_feature_changes()
nice_cfactuals$get_freq_of_feature_changes()


nice_cfactuals$plot_parallel(feature_names = c("INTEXPYQ", "NIMY", "RBC1AAJ", "ROE", "TICRC"))
nice_cfactuals$plot_surface(feature_names = c("INTEXPYQ", "NIMY"))
