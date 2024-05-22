libraries <- c("DBI","RPostgres","fdicdata", "data.table", "dplyr", "readr", "zoo", "lubridate", "tidyr",
               "reshape2", "esquisse", "ggplot2", "caTools", "ranger", "caret", "posterdown",
               "randomForest", "e1071", "DALEX", "DT", "smotefamily", "posterdown","GGally", "counterfactuals", "iml")

for (library_name in libraries) {
  if (!require(library_name, character.only = TRUE)) {
    install.packages(library_name, dependencies = TRUE)
    library(library_name, character.only = TRUE)
  }
}

