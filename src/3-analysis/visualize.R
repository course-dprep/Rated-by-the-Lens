# LOAD PACKAGES
library(dplyr)
library(tidyr)
library(ggplot2)

# LOAD DATA
final_dataset <- read.csv("../../gen/temp/final_dataset.csv")

# ENSURE OUTPUT DIRECTORY EXISTS
dir.create("../../gen/output", recursive = TRUE, showWarnings = FALSE)

# OPEN PDF DEVICE
pdf("../../gen/output/visualizations.pdf")

# PLOT A — Stars vs Total Photos
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

# PLOT B — Total Photos per Category
plot_data <- data.frame(
  photo_type = c("Environment", "Food_and_Drink", "Menu"),
  total = c(
    sum(final_dataset$environment, na.rm = TRUE),
    sum(final_dataset$food_and_drink, na.rm = TRUE),
    sum(final_dataset$menu, na.rm = TRUE)
  )
)

print(
  ggplot(plot_data, aes(x = photo_type, y = total, fill = photo_type)) +
    geom_col() +
    labs(
      title = "Total Photos per Category",
      x = "Photo Type",
      y = "Total Photos"
    ) +
    theme_minimal(base_size = 14)
)

# FORCE FLUSH + CLOSE DEVICE
dev.flush()
dev.off()

cat("PDF with plots successfully saved to ../../gen/output/report.pdf\n")