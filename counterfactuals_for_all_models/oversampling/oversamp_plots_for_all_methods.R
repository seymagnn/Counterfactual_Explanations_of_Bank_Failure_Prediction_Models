# Visualizition of all ccounterfactuals

load("counterfactuals_for_all_models/oversampling/oversamp_whatif_results.rda")
load("counterfactuals_for_all_models/oversampling/oversamp_nice_results.rda")
load("counterfactuals_for_all_models/oversampling/oversamp_moc_results.rda")

oversamp_test_results <- bind_rows(oversamp_whatif_results, oversamp_moc_results, oversamp_nice_results)
oversamp_test_results$Sample_ID <- 1:nrow(oversamp_test_results)
oversamp_test_results <- oversamp_test_results[,-5]

oversamp_test_results <- oversamp_test_results %>%
  mutate(Validity = dist_target,
         Proximity = dist_x_interest,
         Sparsity = no_changed,
         Plausibility = dist_train) %>%
  pivot_longer(cols = c(Validity, Proximity, Sparsity, Plausibility, minimality), 
               names_to = "Quality_Metric", 
               values_to ="Values")

oversamp_test_results <- oversamp_test_results %>% 
  select(Sample_ID, CE_Method, Used_Model, Quality_Metric, Values, everything())

oversamp_test_results <- oversamp_test_results[,-c(11,12,13,14)]
write.csv(oversamp_test_results, "counterfactuals_for_all_models/oversampling/oversamp_combined_results.csv", row.names = FALSE)

oversamp_summary_metrics <- oversamp_test_results %>%
  filter(CE_Method %in% c("WhatIf", "MOC", "NICE"), 
         Used_Model %in% c("Decision tree", "Extra trees", "Random forest"), 
         Quality_Metric %in% c("Proximity", "Sparsity", "Plausibility", "Minimality", "Validity")) %>%
  group_by(CE_Method, Used_Model, Quality_Metric) %>%
  summarise(
    Mean_Values = mean(Values),
    StdDev_Values = sd(Values)
  )


write.csv(oversamp_summary_metrics, "counterfactuals_for_all_models/oversampling/oversamp_summary_metrics.csv", row.names = FALSE)



ggplot(oversamp_summary_metrics, aes(x = CE_Method, y = Mean_Values, color = Used_Model, group = Used_Model)) +
  geom_line() +
  geom_point() +
  facet_wrap(~ Quality_Metric, scales = "free_y") +
  labs(x = "CE Method", y = "Mean Values", color = "Used Model", title = "Oversampling") +
  theme_minimal()


ggplot(oversamp_summary_metrics, aes(x = CE_Method, y = Mean_Values, color = Used_Model, group = Used_Model)) +
  geom_line(position = position_dodge(width = 0.5)) +
  geom_point(position = position_dodge(width = 0.5)) +
  geom_errorbar(aes(ymin = Mean_Values - StdDev_Values, ymax = Mean_Values + StdDev_Values), width = 0.2,
                position = position_dodge(width = 0.5)) +
  facet_wrap(~ Quality_Metric, scales = "free_y") +
  labs(x = "CE Method", y = "Mean Values", color = "Used Model", title = "Quality Metrics for CE Methods Using Oversampling Model") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank())





