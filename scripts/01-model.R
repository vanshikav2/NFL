#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
# Load necessary libraries
library(nflverse)
library(tidyverse)
library(rstan)
library(rstanarm)


# Load NFL quarterback statistics
qb_regular_season_stats <- 
  load_player_stats(seasons = TRUE) |> 
  filter(season_type == "REG" & position == "QB")

# Feature Engineering
# Example: Calculate rolling average of passing EPA over the last 3 games
qb_regular_season_stats <- qb_regular_season_stats %>%
  group_by(player_id) %>%
  mutate(rolling_avg_epa = zoo::rollmean(passing_epa, k = 3, fill = NA, align = "right")) %>%
  ungroup()

# Define features and target variable
features <- c("passing_yards", "rolling_avg_epa")  # Removed completion_percentage
target <- "passing_epa"

# Split data into training and validation sets
set.seed(123)  # for reproducibility
train_index <- sample(1:nrow(qb_regular_season_stats), 0.8 * nrow(qb_regular_season_stats))
train_data <- qb_regular_season_stats[train_index, ]
valid_data <- qb_regular_season_stats[-train_index, ]

# Model Training using stan_glm
stan_model <- stan_glm(passing_epa ~ ., data = train_data[, c(features, target)],
                       family = gaussian())


#### Save model ####
saveRDS(
  stan_model,
  file = "models/first_model.rds"
)


