# LOAD PACKAGES

## Step 1: Upload all necessary packages to library
library(dplyr)
library(tidyr)
library(ggplot2)

# CLEAN DATA

dataset_business <- read.csv("./data/business.csv")
dataset_photos <- read.csv("./data/photos.csv")

## Step 3: Merge dataset_photos and dataset_business using the "business_id"

merged_dataset <- merge(dataset_business, dataset_photos, by = "business_id") #Here, merged_dataset has more obs than dataset_business because businesses have more than one photo. This will be fixed in later steps.

## Step 4: Remove unnecessary variables

# Columns retained: business_id, review_count, name, attributes, categories, stars, photo_id, caption, label
# Removes extra columns that are not needed for analysis; 

colnames(merged_dataset)
filtered_merged_dataset <- merged_dataset %>% select(business_id, review_count, name,label, attributes, categories, stars, photo_id, caption)

## Step 5: Grouping photo categories ('label') into three easy-to-understand categories

# New variable 'label_grouped' is created to store the new categories:
# 'food' and 'drink' -> 'food & drink'
# 'inside' and 'outside' -> 'environment'
# 'menu' -> 'menu'

recategorized_filtered_merged_dataset <- filtered_merged_dataset %>% mutate(label_grouped = case_when(
    label %in% c("food", "drink") ~ "food & drink",
    label %in% c("inside", "outside") ~ "environment",
    label == "menu" ~ "menu",
    TRUE ~ label   # fallback in case there are unexpected values
  ))

## Step 6: Count photos per business_id,per category and total

#  For each business_id, we calculate how many photos exist for 'food & drink','environment' and 'menu' categories. 
#  We then pivot the data so that each category becomes a separate column.
#  Missing categories for a business are replaced with 0.
## Justification for treatment of NAs: if a business has no photos in a category, the true count is 0 (not unknown).
#  Finally, we add a 'total_photos' column showing the total number of photos per business.

photo_counts_added <- recategorized_filtered_merged_dataset %>%
  group_by(business_id, review_count, name, attributes, categories, stars) %>%
  count(label_grouped, name = "photo_count") %>%
  pivot_wider(names_from = label_grouped, values_from = photo_count, values_fill = 0) %>%
  mutate(total_photos = rowSums(across(c(`environment`, `food & drink`, menu))))

## Step 7: Filter to keep restaurants only

# Final step of creating the data set, filtering of photo_counts_added dataset to keep only those businesses classified as restaurants
dataset_draft <- photo_counts_added %>% filter (grepl("Restaurants", categories, ignore.case = TRUE))

## Step 8: Check for duplicates

# Safety check; removes exact duplicated rows there are among all rows and counts how many rows were removed
final_dataset <- dataset_draft %>% distinct()
num_removed <- nrow(dataset_draft) - nrow(final_dataset)
cat("Number of exact duplicate rows removed:", num_removed, "\n")

## Step 9: Save final data set
write.csv(final_dataset, "./gen/temp/final_dataset.csv", row.names = FALSE)
