# LOAD PACKAGES

## Step 1: Upload all necessary packages to library
library(dplyr)
library(tidyr)
library(ggplot2)

# CLEAN DATA

dataset_business <- read.csv("./data/business.csv")
dataset_photos <- read.csv("./data/photos.csv")

## Step 3: Merge dataset_photos and dataset_business using the "business_id"

merged_dataset <- inner_join(dataset_business, dataset_photos, by = "business_id") #Here, merged_dataset has more obs than dataset_business because businesses have more than one photo. This will be fixed in later steps.

## Step 4: Remove unnecessary variables

# Columns retained: business_id, review_count, name, attributes, categories, stars, photo_id, caption, label
# Removes extra columns that are not needed for analysis; 

colnames(merged_dataset)
filtered_merged_dataset <- merged_dataset %>% select(business_id, review_count, name,label, attributes, categories, stars, photo_id, caption)

## Step 5: Grouping photo categories ('label') into three easy-to-understand categories

# New variable 'label_grouped' is created to store the new categories:
# 'food' and 'drink' -> 'food_and_drink'
# 'inside' and 'outside' -> 'environment'
# 'menu' -> 'menu'

recategorized_filtered_merged_dataset <- filtered_merged_dataset %>% mutate(label_grouped = case_when(
    label %in% c("food", "drink") ~ "food_and_drink",
    label %in% c("inside", "outside") ~ "environment",
    label == "menu" ~ "menu",
    TRUE ~ label   # fallback in case there are unexpected values
  ))

## Step 6: Count photos per business_id,per category and total

#  For each business_id, we calculate how many photos exist for 'food_and_drink','environment' and 'menu' categories. 
#  We then pivot the data so that each category becomes a separate column.
#  Missing categories for a business are replaced with 0.
## Justification for treatment of NAs: if a business has no photos in a category, the true count is 0 (not unknown).
#  Finally, we add a 'total_photos' column showing the total number of photos per business.

photo_counts_added <- recategorized_filtered_merged_dataset %>%
  group_by(business_id, review_count, name, attributes, categories, stars) %>%
  count(label_grouped, name = "photo_count") %>%
  pivot_wider(names_from = label_grouped, values_from = photo_count, values_fill = 0) %>%
  mutate(total_photos = rowSums(across(c(environment, food_and_drink, menu))))

## Step 7: Filter to keep restaurants only

# Final step of creating the data set, filtering of photo_counts_added dataset to keep only those businesses classified as restaurants
dataset_draft <- photo_counts_added %>% filter (grepl("Restaurants", categories, ignore.case = TRUE))

## Step 8: Check for duplicates

# Safety check; removes exact duplicated rows there are among all rows and counts how many rows were removed
final_dataset <- dataset_draft %>% distinct()
num_removed <- nrow(dataset_draft) - nrow(final_dataset)
cat("Number of exact duplicate rows removed:", num_removed, "\n")

## Step 9: Create moderator variable
# The three category variables sum to total_photos, causing perfect multicollinearity.
# To avoid this, create one variable showing the dominant category (food_and_drink, menu, or environment) per business_id.

#Determine the maximum value of every category
final_dataset <- final_dataset %>%
  mutate(max_photos = pmax(food_and_drink, menu, environment))

#Choose the dominant category with the highest max per restaurant
final_dataset <- final_dataset%>% 
  mutate(photo_category_dominant = case_when(
    food_and_drink == max_photos ~ "Food_and_Drink",
    menu == max_photos ~ "Menu",
    environment == max_photos ~ "Environment",
    TRUE ~ "Equal_or_none" ))
#The photo_category_dominant tells you what type of photo occurs most in the reviews of that restaurant
#Transform photo_category_dominant to a factor variable so our regression interpreters it correctly
final_dataset$photo_category_dominant <- factor(final_dataset$photo_category_dominant)

## Step 9: Save final data set
write.csv(final_dataset, "./data/final_dataset.csv", row.names = FALSE)
