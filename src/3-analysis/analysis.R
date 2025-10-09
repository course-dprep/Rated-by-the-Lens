# ===========================
# Analysis Script -> PNG
# ===========================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(rmarkdown)
})

# ---- Load dataset ----
final_dataset <- read.csv("../../gen/temp/final_dataset.csv")

# ---- Run models ----
main_effect <- lm(stars ~ total_photos, data = final_dataset)
model_categories <- lm(stars ~ food_and_drink + menu + environment, data = final_dataset)

mean_photos <- mean(final_dataset$total_photos)
final_dataset <- final_dataset %>%
  mutate(photos_centered = total_photos - mean_photos)
model_central_moderation <- lm(stars ~ photos_centered * photo_category_dominant, data = final_dataset)

# ---- Output paths ----
output_dir <- "../../gen/output"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

rmd_file   <- file.path(output_dir, "analysis_report.Rmd")
output_png <- file.path(output_dir, "analysis_output.png")

# ---- Write R Markdown file ----
rmd_content <- '
---
title: "Analysis Report"
output: html_document
---

```{r}
summary(main_effect)
summary(model_categories)
summary(model_central_moderation)

'

writeLines(rmd_content, con = rmd_file)

#---- Render the HTML report ----
  
  html_file <- rmarkdown::render(
    input = rmd_file,
    output_format = "html_document",
    envir = globalenv(),
    quiet = TRUE
  )

#---- Ensure webshot2 is available, then convert HTML -> PNG ----
  
  if (!requireNamespace("webshot2", quietly = TRUE)) {
    install.packages("webshot2")
  }
if (requireNamespace("webshot", quietly = TRUE)) {
  try(webshot::install_phantomjs(), silent = TRUE)
}

library(webshot2)
webshot(html_file, file = output_png, vwidth = 1200, vheight = 1600)

cat("Analysis report successfully created as PNG at", output_png, "\n")



  
  

