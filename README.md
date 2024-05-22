# Counterfactual Explanations of Bank Failure Prediction Models

This repository contains code and resources related to the implementation of counterfactual explanations for bank failure prediction models.

## Table of Contents

1. [Overview](#overview)
2. [Contents](#contents)
3. [Getting Started](#getting-started)

## Overview <a name="overview"></a>

Bank failure prediction is a crucial task in financial risk management. Predictive models are developed to assess the likelihood of a bank failing based on various features and historical data. However, understanding the reasons behind model predictions is equally important for stakeholders such as regulators, investors, and bank management.

Counterfactual explanations provide insight into why a particular prediction was made by identifying the minimal changes required to alter the prediction outcome. In the context of bank failure prediction, these explanations can help stakeholders understand the factors contributing to the model's decisions and take appropriate actions to mitigate risks.

![](poster/poster.png)

## Contents <a name="contents"></a>

- `data/`: This directory contains datasets used for training and evaluation.
- `model/`: Implementation of bank failure prediction models.
- `counterfactual_for_all_models/`: Codes for generating counterfactual explanations.
- `poster/`: Codes for PDF poster.

## Getting Started  <a name="getting-started"></a>

1. Clone this repository to your local machine.
2. Download the packages in the [libraries](https://github.com/seymagnn/UYIK2024_Counterfactual_Explanations_of_Bank_Failure_Prediction_Models/blob/main/libraries.R) script.
3. Complete data manipulation operations by pulling metrics from the [arranged data](https://github.com/seymagnn/UYIK2024_Counterfactual_Explanations_of_Bank_Failure_Prediction_Models/blob/main/data/arranging_data.R) script.
4. Splitting data into two subsets in [model partition](https://github.com/seymagnn/UYIK2024_Counterfactual_Explanations_of_Bank_Failure_Prediction_Models/blob/main/model/model_partition.R) script.
5. Each model is included in 3 separate methods for 3 resampling methods and a weighting method. You can get all the counterfactuals in [Oversampling](https://github.com/seymagnn/Counterfactual_Explanations_of_Bank_Failure_Prediction_Models/tree/main/counterfactuals_for_all_models/oversampling), [Undersampling](https://github.com/seymagnn/Counterfactual_Explanations_of_Bank_Failure_Prediction_Models/tree/main/counterfactuals_for_all_models/undersampling), [SMOTE](https://github.com/seymagnn/Counterfactual_Explanations_of_Bank_Failure_Prediction_Models/tree/main/counterfactuals_for_all_models/smote) and [Weighting](https://github.com/seymagnn/Counterfactual_Explanations_of_Bank_Failure_Prediction_Models/tree/main/counterfactuals_for_all_models/weighting) scripts.
