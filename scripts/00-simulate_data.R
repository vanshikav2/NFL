#### Preamble ####
# Purpose: Simulates... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


# Load necessary libraries
library(tidyverse)

# Simulate NFL quarterback data
qb_data <- tibble(
  passing_yards = rnorm(100, mean = 250, sd = 50),
  completion_percentage = runif(100, min = 50, max = 75),
  rolling_avg_epa = rnorm(100, mean = 0, sd = 1),
  passing_epa = rnorm(100, mean = 5, sd = 2)
)

# Select relevant features and target variable
features <- c("passing_yards", "completion_percentage", "rolling_avg_epa")
target <- "passing_epa"

# Split data into training and validation sets
set.seed(123)  # For reproducibility
train_indices <- sample(1:nrow(qb_data), 0.8 * nrow(qb_data))
train_data <- qb_data[train_indices, ]
valid_data <- qb_data[-train_indices, ]

# Perform exploratory data analysis
summary(train_data)
cor(train_data[, features])

# Visualize relationships between variables
ggplot(train_data, aes(x = passing_yards, y = passing_epa)) +
  geom_point() +
  labs(x = "Passing Yards", y = "Passing EPA") +
  theme_minimal()

ggplot(train_data, aes(x = completion_percentage, y = passing_epa)) +
  geom_point() +
  labs(x = "Completion Percentage", y = "Passing EPA") +
  theme_minimal()

ggplot(train_data, aes(x = rolling_avg_epa, y = passing_epa)) +
  geom_point() +
  labs(x = "Rolling Average EPA", y = "Passing EPA") +
  theme_minimal()

