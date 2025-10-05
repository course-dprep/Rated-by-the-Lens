## Upload all necessary packages to library
library(dplyr)
library(tidyr)
library(ggplot2)
library(car)
library(sandwich)
library(lmtest)

#load the final data set
final_dataset <- read.csv("./data/final_dataset.csv")

#ASSUMPTION: SKEWNESS

ggplot(final_dataset, aes(x = total_photos)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(title = "Histogram of total photo's")
#total_photos is skewed --> use log

#ASSUMPTION: independent observations -> is met because every restaurant only occurs once

#ASSUMPTION: linear relation between DV and IV
model_dv_iv <- lm(stars~total_photos, data = final_dataset)
plot(model_dv_iv, which = 1)
#assumption not met! Non-linear relationship --> fix with log()

#BASELINE ANALYSIS: Clarifying the Main Effects Before Testing Moderation
#Before introducing the interaction between total photos and photo type (our main model), we first examine the simple main effects. 
#This helps to clarify whether there is a general association between the number of photos and ratings, and how the different photo categories relate to ratings on their own.

#Main effect of amount of photo's on star rating
main_effect <- lm(stars ~ log(total_photos +1), data = final_dataset)
summary(main_effect)

#Interpretation: On average, restaurants without photos are expected to have a star rating of about 3.40.
#A 1% increase in the total number of photos is associated with an expected 0.0015 increase in star rating.
#This positive and significant relationship (p < 0.05) confirms that photo quantity generally correlates with higher ratings—addressing the first part of our research question.

#Next, a regression is run using only the categorical variables to find the main effects, excluding total_photos
model_categories <- lm(stars~log(food_and_drink+1) + log(menu+1) + log(environment+1),  data = final_dataset)
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
#Normally, you'll put a moderator after the IV with * like this:
wrong_model <- lm(stars~log(total_photos+1) * food_and_drink * menu * environment, data= final_dataset )
#However, because the 3 category variables add up to total_photos, this leads to perfect multicollinearity and the model will predict wrong.
#Therefore, i create a variable which indicates per business_id which type of category is most occurring (either food_and_drink, menu, or environment)

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
#The photo_category_dominant tells you what type of photo occurs most in the review of that restaurant
#Transform photo_category_dominant to a factor variable so our regression interpreters it correctly
final_dataset$photo_category_dominant <- factor(final_dataset$photo_category_dominant)

#Now, we have different treatment groups within this variable. We have to check the assumption if variance is equal among the groups.
final_dataset$model_residuals <- residuals(model_central) 
levene_result <- leveneTest(model_residuals ~ photo_category_dominant, 
                            data = final_dataset, 
                            center = median) 

print(levene_result)
#The p-value is below .05 --> there is heteroscedasticity 
#To fix this, we have to use robust standard errors in our model (using coeftest)

model_moderation_1 <- lm(stars ~ log(total_photos +1) * photo_category_dominant, data = final_dataset)
coeftest(model_moderation_1, vcov = vcovHC(model_moderation_1, type = "HC3"))
#Interpretation: is strange because a total_photos cannot be 0 while at the same time there is a prominent photo-group
#Better to centralize the model where we use the mean of total_photos as the intercept (mean = log(1.53) or 5.8 photos)

mean_log_photos <- mean(log(final_dataset$total_photos + 1))

# Create the centralized variable in the data set
final_dataset <- final_dataset %>%
  mutate(log_photos_centered = log(total_photos + 1) - mean_log_photos)

# Re-run the model with the centralized variable
model_central <- lm(stars ~ log(total_photos+1) * photo_category_dominant, data = final_dataset)
coeftest(model_central, vcov = vcovHC(model_central, type = "HC3"))

#Interpretation: when photos is at its mean (log(1.53) or 5.8 photos) and environmental photos is the dominant group, on average, the star rating is expected to be 3.53 (significant p<0.05).
#When environment is the dominant category, and the amount of photo's increases with 1%, the expected star rating increases with 0.00152 (significant p<0.05)

#Restaurants where Food and Drink is the dominant category have a significantly lower expected star rating (0.23 stars lower) than Environment-dominant restaurants, holding the photo count constant at the average level.
#Restaurants where Menu is dominant have no significant difference in the expected star rating compared to the Environment-dominant restaurants.

#Interactions:
#The effect of increasing photos is not significantly different for the Food and Drink group compared to the Environment group.
#The effect of increasing photos is not significantly different for the Menu group compared to the Environment group

summary(model_central)
#When we look at the R-squared, we see that that the total explained variance by our model is very low (around 3.5%). 
#This means that, although the number of photos and the dominant category have a measurable effect,
#The vast majority of the variation in star ratings is caused by other factors that were not included in the model.


