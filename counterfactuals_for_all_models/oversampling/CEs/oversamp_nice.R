# Computing nice counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
over_predictor_dt <- Predictor$new(model_dt_over2)
over_nice_ce_dt <- list()

for (i in 1:nrow(over_filtered_dt)) {
  x_interest <- over_filtered_dt[i,]
  print(over_predictor_dt$predict(x_interest))
  nice_classif <- NICEClassif$new(
    over_predictor_dt,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))
  
  over_nice_ce_dt[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

over_nice_cfactuals_dt <- do.call(rbind, over_nice_ce_dt)
save(over_nice_cfactuals_dt, file = "counterfactuals_for_all_models/oversampling/CEs/over_nice_cfactuals_dt.rda")


### Extratrees ###

over_predictor_ext <- Predictor$new(model_over2_ext)
over_nice_ce_ext <- list()

for (i in 1:nrow(over_filtered_ext)) {
  x_interest <- over_filtered_ext[i,]
  print(over_predictor_ext$predict(x_interest))
  nice_classif <- NICEClassif$new(
    over_predictor_ext,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  
  over_nice_ce_ext[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

over_nice_cfactuals_ext <- do.call(rbind, over_nice_ce_ext)
save(over_nice_cfactuals_ext, file = "counterfactuals_for_all_models/oversampling/CEs/over_nice_cfactuals_ext.rda")


### Randomforest ###

over_predictor_rf <- Predictor$new(model_over2_rf)
over_nice_ce_rf <- list()

for (i in 1:nrow(over_filtered_rf)) {
  x_interest <- over_filtered_rf[i,]
  print(over_predictor_rf$predict(x_interest))
  nice_classif <- NICEClassif$new(
    over_predictor_rf,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  
  over_nice_ce_rf[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

over_nice_cfactuals_rf <- do.call(rbind, over_nice_ce_rf)
save(over_nice_cfactuals_rf, file = "counterfactuals_for_all_models/oversampling/CEs/over_nice_cfactuals_rf.rda")


