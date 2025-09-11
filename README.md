
# The Impact of Photos on Restaurant Ratings: Evidence from Yelp
*Describe the purpose of this project* 

## Motivation
The influence of online reviews and electronic word of mouth (eWOM) on consumer perceptions and decision-making is evident in today’s digital society (Wang et al., 2021). As such, this phenomenon has been widely researched in marketing.

The influence of reviews is especially pronounced in the case of “experience goods,” such as restaurant services, which are perceived as riskier to evaluate before purchase (Weisskopf, 2018). Previous findings suggest that by reading restaurant reviews, customers are able to reduce this perceived risk (Parikh et al., 2014). Further supporting this claim, Luca (2016, p.3) demonstrates that  “a one-star increase in Yelp rating leads to a 5–9 percent increase in revenue”. Increasingly, pictures have become a common addition to online reviews (Li et al., 2021). However, while text-based reviews have been extensively studied, the association between the number of photos and a restaurant’s average rating remains underexplored. Current literature is limited with regard to how different types of photos (food, environment, or menu) might impact this relationship. To address this gap in the literature, the following research question has been formulated:

**“To what extent does the number of photos associated with a restaurant on Yelp impact its average rating, and how does the type of photo(food, environment, menu) moderate this relationship?”**

## Data

- What dataset(s) did you use? How was it obtained?
- How many observations are there in the final dataset? 
- Include a table of variable description/operstionalisation. 

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
