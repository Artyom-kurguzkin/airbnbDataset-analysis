# install.packages('factoextra')
# install.packages('cluster')
install.packages('tidyverse')
install.packages("caret")
install.packages("mlr")

library(tidyverse)
library(caret)
library(mlr)


data = read_tsv('part-01/dat/data.tsv')
# Convert the tibble to a data frame
data_frame <- as.data.frame(data)

# Define the target variable column name
target_col <- "target_variable"

# Define the predictor column names
predictor_cols <- c("predictor1", "predictor2", "predictor3")

# Split the data into training and testing sets
set.seed(123)
train_indices <- sample(1:nrow(data_frame), 0.7 * nrow(data_frame))
train_data <- data_frame[train_indices, ]
test_data <- data_frame[-train_indices, ]

# Define the machine learning task
task <- makeClassifTask(data = train_data, target = target_col, predictors = predictor_cols)

# Define the learner
learner <- makeLearner("classif.randomForest")

# Train the model
model <- train(learner, task)

# Make predictions on the test data
predictions <- predict(model, newdata = test_data)

# Evaluate the model
performance <- confusionMatrix(predictions, test_data$target_variable)
print(performance)

