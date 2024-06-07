# combining all the datasets
combined_datasets <- bind_rows(
  org_summary_metrics %>% mutate(Model = "Original"),
  oversamp_summary_metrics %>% mutate(Model = "Oversampling"),
  smote_summary_metrics %>% mutate(Model = "SMOTE"),
  undersamp_summary_metrics %>% mutate(Model = "Undersampling"),
  summary_metrics %>% mutate(Model = "Weighting")
)

# making graph
ggplot(combined_datasets, aes(x = CE_Method, y = Mean_Values, color = Used_Model, group = Used_Model)) +
  geom_line(position = position_dodge(width = 0.5)) +
  geom_point(position = position_dodge(width = 0.5)) +
  geom_errorbar(aes(ymin = Mean_Values - StdDev_Values, ymax = Mean_Values + StdDev_Values), width = 0.2,
                position = position_dodge(width = 0.5)) +
  facet_grid(Quality_Metric ~ Model, scales = "free_y") +
  labs(x = "CE Method", y = "Mean Values", color = "Used Model", title = "Quality Metrics for CE Methods") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank()) +
  theme(plot.title = element_text(hjust = 0))


