# Computing what-if counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
org_predictor_dt <- Predictor$new(model_org_dt2)
org_counterfactuals_dt <- list()

for (i in 1:nrow(filtered_org_dt)) {
  x_interest <- filtered_org_dt[i,]
  print(org_predictor_dt$predict(x_interest))
  wi_classif <- WhatIfClassif$new(org_predictor_dt, n_counterfactuals = 10L)
  cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))
  org_counterfactuals_dt[[i]] <- cfactuals$evaluate()
  cfactuals$predict()
}

org_all_cfactuals_dt <- do.call(rbind, org_counterfactuals_dt)
save(org_all_cfactuals_dt, file = "counterfactuals_for_all_models/original/CEs/org_all_cfactuals_dt.rda")

### Extratrees ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
org_predictor_ext <- Predictor$new(model_org_ext2)
org_counterfactuals_ext <- list()

for (i in 1:nrow(filtered_org_ext)) {
  x_interest <- filtered_org_ext[i,]
  prediction <- org_predictor_ext$predict(x_interest)
  print(prediction)
  wi_classif <- WhatIfClassif$new(org_predictor_ext, n_counterfactuals = 10L)
  cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  org_counterfactuals_ext[[i]] <- cfactuals$evaluate()
  print(cfactuals$predict())
}

org_all_cfactuals_ext <- do.call(rbind, org_counterfactuals_ext)
save(org_all_cfactuals_ext, file = "counterfactuals_for_all_models/original/CEs/org_all_cfactuals_ext.rda")

### Randomforest ###

org_predictor_rf <- Predictor$new(model_org_rf2)
org_counterfactuals_rf <- list()

for (i in 1:nrow(filtered_org_rf)) {
  x_interest <- filtered_org_rf[i,]
  prediction <- org_predictor_rf$predict(x_interest)
  print(prediction)
  wi_classif <- WhatIfClassif$new(org_predictor_rf, n_counterfactuals = 10L)
  cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  org_counterfactuals_rf[[i]] <- cfactuals$evaluate()
  print(cfactuals$predict())
}

org_all_cfactuals_rf <- do.call(rbind, org_counterfactuals_rf)
save(org_all_cfactuals_rf, file = "counterfactuals_for_all_models/original/CEs/org_all_cfactuals_rf.rda")
