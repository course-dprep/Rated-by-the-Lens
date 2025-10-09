# ===========================
# Visualization -> PNG files
# ===========================

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
})

# ---- Load data ----
final_dataset <- read.csv("../../gen/temp/final_dataset.csv")

# ---- Ensure output directory exists ----
out_dir <- "../../gen/output"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# ---- Plot A — Stars vs Total Photos ----
png(file.path(out_dir, "stars_vs_photos.png"), width = 1200, height = 900, res = 144)
print(
  ggplot(final_dataset, aes(x = total_photos, y = stars)) +
    geom_point(alpha = 0.4, color = "blue") +
    labs(
      title = "Stars vs Total Photos",
      x = "Total Photos",
      y = "Stars"
    ) +
    theme_minimal(base_size = 14)
)
dev.off()

# ---- Plot B — Total Photos per Category ----
plot_data <- tibble::tibble(
  photo_type = c("Environment", "Food_and_Drink", "Menu"),
  total = c(
    sum(final_dataset$environment,     na.rm = TRUE),
    sum(final_dataset$food_and_drink,  na.rm = TRUE),
    sum(final_dataset$menu,            na.rm = TRUE)
  )
)

png(file.path(out_dir, "photos_per_category.png"), width = 1200, height = 900, res = 144)
print(
  ggplot(plot_data, aes(x = photo_type, y = total, fill = photo_type)) +
    geom_col() +
    labs(
      title = "Total Photos per Category",
      x = "Photo Type",
      y = "Total Photos"
    ) +
    theme_minimal(base_size = 14) +
    theme(legend.position = "none")
)
dev.off()

cat("PNG plots saved to", out_dir, "\n")