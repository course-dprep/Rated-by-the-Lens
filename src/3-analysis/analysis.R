## Upload all necessary packages to library
library(dplyr)
library(tidyr)
library(ggplot2)

#load the final data set
final_dataset <- read.csv("./data/final_dataset.csv")

#BASELINE ANALYSIS: Clarifying the Main Effects Before Testing Moderation
#Before introducing the interaction between total photos and photo type (our main model), we first examine the simple main effects. 
#This helps to clarify whether there is a general association between the number of photos and ratings, and how the different photo categories relate to ratings on their own.

#Main effect of amount of photo's on star rating
main_effect <- lm(stars ~ total_photos, data = final_dataset)
summary(main_effect)

#Interpretation: On average, restaurants without photos are expected to have a star rating of about 3.40.
#A 1% increase in the total number of photos is associated with an expected 0.0015 increase in star rating.
#This positive and significant relationship (p < 0.05) confirms that photo quantity generally correlates with higher ratings—addressing the first part of our research question.

#Next, a regression is run using only the categorical variables to find the main effects, excluding total_photos
model_categories <- lm(stars~food_and_drink + menu + environment,  data = final_dataset)
summary(model_categories)

#Main effect of food_and_drink on photo's = with 1% increase in photo's, starrating is expected to go down with 0.00017 (significant p<0.05)
#Main effect of menu: with a one unit increase of menu photo's, the expected star rating increases with 0.0026 on average (significant p<0.05)
#Main effect of environment: with a one unit increase of environment photo's, the expected star rating increases with 0.0027 on average (significant p<0.05)

#These baseline results clarify that while photos generally improve ratings,the strength and direction of the relationship differ by category.
#This motivates our main model, where we formally test whether the type of photo moderates the effect of total photos on star rating.

#MAIN MODEL: Linear regression with moderators

#What would be our regression model intuitively? 
#DV = stars
#IV = total photos (put in log to repair skewness)
#Moderator = type of photo

# Because logically, there can only be a dominant group when total_photos > 0, it is not obvious to choose 0 total_photos as intercept.
# We have to centralize the model to the mean of total_photos (=5.8)
mean_photos <- mean(final_dataset$total_photos)

# Create the centralized variable in the data set
final_dataset <- final_dataset %>%
  mutate(photos_centered = total_photos - mean_photos)

# Run the model with the centralized variable
model_central_moderation <- lm(stars ~ photos_centered * photo_category_dominant, data = final_dataset)
summary(model_central_moderation)

#Interpretation: when photos is at its mean (5.8 photos) and environmental photos is the dominant group, on average, the star rating is expected to be 3.53 (significant p<0.05).
#When environment is the dominant category, and the amount of photo's increases with 1%, the expected star rating increases with 0.00152 (significant p<0.05)

#Restaurants where Food and Drink is the dominant category have a significantly lower expected star rating (0.23 stars lower) than Environment-dominant restaurants, holding the photo count constant at the average level.
#Restaurants where Menu is dominant have no significant difference in the expected star rating compared to the Environment-dominant restaurants.

#Interactions:
#The effect of increasing photos is not significantly different for the Food and Drink group compared to the Environment group.
#The effect of increasing photos is not significantly different for the Menu group compared to the Environment group


#When we look at the R-squared, we see that that the total explained variance by our model is very low (around 3.5%). 
#This means that, although the number of photos and the dominant category have a measurable effect,
#The vast majority of the variation in star ratings is caused by other factors that were not included in the model.


