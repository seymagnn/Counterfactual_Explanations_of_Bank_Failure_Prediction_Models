# Computing moc counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
predictor_dt <- Predictor$new(model_dt_weights2)
filtered_dt <- filtered_dt %>% filter(NIMY >= -0.794654)
moc_ce_dt <- list()

for (i in 1:nrow(filtered_dt)) {
  x_interest <- filtered_dt[i,]
  print(predictor_dt$predict(x_interest))
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
  
  moc_ce_dt[[i]] <- moc_cfactuals$evaluate()
  moc_cfactuals$predict()

}

moc_cfactuals_dt <- do.call(rbind, moc_ce_dt)
save(moc_cfactuals_dt, file = "counterfactuals_for_all_models/cost_sensitive/CEs/moc_cfactuals_dt.rda")

### Extratrees ###

predictor_ext <- Predictor$new(model_weights2_ext)
filtered_ext <- filtered_ext %>% filter(NIMY >= -0.794654)
moc_ce_ext <- list()

for (i in 1:nrow(filtered_ext)) {
  x_interest <- filtered_ext[i,]
  print(predictor_ext$predict(x_interest))
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
  
  moc_ce_ext[[i]] <- moc_cfactuals$evaluate()
  print(moc_cfactuals$predict())
}

moc_cfactuals_ext <- do.call(rbind, moc_ce_ext)
save(moc_cfactuals_ext, file = "counterfactuals_for_all_models/cost_sensitive/CEs/moc_cfactuals_ext.rda")


### Randomforest ###

predictor_rf <- Predictor$new(model_weights2_rf)
filtered_rf <- filtered_rf %>% filter(NIMY >= -0.794654)
moc_ce_rf <- list()

for (i in 1:nrow(filtered_rf)) {
  x_interest <- filtered_rf[i,]
  print(predictor_ext$predict(x_interest))
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
  
  moc_ce_rf[[i]] <- moc_cfactuals$evaluate()
  print(moc_cfactuals$predict())
}

moc_cfactuals_rf <- do.call(rbind, moc_ce_rf)
save(moc_cfactuals_rf, file = "counterfactuals_for_all_models/cost_sensitive/CEs/moc_cfactuals_rf.rda")
