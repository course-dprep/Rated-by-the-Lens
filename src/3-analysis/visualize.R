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

# Helper function to save plots as PNG
save_summary_png <- function(model, file_path) {
  txt <- capture.output(summary(model))  # capture summary as text
  txt <- paste(txt, collapse = "\n")     # combine into a single string
  
  # Create PNG
  png(file_path, width = 800, height = 600)
  grid.newpage()
  grid.text(txt, x = 0.05, y = 0.95, just = c("left", "top"), gp = gpar(fontsize = 12, fontfamily = "mono"))
  dev.off()
}

output_dir <- "../../gen/output"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

save_summary_png(stars_total_photos, file.path(output_dir, "stars_total_photos.png"))
save_summary_png(photo_category_plot, file.path(output_dir, "photo_category_plot.png"))

cat("PNG's with plots successfully saved to ../../gen/output/report.pdf\n")