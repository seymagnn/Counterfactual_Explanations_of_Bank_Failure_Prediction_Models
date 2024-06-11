# Computing what-if counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
predictor_dt <- Predictor$new(model_dt_weights2)


counterfactuals_dt <- list()

for (i in 1:nrow(filtered_dt)) {
  x_interest <- filtered_dt[i,]
  print(predictor_dt$predict(x_interest))
  wi_classif <- WhatIfClassif$new(predictor_dt, n_counterfactuals = 10L)
  cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "0", desired_prob = c(0.5, 1))
  counterfactuals_dt[[i]] <- cfactuals$evaluate()
  cfactuals$predict()
}

all_cfactuals_dt <- do.call(rbind, counterfactuals_dt)
save(all_cfactuals_dt, file = "counterfactuals_for_all_models/weighting/CEs/all_cfactuals_dt.rda")

### Extratrees ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
predictor_ext <- Predictor$new(model_weights2_ext)

counterfactuals_ext <- list()


for (i in 1:nrow(filtered_ext)) {
  x_interest <- filtered_ext[i,]
  prediction <- predictor_ext$predict(x_interest)
  print(prediction)
  wi_classif <- WhatIfClassif$new(predictor_ext, n_counterfactuals = 10L)
  cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  counterfactuals_ext[[i]] <- cfactuals$evaluate()
  print(cfactuals$predict())
}

all_cfactuals_ext <- do.call(rbind, counterfactuals_ext)
save(all_cfactuals_ext, file = "counterfactuals_for_all_models/weighting/CEs/all_cfactuals_ext.rda")


### Randomforest ###

predictor_rf <- Predictor$new(model_weights2_rf)

counterfactuals_rf <- list()

for (i in 1:nrow(filtered_rf)) {
  x_interest <- filtered_rf[i,]
  prediction <- predictor_rf$predict(x_interest)
  print(prediction)
  wi_classif <- WhatIfClassif$new(predictor_rf, n_counterfactuals = 10L)
  cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.5, 1))
  counterfactuals_rf[[i]] <- cfactuals$evaluate()
  print(cfactuals$predict())
}

all_cfactuals_rf <- do.call(rbind, counterfactuals_rf)
save(all_cfactuals_rf, file = "counterfactuals_for_all_models/weighting/CEs/all_cfactuals_rf.rda")
