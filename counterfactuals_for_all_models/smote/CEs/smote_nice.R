# Computing nice counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
smote_predictor_dt <- Predictor$new(model_dt_smote_2)
smote_nice_ce_dt <- list()

for (i in 1:nrow(smote_filtered_dt)) {
  x_interest <- smote_filtered_dt[i,]
  print(smote_predictor_dt$predict(x_interest))
  nice_classif <- NICEClassif$new(
    smote_predictor_dt,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))
  
  smote_nice_ce_dt[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

smote_nice_cfactuals_dt <- do.call(rbind, smote_nice_ce_dt)
save(smote_nice_cfactuals_dt, file = "counterfactuals_for_all_models/smote/CEs/smote_nice_cfactuals_dt.rda")

### Extratrees ###

smote_predictor_ext <- Predictor$new(model_smote2_ext)
smote_nice_ce_ext <- list()

for (i in 1:nrow(smote_filtered_ext)) {
  x_interest <- smote_filtered_ext[i,]
  print(smote_predictor_ext$predict(x_interest))
  nice_classif <- NICEClassif$new(
    smote_predictor_ext,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  
  smote_nice_ce_ext[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

smote_nice_cfactuals_ext <- do.call(rbind, smote_nice_ce_ext)
save(smote_nice_cfactuals_ext, file = "counterfactuals_for_all_models/smote/CEs/smote_nice_cfactuals_ext.rda")

### Randomforest ###

smote_predictor_rf <- Predictor$new(model_smote2_rf)
smote_nice_ce_rf <- list()

for (i in 1:nrow(smote_filtered_rf)) {
  x_interest <- smote_filtered_rf[i,]
  print(smote_predictor_rf$predict(x_interest))
  nice_classif <- NICEClassif$new(
    smote_predictor_rf,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  
  smote_nice_ce_rf[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

smote_nice_cfactuals_rf <- do.call(rbind, smote_nice_ce_rf)
save(smote_nice_cfactuals_rf, file = "counterfactuals_for_all_models/smote/CEs/smote_nice_cfactuals_rf.rda")

