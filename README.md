
# The Impact of Photos on Restaurant Ratings: Evidence from Yelp
This project aims to empirically investigate the relationship between the number of photos attached on Yelp and the restaurant’s average rating, as well as the extent to which the type of photo (food & drink, environment, menu) moderates this relationship. The purpose of this study is to provide practical insights for managers and restaurant owners on how photos in reviews may enhance ratings, certainty and increase potential visitors. To address this, a multiple linear regression model is applied with data obtained from Yelp open dataset.
## Motivation
The influence of online reviews and electronic word of mouth (eWOM) on consumer perceptions and decision-making is evident in today’s digital society (Wang et al., 2021). As such, this phenomenon has been widely researched in marketing.

The influence of reviews is especially pronounced in the case of “experience goods,” such as restaurant services, which are perceived as riskier to evaluate before purchase (Weisskopf, 2018). Previous findings suggest that by reading restaurant reviews, customers are able to reduce this perceived risk (Parikh et al., 2014). Further supporting this claim, Luca (2016, p.3) demonstrates that  “a one-star increase in Yelp rating leads to a 5–9 percent increase in revenue”. Increasingly, pictures have become a common addition to online reviews (Li et al., 2021). However, while text-based reviews have been extensively studied, the association between the number of photos and a restaurant’s average rating remains underexplored. Current literature is limited with regard to how different types of photos (food, environment, or menu) might impact this relationship. To address this gap in the literature, the following research question has been formulated:

**“To what extent does the number of photos associated with a restaurant on Yelp impact its average rating, and how does the type of photo(food, environment, menu) moderate this relationship?”**

-------------------------------------------------------
## Managerial Relevance
-------------------------------------------------------

From a managerial perspective, restaurant owners and managers may benefit from the findings of this project by using evidence on the total number and type of photos. In turn, the aforementioned stakeholders may gain a deeper understanding on how to raise ratings per restaurant, reduce average rating volatility and increase visibility and engagement. This is beneficial as Luca (2016) concluded that the average rating of a restaurant guides customers to make informed decisions. Ultimately, this may lead to an improved reputation and subsequently increased customer demand.

Furthermore, managers can enhance their marketing strategy by strategically encouraging customers to publish reviews with photos on platforms such as Yelp or Tripadvisor as it reduces customer uncertainty. To encourage reviews that include photos, managers may add QR codes on the menu or receipts that could incentivize customers with rewards for the uploaded photos. Additional innovative approaches are table toppers and Wi-Fi login prompts inviting the customers to share a photo of the dish or environment. By prompting customers to share additional photos, managers may be more inclined to detect recurring issues, creating a feedback loop.

## Data

Firstly, to collect the required data, the datasets “dataset_business" and "dataset_photos" have been downloaded from Yelp Open Dataset, see https://business.yelp.com/data/resources/open-dataset/. Accordingly, we have built an R pipeline (tidyr and dyplr) that merged and cleaned the data.

The steps executed after were:


- Calculated the amount of photos that exist for “food & drink”, “environment” and “menu” for each business_id.
- Transformed the data in order to separate columns for each category.
- Handled missing businesses by assigning them to value 0 and kept only restaurants.
- Inserted a new column “total_photos” per business.
- Filtered for restaurants.
- Performed a safety check.

As follows, the “DataPreparationTeam9.Rmd” with 29.374 observations and 10 variables was obtained. The study will utilize and analyze the subsequent variables: 


## Method

This project will be based on the Multiple Linear Regression (MLR) as this model is utilized if a continuous dependent variable (DV) occurs with multiple independent variables (IVs). As opposed to a simple linear regression, MLR can test the interaction between the independent variable and moderator, allowing for a better understanding of how different types of photos affect business’ average ratings. 

Furthermore, coefficients are immediately interpretable as changes in star rating. With the use of log(1+Photos) we capture the diminishing returns while also reducing leverage from large amounts of photos, including the 2 outliers above 400 in our sample. We applied MLR to assess whether the relationships are positive or negative and statistically significant. The regression is as follows:

Y = b0 +b1log(1 + Photos)+b2Menu + b3[log(1+Photos)xMenu] + e

Here, “Menu” is the sole dummy variable where 1 occurs when menu/price photos are present and 0 if absent.

## Preview of Findings 
- Describe the gist of your findings (save the details for the final paper!)
- How are the findings/end product of the project deployed?
- Explain the relevance of these findings/product. 

## Repository Overview 

**Include a tree diagram that illustrates the repository structure*

## Dependencies 

*Explain any tools or packages that need to be installed to run this workflow.*

## Running Instructions 

*Provide step-by-step instructions that have to be followed to run this workflow.*

## About 
This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team 9 members: 
Amelia Syta, Carla Alboquers Coll, Ezgi Torbala, Shery Khalil, and Sophie Wolf.

## References
Li, C., Kwok, L., Xie, K. L., Liu, J., & Ye, Q. (2021). Let Photos Speak: The Effect of User-Generated Visual Content on Hotel Review Helpfulness. Journal of Hospitality & Tourism Research, 47(4), 109634802110191. https://doi.org/10.1177/10963480211019113

Luca, M. (2016). Reviews, Reputation, and Revenue: The Case of Yelp.com. Harvard Business School NOM Unit Working Paper, 12(016). https://doi.org/10.2139/ssrn.1928601

Parikh, A., Behnke, C., Vorvoreanu, M., Almanza, B., & Nelson, D. (2014). Motives for reading and articulating user-generated restaurant reviews on Yelp.com. Journal of Hospitality and Tourism Technology, 5(2), 160–176. https://doi.org/10.1108/jhtt-04-2013-0011

Wang, Y., Kim, J., & Kim, J. (2021). The financial impact of online customer reviews in the restaurant industry: A moderating effect of brand equity. International Journal of Hospitality Management, 95, 102895. https://doi.org/10.1016/j.ijhm.2021.102895

Weisskopf, D. J.-P. (2018, September 30). Online Customer Reviews: Their Impact on Restaurants. Hospitalityinsights.ehl.edu. https://hospitalityinsights.ehl.edu/online-customer-reviews-restaurants
