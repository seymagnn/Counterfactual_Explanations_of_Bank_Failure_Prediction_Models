# Title: Counterfactual Analysis/ WhatIf Method 

# This script demonstrates the usage of the 'counterfactuals' package for conducting counterfactual analysis 
# on three different models: ExtraTrees, Decision Tree, and RandomForest. The analysis focuses on failed banks 
# using weighted models and evaluates the generated counterfactuals.


### Extratrees ###

# Define and train the ExtraTrees model with case weights
set.seed(123)
model_weights2_ext <- ranger(
  Label ~ .,
  splitrule = "extratrees",
  data = train_data2,
  probability = TRUE,
  case.weights = ifelse(train_data2$Label == 1, 5, 1)
)

# Choose a sample from failed banks 
label_1_samples <- validation_test_data2[validation_test_data2$Label == 1, ]

# Creating a 'predictor' object, which serves as a wrapper for different model types.
predictor_ext <- Predictor$new(model_weights2_ext)

x_interest <- label_1_samples[5L,]
predictor_ext$predict(x_interest)

# Use WhatIfClassif to find counterfactuals for ExtraTrees
wi_classif <- WhatIfClassif$new(predictor_ext, n_counterfactuals = 10L) # default 1L
cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))

# Display counterfactuals data and evaluation
cfactuals$data
whatif_ext <- cfactuals$evaluate()

# Evaluaation metrics
cfactuals$evaluate_set()

cfactuals$predict()

# Plot frequency of feature changes
cfactuals$plot_freq_of_feature_changes()

# Graph that connecting feature values of each counterfactual and 'blue' is for x_interest.
cfactuals$plot_parallel(feature_names = c("INTEXPYQ", "NIMY", "RBC1AAJ", "ROE", "TICRC"))

# Creates a surface plot for two features.
cfactuals$plot_surface(feature_names = c("INTEXPYQ", "NIMY"))


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

wi_classif <- WhatIfClassif$new(predictor_dt, n_counterfactuals = 10L)

cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))

cfactuals$data

whatif_dt <- cfactuals$evaluate()

cfactuals$evaluate_set()

cfactuals$predict()


cfactuals$plot_freq_of_feature_changes()
cfactuals$get_freq_of_feature_changes()


cfactuals$plot_parallel()

# Creates a surface plot for two features.
cfactuals$plot_surface(feature_names = c("INTEXPYQ", "NIMY"))

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

wi_classif <- WhatIfClassif$new(predictor_rf, n_counterfactuals = 10L)

cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))


cfactuals$data

whatif_rf <- cfactuals$evaluate()

cfactuals$evaluate(show_diff = TRUE)

cfactuals$evaluate_set()

cfactuals$predict()


cfactuals$plot_freq_of_feature_changes()
cfactuals$get_freq_of_feature_changes()


cfactuals$plot_parallel(feature_names = c("INTEXPYQ", "NIMY", "RBC1AAJ", "ROE", "TICRC"))

# Creates a surface plot for two features.
cfactuals$plot_surface(feature_names = c("INTEXPYQ", "NIMY"))
