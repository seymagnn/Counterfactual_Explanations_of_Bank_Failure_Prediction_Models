# Computing moc counterfactuals for all models

### Decision Tree ###

# Creating a 'predictor' object, which serves as a wrapper for different model types.
org_predictor_dt <- Predictor$new(model_org_dt2)
filtered_org_dt <- filtered_org_dt %>% filter(NIMY >= -0.794654)
org_moc_ce_dt <- list()

for (i in 1:nrow(filtered_org_dt)) {
  x_interest <- filtered_org_dt[i,]
  print(org_predictor_dt$predict(x_interest))
  moc_classif <- MOCClassif$new(
    org_predictor_dt,
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
  org_moc_ce_dt[[i]] <- moc_cfactuals$evaluate()
  moc_cfactuals$predict()
  
}

org_moc_cfactuals_dt <- do.call(rbind, org_moc_ce_dt)
save(org_moc_cfactuals_dt, file = "counterfactuals_for_all_models/original/CEs/org_moc_cfactuals_dt.rda")

### Extratrees ###

org_predictor_ext <- Predictor$new(model_org_ext2)
filtered_org_ext <- filtered_org_ext %>% filter(NIMY >= -0.794654)
org_moc_ce_ext <- list()

for (i in 1:nrow(filtered_org_ext)) {
  x_interest <- filtered_org_ext[i,]
  print(org_predictor_ext$predict(x_interest))
  moc_classif <- MOCClassif$new(
    org_predictor_ext,
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
  org_moc_ce_ext[[i]] <- moc_cfactuals$evaluate()
  print(moc_cfactuals$predict())
}

org_moc_cfactuals_ext <- do.call(rbind, org_moc_ce_ext)
save(org_moc_cfactuals_ext, file = "counterfactuals_for_all_models/original/CEs/org_moc_cfactuals_ext.rda")


### Randomforest ###

org_predictor_rf <- Predictor$new(model_org_rf2)
filtered_org_rf <- filtered_org_rf %>% filter(NIMY >= -0.794654)
org_moc_ce_rf <- list()

for (i in 1:nrow(filtered_org_rf)) {
  x_interest <- filtered_org_rf[i,]
  print(org_predictor_rf$predict(x_interest))
  moc_classif <- MOCClassif$new(
    org_predictor_rf,
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
  
  org_moc_ce_rf[[i]] <- moc_cfactuals$evaluate()
  print(moc_cfactuals$predict())
}

org_moc_cfactuals_rf <- do.call(rbind, org_moc_ce_rf)
save(org_moc_cfactuals_rf, file = "counterfactuals_for_all_models/original/CEs/org_moc_cfactuals_rf.rda")
