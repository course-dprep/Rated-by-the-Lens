## Upload all necessary packages to library
library(dplyr)
library(tidyr)
library(ggplot2)
library(rmarkdown)
library(grid)

# Load the final dataset (path relative to src/3-analysis)
final_dataset <- read.csv("../../gen/temp/final_dataset.csv")

# BASELINE ANALYSIS
main_effect <- lm(stars ~ total_photos, data = final_dataset)
summary(main_effect)

model_categories <- lm(stars ~ food_and_drink + menu + environment, data = final_dataset)
summary(model_categories)

# MAIN MODEL: Linear regression with moderators
mean_photos <- mean(final_dataset$total_photos)
final_dataset <- final_dataset %>%
  mutate(photos_centered = total_photos - mean_photos)

model_central_moderation <- lm(stars ~ photos_centered * photo_category_dominant, data = final_dataset)
summary(model_central_moderation)

#Retain the function and output_dir from visualize.R
source("visualize.R")

# Save each model summary as PNG
save_summary_png(main_effect, file.path(output_dir, "main_effect.png"))
save_summary_png(model_categories, file.path(output_dir, "model_categories.png"))
save_summary_png(model_central_moderation, file.path(output_dir, "model_central_moderation.png"))

cat("All model summaries saved as PNGs in", output_dir, "\n")
