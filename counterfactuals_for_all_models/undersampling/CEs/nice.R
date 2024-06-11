# Computing nice counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
under_predictor_dt <- Predictor$new(model_dt_under2)
under_nice_ce_dt <- list()

for (i in 1:nrow(under_filtered_dt)) {
  x_interest <- under_filtered_dt[i,]
  print(under_predictor_dt$predict(x_interest))
  nice_classif <- NICEClassif$new(
    under_predictor_dt,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))
  
  under_nice_ce_dt[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

under_nice_cfactuals_dt <- do.call(rbind, under_nice_ce_dt)
save(under_nice_cfactuals_dt, file = "counterfactuals_for_all_models/undersampling/CEs/under_nice_cfactuals_dt.rda")


### Extratrees ###

under_predictor_ext <- Predictor$new(model_under2_ext)
under_nice_ce_ext <- list()

for (i in 1:nrow(under_filtered_ext)) {
  x_interest <- under_filtered_ext[i,]
  print(under_predictor_ext$predict(x_interest))
  nice_classif <- NICEClassif$new(
    under_predictor_ext,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  
  under_nice_ce_ext[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

under_nice_cfactuals_ext <- do.call(rbind, under_nice_ce_ext)
save(under_nice_cfactuals_ext, file = "counterfactuals_for_all_models/undersampling/CEs/under_nice_cfactuals_ext.rda")


### Randomforest ###

under_predictor_rf <- Predictor$new(model_under2_rf)
under_nice_ce_rf <- list()

for (i in 1:nrow(under_filtered_rf)) {
  x_interest <- under_filtered_rf[i,]
  print(under_predictor_rf$predict(x_interest))
  nice_classif <- NICEClassif$new(
    under_predictor_rf,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  
  under_nice_ce_rf[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

under_nice_cfactuals_rf <- do.call(rbind, under_nice_ce_rf)
save(under_nice_cfactuals_rf, file = "counterfactuals_for_all_models/undersampling/CEs/under_nice_cfactuals_rf.rda")

