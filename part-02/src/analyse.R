# install.packages('factoextra')
# install.packages('cluster')
install.packages('tidyverse')
install.packages("caret")
install.packages("mlr")

library(tidyverse)
library(caret)
library(mlr)

# Load the data
data = read_tsv('part-01/dat/data.tsv')

# Define the target variable column name
target_col <- "price"

# Define the predictor column names
predictor_cols <- c(data$beds, data$bedrooms, data$bathrooms)

# Split the data into training and testing sets
set.seed(123)

inTraining <- createDataPartition(predictor_cols, p = .80, list = FALSE)
training <- Sonar[ inTraining,]
testing  <- Sonar[-inTraining,]


train_indices <- sample(1:nrow(data), 0.8 * nrow(data))
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

# Create the formula for modeling
formula <- as.formula(paste(target_col, paste(predictor_cols, collapse = " + "), sep = " ~ "))

# Train the model
model <- train(formula, data = train_data, method = "rf")

# Make predictions on the test data
predictions <- predict(model, newdata = test_data)

# Evaluate the model
performance <- confusionMatrix(predictions, test_data[[target_col]])
print(performance)