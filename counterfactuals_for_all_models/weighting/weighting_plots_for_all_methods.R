# Visualizition of all ccounterfactuals

load("counterfactuals_for_all_models/weighting/weighting_whatif_results.rda")
load("counterfactuals_for_all_models/weighting/weighting_nice_results.rda")
load("counterfactuals_for_all_models/weighting/weighting_moc_results.rda")

test_results <- bind_rows(whatif_results, moc_results, nice_results)
test_results$Sample_ID <- 1:nrow(test_results)
test_results <- test_results[,-5]

test_results <- test_results %>%
  mutate(Validity = dist_target,
         Proximity = dist_x_interest,
         Sparsity = no_changed,
         Plausibility = dist_train) %>%
  pivot_longer(cols = c(Validity, Proximity, Sparsity, Plausibility, minimality), 
               names_to = "Quality_Metric", 
               values_to ="Values")

test_results <- test_results %>% 
  select(Sample_ID, CE_Method, Used_Model, Quality_Metric, Values, everything())

test_results <- test_results[,-c(11,12,13,14)]
write.csv(test_results, "weighting_combined_results.csv", row.names = FALSE)

summary_metrics <- test_results %>%
  filter(CE_Method %in% c("WhatIf", "MOC", "NICE"), 
         Used_Model %in% c("Decision tree", "Extratrees", "Randomforest"), 
         Quality_Metric %in% c("Proximity", "Sparsity", "Plausibility", "Minimality", "Validity")) %>%
  group_by(CE_Method, Used_Model, Quality_Metric) %>%
  summarise(
    Mean_Values = mean(Values),
    StdDev_Values = sd(Values)
  )


write.csv(summary_metrics, "weighting_summary_metrics.csv", row.names = FALSE)



ggplot(summary_metrics, aes(x = CE_Method, y = Mean_Values, color = Used_Model, group = Used_Model)) +
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = Mean_Values - StdDev_Values, ymax = Mean_Values + StdDev_Values), width = 0.2) +
  facet_wrap(~ Quality_Metric, scales = "free_y") +
  labs(x = "CE Method", y = "Mean Values", color = "Used Model", title = "Quality Metrics for CE Methods Using Weighting Model") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank())






