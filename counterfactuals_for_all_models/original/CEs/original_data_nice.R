# Computing nice counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
org_predictor_dt <- Predictor$new(model_org_dt2)
org_nice_ce_dt <- list()

for (i in 1:nrow(filtered_org_dt)) {
  x_interest <- filtered_org_dt[i,]
  print(org_predictor_dt$predict(x_interest))
  nice_classif <- NICEClassif$new(
    org_predictor_dt,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))
  org_nice_ce_dt[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

org_nice_cfactuals_dt <- do.call(rbind, org_nice_ce_dt)
save(org_nice_cfactuals_dt, file = "counterfactuals_for_all_models/original/CEs/org_nice_cfactuals_dt.rda")

### Extratrees ###

org_predictor_ext <- Predictor$new(model_org_ext2)
org_nice_ce_ext <- list()

for (i in 1:nrow(filtered_org_ext)) {
  x_interest <- filtered_org_ext[i,]
  print(org_predictor_ext$predict(x_interest))
  nice_classif <- NICEClassif$new(
    org_predictor_ext,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  org_nice_ce_ext[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

org_nice_cfactuals_ext <- do.call(rbind, org_nice_ce_ext)
save(org_nice_cfactuals_ext, file = "counterfactuals_for_all_models/original/CEs/org_nice_cfactuals_ext.rda")

### Randomforest ###

org_predictor_rf <- Predictor$new(model_org_rf2)
org_nice_ce_rf <- list()

for (i in 1:nrow(filtered_org_rf)) {
  x_interest <- filtered_org_rf[i,]
  print(org_predictor_rf$predict(x_interest))
  nice_classif <- NICEClassif$new(
    org_predictor_rf,
    optimization = "sparsity", # sparsity (default), proximity or plausibility.
    x_nn_correct = FALSE,
    return_multiple = TRUE,
    finish_early = TRUE,
    distance_function = "gower")
  
  nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  org_nice_ce_rf[[i]] <- nice_cfactuals$evaluate()
  print(nice_cfactuals$predict())
  
}

org_nice_cfactuals_rf <- do.call(rbind, org_nice_ce_rf)
save(org_nice_cfactuals_rf, file = "counterfactuals_for_all_models/original/CEs/org_nice_cfactuals_rf.rda")

