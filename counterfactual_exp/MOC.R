# MOC (Multi-Objective for Counterfactuals) 

# This script demonstrates the usage of Multi-Objective for Counterfactuals (MOC) 
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

# Use MOCClassif to find counterfactuals for ExtraTrees
moc_classif <- MOCClassif$new(
  predictor_ext,
  epsilon = NULL,
  fixed_features = NULL,
  max_changed = NULL,
  mu = 20L,
  termination_crit = "gens",
  n_generations = 10L,
  p_rec = 0.71,
  p_rec_gen = 0.62,
  p_mut = 0.73,
  p_mut_gen = 0.5,
  p_mut_use_orig = 0.4,
  k = 1L,
  weights = NULL,
  lower = NULL,
  upper = NULL,
  init_strategy = "icecurve",
  use_conditional_mutator = FALSE,
  quiet = FALSE,
  distance_function = "gower"
)

moc_cfactuals <- moc_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
moc_cfactuals$predict()

# Display evaluation
moc_classif$optimizer
moc_cfactuals$print()
moc_cfactuals$evaluate()

# Plots the evolution of the mean and minimum objective values together with the dominated hypervolume over the generations. 
# All values for a generation are computed based on all non-dominated individuals that emerged until that generation.
moc_classif$plot_statistics()

# Calculates the dominated hypervolume of each generation.
moc_classif$get_dominated_hv()

# Visualizes two selected objective values of all emerged individuals in a scatter plot.
moc_classif$plot_search()


moc_cfactuals$get_freq_of_feature_changes()
moc_cfactuals$plot_parallel(feature_names = c("INTEXPYQ", "NIMY", "RBC1AAJ", "ROE", "TICRC"))
 




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


moc_classif <- MOCClassif$new(
  predictor_dt,
  epsilon = NULL,
  fixed_features = NULL,
  max_changed = NULL,
  mu = 20L,
  termination_crit = "gens",
  n_generations = 10L,
  p_rec = 0.71,
  p_rec_gen = 0.62,
  p_mut = 0.73,
  p_mut_gen = 0.5,
  p_mut_use_orig = 0.4,
  k = 1L,
  weights = NULL,
  lower = NULL,
  upper = NULL,
  init_strategy = "icecurve",
  use_conditional_mutator = FALSE,
  quiet = FALSE,
  distance_function = "gower"
)

moc_cfactuals <- moc_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))

# Plots the evolution of the mean and minimum objective values together with the dominated hypervolume over the generations. 
# All values for a generation are computed based on all non-dominated individuals that emerged until that generation.
moc_classif$plot_statistics()

# Calculates the dominated hypervolume of each generation.
moc_classif$get_dominated_hv()

# Visualizes two selected objective values of all emerged individuals in a scatter plot.
moc_classif$plot_search()

moc_classif$optimizer
moc_cfactuals$print()
moc_cfactuals$get_freq_of_feature_changes()
moc_cfactuals$evaluate()
moc_cfactuals$plot_parallel()



### Randomforest ###

set.seed(123)
model_weights2_rf <- ranger(Label ~ .,
                            data = train_data2,
                            case.weights = ifelse(train_data2$Label == 1, 5, 1),
                            probability = TRUE)



label_1_samples <- validation_test_data2[validation_test_data2$Label == 1, ]
predictor_rf <- Predictor$new(model_weights2_rf)

x_interest <- label_1_samples[5L,]
predictor_ext$predict(x_interest)

moc_classif <- MOCClassif$new(
  predictor_rf,
  epsilon = NULL,
  fixed_features = NULL,
  max_changed = NULL,
  mu = 20L,
  termination_crit = "gens",
  n_generations = 10L,
  p_rec = 0.71,
  p_rec_gen = 0.62,
  p_mut = 0.73,
  p_mut_gen = 0.5,
  p_mut_use_orig = 0.4,
  k = 1L,
  weights = NULL,
  lower = NULL,
  upper = NULL,
  init_strategy = "icecurve",
  use_conditional_mutator = FALSE,
  quiet = FALSE,
  distance_function = "gower"
)

moc_cfactuals <- moc_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))

# Plots the evolution of the mean and minimum objective values together with the dominated hypervolume over the generations. 
# All values for a generation are computed based on all non-dominated individuals that emerged until that generation.
moc_classif$plot_statistics()

# Calculates the dominated hypervolume of each generation.
moc_classif$get_dominated_hv()

# Visualizes two selected objective values of all emerged individuals in a scatter plot.
moc_classif$plot_search()

moc_classif$optimizer
moc_cfactuals$print()
moc_cfactuals$get_freq_of_feature_changes()
moc_cfactuals$evaluate()
moc_cfactuals$plot_parallel(feature_names = c("INTEXPYQ", "NIMY", "RBC1AAJ", "ROE", "TICRC"))
