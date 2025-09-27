# LOAD PACKAGES

## Step 1: Upload all necessary packages to library
library(dplyr)
library(tidyr)
library(ggplot2)

# VISUALIZE DATA

## Step 10: Analyze suitable plots for data exploration and visualization:

summary(final_dataset)

# Data visualization using ggplot
# In order to properly understand the newly created data set, it is useful to crate some visualizations.
# Plot A: Visual representation of the average rating and the total photos per restaurant

ggplot(final_dataset, aes(x = total_photos, y = stars)) + geom_point(alpha = 0.3, color = "blue") +labs(title = "Stars vs Total Photos", x = "Total Photos", y = "Stars")

# This scatter plot provides insight into both the IV and DV. More specifically, it shows how the number of stars  varies depending on the rating. We can even see an increasing pattern from 1 to 4 stars. Moreover, we can see the total photo count usually stays between 0 and 200, with two outilers above 400. 
# Plot B: Bar plot showing total photos per category:

ggplot(data = data.frame(photo_type = c("Environment", "Food & Drink", "Menu"),
  total = c(
    sum(final_dataset$environment),
    sum(final_dataset$`food & drink`),
    sum(final_dataset$menu)
  )
), aes(x = photo_type, y = total, fill = photo_type)) +
  geom_col() +
  labs(
    title = "Total Photos per Category",
    x = "Photo Type",
    y = "Total Photos"
  )

# The output aid us in visualizing the number of photos per category.
