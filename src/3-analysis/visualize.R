# LOAD PACKAGES
library(dplyr)
library(tidyr)
library(ggplot2)
library(grid)

# LOAD DATA
final_dataset <- read.csv("../../gen/temp/final_dataset.csv")

# ENSURE OUTPUT DIRECTORY EXISTS
dir.create("../../gen/output", recursive = TRUE, showWarnings = FALSE)

# PLOT A — Stars vs Total Photos
stars_total_photos <- ggplot(final_dataset, aes(x = total_photos, y = stars)) +
    geom_point(alpha = 0.4, color = "blue") +
    labs(
      title = "Stars vs Total Photos",
      x = "Total Photos",
      y = "Stars"
    ) +
    theme_minimal(base_size = 14)

# PLOT B — Total Photos per Category
plot_data <- data.frame(
  photo_type = c("Environment", "Food_and_Drink", "Menu"),
  total = c(
    sum(final_dataset$environment, na.rm = TRUE),
    sum(final_dataset$food_and_drink, na.rm = TRUE),
    sum(final_dataset$menu, na.rm = TRUE)
  )
)

photo_category_plot<-ggplot(plot_data, aes(x = photo_type, y = total, fill = photo_type)) +
    geom_col() +
    labs(
      title = "Total Photos per Category",
      x = "Photo Type",
      y = "Total Photos"
    ) +
    theme_minimal(base_size = 14)

# SAVE PLOTS AS PNG
output_dir <- "../../gen/output"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

ggsave(filename = file.path(output_dir, "stars_total_photos.png"), plot = stars_total_photos, width = 8, height = 6)
ggsave(filename = file.path(output_dir, "photo_category_plot.png"), plot = photo_category_plot, width = 8, height = 6)

cat("PNG's with plots successfully saved to ../../gen/output/report.pdf\n")