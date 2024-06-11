# Computing nice counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
predictor_dt <- Predictor$new(model_dt_weights2)
nice_ce_dt <- list()

for (i in 1:nrow(filtered_dt)) {
  x_interest <- filtered_dt[i,]
  print(predictor_dt$predict(x_interest))
  nice_classif <- NICEClassif$new(
    predictor_dt,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))
  
  nice_ce_dt[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

nice_cfactuals_dt <- do.call(rbind, nice_ce_dt)
save(nice_cfactuals_dt, file = "counterfactuals_for_all_models/weighting/CEs/nice_cfactuals_dt.rda")

### Extratrees ###

predictor_ext <- Predictor$new(model_weights2_ext)
nice_ce_ext <- list()

for (i in 1:nrow(filtered_ext)) {
  x_interest <- filtered_ext[i,]
  print(predictor_ext$predict(x_interest))
  nice_classif <- NICEClassif$new(
    predictor_ext,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  
  nice_ce_ext[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

nice_cfactuals_ext <- do.call(rbind, nice_ce_ext)
save(nice_cfactuals_ext, file = "counterfactuals_for_all_models/weighting/CEs/nice_cfactuals_ext.rda")

### Randomforest ###

predictor_rf <- Predictor$new(model_weights2_rf)
nice_ce_rf <- list()

for (i in 1:nrow(filtered_rf)) {
  x_interest <- filtered_rf[i,]
  print(predictor_rf$predict(x_interest))
  nice_classif <- NICEClassif$new(
    predictor_rf,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  
  nice_ce_rf[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

nice_cfactuals_rf <- do.call(rbind, nice_ce_rf)
save(nice_cfactuals_rf, file = "counterfactuals_for_all_models/weighting/CEs/nice_cfactuals_rf.rda")

