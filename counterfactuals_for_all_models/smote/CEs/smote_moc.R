# Computing moc counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
smote_predictor_dt <- Predictor$new(model_dt_smote_2)
smote_filtered_dt <- smote_filtered_dt %>% filter(NIMY <= 25.3421 & NIMY >= -0.794654)
smote_moc_ce_dt <- list()

for (i in 1:nrow(smote_filtered_dt)) {
  x_interest <- smote_filtered_dt[i,]
  print(smote_predictor_dt$predict(x_interest))
  moc_classif <- MOCClassif$new(
    smote_predictor_dt,
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
  
  smote_moc_ce_dt[[i]] <- moc_cfactuals$evaluate()
  moc_cfactuals$predict()
  
}

smote_moc_cfactuals_dt <- do.call(rbind, smote_moc_ce_dt)
save(smote_moc_cfactuals_dt, file = "counterfactuals_for_all_models/smote/CEs/smote_moc_cfactuals_dt.rda")

### Extratrees ###

smote_predictor_ext <- Predictor$new(model_smote2_ext)
smote_filtered_ext <- smote_filtered_ext %>% filter(NIMY <= 25.3421 & NIMY >= -0.794654)
smote_moc_ce_ext <- list()

for (i in 1:nrow(smote_filtered_ext)) {
  x_interest <- smote_filtered_ext[i,]
  print(smote_predictor_ext$predict(x_interest))
  moc_classif <- MOCClassif$new(
    smote_predictor_ext,
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
  
  smote_moc_ce_ext[[i]] <- moc_cfactuals$evaluate()
  print(moc_cfactuals$predict())
}

smote_moc_cfactuals_ext <- do.call(rbind, smote_moc_ce_ext)
save(smote_moc_cfactuals_ext, file = "counterfactuals_for_all_models/smote/CEs/smote_moc_cfactuals_ext.rda")


### Randomforest ###

smote_predictor_rf <- Predictor$new(model_smote2_rf)
smote_filtered_rf <- smote_filtered_rf %>% filter(NIMY <= 25.3421 & NIMY >= -0.794654)
smote_moc_ce_rf <- list()

for (i in 1:nrow(smote_filtered_rf)) {
  x_interest <- smote_filtered_rf[i,]
  print(smote_predictor_rf$predict(x_interest))
  moc_classif <- MOCClassif$new(
    smote_predictor_rf,
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
  
  smote_moc_ce_rf[[i]] <- moc_cfactuals$evaluate()
  print(moc_cfactuals$predict())
}

smote_moc_cfactuals_rf <- do.call(rbind, smote_moc_ce_rf)
save(smote_moc_cfactuals_rf, file = "counterfactuals_for_all_models/smote/CEs/smote_moc_cfactuals_rf.rda")
