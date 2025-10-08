## Upload all necessary packages to library
library(dplyr)
library(tidyr)
library(ggplot2)
library(rmarkdown)

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

# Prepare R Markdown file and output locations
output_dir <- "../../gen/output"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

rmd_file <- file.path(output_dir, "analysis_report.Rmd")
output_pdf <- file.path(output_dir, "analysis_output.pdf")

# Write R Markdown content
rmd_content <- '
---
title: "Analysis Report"
output: pdf_document
---

```{r}
summary(main_effect)
summary(model_categories)
summary(model_central_moderation)
```'

writeLines(rmd_content, con = rmd_file)

# Render directly to PDF in gen/output
rmarkdown::render(
  input = rmd_file,
  output_file = output_pdf
)

cat("Analysis report successfully created in", output_pdf, "\n")
