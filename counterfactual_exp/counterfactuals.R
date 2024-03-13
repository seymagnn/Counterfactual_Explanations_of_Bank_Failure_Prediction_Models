# # install.packages("devtools")
# devtools::install_github("dandls/counterfactuals")
# library(counterfactuals)
# library(randomForest)
# library(iml)
# library(GGally)
# 
# # Using weights parameter
# 
# set.seed(123)
# model_weights2_ext <- ranger(
#   Label ~ .,
#   splitrule = "extratrees",
#   data = train_data2,
#   probability = TRUE,
#   case.weights = ifelse(train_data2$Label == 1, 5, 1)
# )
# 
# # predictor_ext <- Predictor$new(model_weights2_ext)
# 
# x_interest <- validation_test_data2[2L,]
# predictor_ext$predict(x_interest)
# # predicted_x_int <- predictor_ext$predict(x_interest)
# # colnames(predicted_x_int) <- c("0", "1")
# 
# wi_classif <- WhatIfClassif$new(predictor_ext, n_counterfactuals = 5L)
# 
# cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.01, 0.5))
# 
# 
# # failed_banks <- train_data2[train_data2$Label == 1, ]
# # 
# # set.seed(123)
# # model_weights2_ext <- ranger(
# #   Label ~ .,
# #   splitrule = "extratrees",
# #   data = failed_banks,
# #   probability = TRUE,
# #   case.weights = ifelse(failed_banks$Label == 1, 5, 1)
# # )
# 
# 
# 
# ## for failed banks
# 
# label_1_samples <- validation_test_data2[validation_test_data2$Label == 1, ]
# 
# x_interest <- label_1_samples[4L,]
# predictor_ext$predict(x_interest)
# 
# wi_classif <- WhatIfClassif$new(predictor_ext, n_counterfactuals = 10L)
# 
# cfactuals <- wi_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.01, 0.5))
# 
# 
# cfactuals$data
# 
# cfactuals$evaluate()
# 
# cfactuals$evaluate(show_diff = TRUE)
# 
# cfactuals$evaluate_set()
# 
# cfactuals$predict()
# 
# 
# cfactuals$plot_freq_of_feature_changes()
# cfactuals$get_freq_of_feature_changes()
# 
# 
# cfactuals$plot_parallel(feature_names = c("INTEXPYQ", "NIMY"))
# 
# # Creates a surface plot for two features.
# cfactuals$plot_surface(feature_names = c("INTEXPYQ", "NIMY"))
# 
# 
# 
# ### MOC ###
# 
# moc_classif <- MOCClassif$new(
#   predictor_ext,
#   epsilon = NULL,
#   fixed_features = NULL,
#   max_changed = NULL,
#   mu = 25L,
#   termination_crit = "gens",
#   n_generations = 5L,
#   p_rec = 0.71,
#   p_rec_gen = 0.62,
#   p_mut = 0.73,
#   p_mut_gen = 0.5,
#   p_mut_use_orig = 0.4,
#   k = 1L,
#   weights = NULL,
#   lower = NULL,
#   upper = NULL,
#   init_strategy = "icecurve",
#   use_conditional_mutator = FALSE,
#   quiet = FALSE,
#   distance_function = "gower"
# )
# 
# moc_cfactuals <- moc_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.01, 0.5))
# 
# # Plots the evolution of the mean and minimum objective values together with the dominated hypervolume over the generations. 
# # All values for a generation are computed based on all non-dominated individuals that emerged until that generation.
# moc_classif$plot_statistics()
# 
# # Calculates the dominated hypervolume of each generation.
# moc_classif$get_dominated_hv()
# 
# # Visualizes two selected objective values of all emerged individuals in a scatter plot.
# moc_classif$plot_search()
# 
# moc_classif$optimizer
# moc_cfactuals$print()
# moc_cfactuals$get_freq_of_feature_changes()
# 
# ### NICE ###
# 
# nice_classif <- NICEClassif$new(
#   predictor_ext,
#   optimization = "proximity", # sparsity (default), proximity or plausibility.
#   x_nn_correct = FALSE,
#   return_multiple = FALSE,
#   finish_early = TRUE,
#   distance_function = "gower")
# 
# nice_cfactuals <- nice_classif$find_counterfactuals(x_interest, desired_class = "X0", desired_prob = c(0.01, 0.5))
# 
# 
# nice_cfactuals$data
# nice_cfactuals$evaluate()
# nice_cfactuals$predict()
# 
# nice_cfactuals$plot_freq_of_feature_changes()
# nice_cfactuals$get_freq_of_feature_changes()
# 
# 
# nice_cfactuals$plot_parallel(feature_names = c("INTEXPYQ", "NIMY"))
# nice_cfactuals$plot_surface(feature_names = c("INTEXPYQ", "NIMY"))
