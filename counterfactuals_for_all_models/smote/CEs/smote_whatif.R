# Computing what-if counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
smote_predictor_dt <- Predictor$new(model_dt_smote_2)
smote_counterfactuals_dt <- list()

for (i in 1:nrow(smote_filtered_dt)) {
  x_interest <- smote_filtered_dt[i,]
  print(smote_predictor_dt$predict(x_interest))
  wi_classif <- WhatIfClassif$new(smote_predictor_dt, n_counterfactuals = 10L)
  cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))
  smote_counterfactuals_dt[[i]] <- cfactuals$evaluate()
  cfactuals$predict()
}

smote_all_cfactuals_dt <- do.call(rbind, smote_counterfactuals_dt)
save(smote_all_cfactuals_dt, file = "counterfactuals_for_all_models/smote/CEs/smote_all_cfactuals_dt.rda")

### Extratrees ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
smote_predictor_ext <- Predictor$new(model_smote2_ext)
smote_counterfactuals_ext <- list()

for (i in 1:nrow(smote_filtered_ext)) {
  x_interest <- smote_filtered_ext[i,]
  prediction <- smote_predictor_ext$predict(x_interest)
  print(prediction)
  wi_classif <- WhatIfClassif$new(smote_predictor_ext, n_counterfactuals = 10L)
  cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  smote_counterfactuals_ext[[i]] <- cfactuals$evaluate()
  print(cfactuals$predict())
}

smote_all_cfactuals_ext <- do.call(rbind, smote_counterfactuals_ext)
save(smote_all_cfactuals_ext, file = "counterfactuals_for_all_models/smote/CEs/smote_all_cfactuals_ext.rda")

### Randomforest ###

smote_predictor_rf <- Predictor$new(model_smote2_rf)

smote_counterfactuals_rf <- list()

for (i in 1:nrow(smote_filtered_rf)) {
  x_interest <- smote_filtered_rf[i,]
  prediction <- smote_predictor_rf$predict(x_interest)
  print(prediction)
  wi_classif <- WhatIfClassif$new(smote_predictor_rf, n_counterfactuals = 10L)
  cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  smote_counterfactuals_rf[[i]] <- cfactuals$evaluate()
  print(cfactuals$predict())
}

smote_all_cfactuals_rf <- do.call(rbind, smote_counterfactuals_rf)
save(smote_all_cfactuals_rf, file = "counterfactuals_for_all_models/smote/CEs/smote_all_cfactuals_rf.rda")
