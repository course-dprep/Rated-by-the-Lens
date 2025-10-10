---

# The Impact of Photos on Restaurant Ratings: Evidence from Yelp
This project aims to empirically investigate the relationship between the number of photos attached on Yelp and the restaurant’s average rating, as well as the extent to which the type of photo (food & drink, environment, menu) moderates this relationship. The purpose of this study is to provide practical insights for managers and restaurant owners on how photos in reviews may enhance ratings, certainty and increase potential visitors. To address this, a multiple linear regression model is applied with data obtained from Yelp open dataset.

## Motivation
The influence of online reviews and electronic word of mouth (eWOM) on consumer perceptions and decision-making is evident in today’s digital society (Wang et al., 2021). As such, this phenomenon has been widely researched in marketing. The influence of reviews is especially pronounced in the case of “experience goods". For example, restaurant services are perceived as riskier to evaluate before purchase (Weisskopf, 2018). Previous findings suggest that by reading restaurant reviews, customers are able to reduce this perceived risk (Parikh et al., 2014). Further supporting this claim, Luca (2016, p.3) demonstrates that  “a one-star increase in Yelp rating leads to a 5–9 percent increase in revenue”.

Photos have become a key component of online reviews as they add a visual element that allows users to better communicate their opinions (Li et al., 2021). However, while text-based reviews have been extensively studied, the association between the number of photos included in reviews and a restaurant’s average rating remains underexplored. Additionally, current literature is limited with regard to how different types of photos may impact this relationship. To address this gap in the literature, the following research question has been formulated:

**"How does the total number of photos included in Yelp reviews influence a restaurant’s average rating, and to what extent does the type of photo (food, environment, menu) moderate this relationship?"**

## Managerial Relevance

From a managerial and business perspective, the stakeholders, namely restaurant owners and managers, may gain a deeper understanding from the findings of this project on how to potentially raise ratings per restaurant, reduce average rating volatility and increase visibility and engagement. Luca (2016) concluded that the average rating of a restaurant guides customers to make informed decisions. Ultimately, this may lead to an improved reputation and subsequently increased customer demand.

Furthermore, managers can enhance their marketing strategy by strategically encouraging customers to publish reviews with photos on platforms such as "Yelp" or "Tripadvisor" as it reduces customer uncertainty. To encourage reviews that include photos, managers may add QR codes on the menu or receipts that could incentivize customers with rewards for the uploaded photos. Additional innovative approaches are table toppers and Wi-Fi login prompts inviting the customers to share a photo of the food or environment. By prompting customers to share additional photos, managers may be more inclined to detect recurring issues, creating a feedback loop.

## Data

Firstly, to collect the required data, the datasets “dataset_business" and "dataset_photos" have been downloaded from [Yelp Open Dataset](https://business.yelp.com/data/resources/open-dataset/). Accordingly, we have built an R pipeline (tidyr and dyplr) that merged and cleaned the data.

The steps executed after were:


- Calculated the amount of photos that exist for “food & drink”, “environment” and “menu” for each business_id.
- Transformed the data in order to separate columns for each category.
- Handled missing businesses by assigning them to value 0.
- Inserted a new column “total_photos” per business.
- Filtered for restaurants.
- Performed a safety check.

As follows, the “final_dataset.csv” with 29.374 observations and 10 variables was obtained. The study will utilize and analyze the subsequent variables: 
| **Variable** 	| **Description**                                                     	| **Data Class** 	|
|--------------	|---------------------------------------------------------------------	|----------------	|
| business_id  	| The unique Yelp ID of the business                                  	| Character      	|
| name         	| The business name as shown on Yelp                                  	| Character      	|
| attributes   	| The map on Yelp of a restaurant’s amenities, services, and policies 	| List           	|
| categories   	| The list of Yelp categories of cuisines for the business            	| Character      	|
| stars        	| The average Yelp scale star rating (1–5)                            	| Numeric        	|
| review_count 	| The total number of Yelp reviews                                    	| Numeric        	|
| environment  	| The number of environment photos                                    	| Numeric        	|
| food & drink 	| The number of food & drink photos                                   	| Numeric        	|
| menu         	| The number of menu photos                                           	| Numeric        	|
| total_photos 	| The total number of photos for the business                         	| Numeric        	|


## Method

The project combines a series of linear regression models that were estimated in R. In order to create a baseline relationship between the average star rating and the total number of photos, the Simple Linear Regression (SLR) is firstly executed, which provides an initial measure of association. Subsequently, a Multiple Linear Regression (MLR) is estimated as the main model of the analysis. The MLR includes multiple predictors and an interaction (moderation) term, allowing for the assessment of how different photo types contribute to ratings and whether the effect of photo quantity varies depending on photo type. This approach provides a more detailed understanding of the combined and conditional effects of the photo content uploaded by customers on restaurant ratings.

The main model is specified as:

Y=β0​+β1​(Photos)+β2​(Photo Category)+β3​(Photos×Photo Category)+ε

The average restaurant rating is denoted by Y, while the total number of photos is represented by Photos. The dominant type of photo is indicated by Photo Category (food and drink, menu, or environment), and the interaction term determines whether the effect of photo quantity varies across categories.

All models were estimated using the lm() function in R, and results were visualized to support interpretation of both main and interaction effects.

## Preview of Findings 
- Describe the gist of your findings (save the details for the final paper!)
- How are the findings/end product of the project deployed?
- Explain the relevance of these findings/product. 

## Repository Overview 

**Include a tree diagram that illustrates the repository structure*

## Dependencies 

This project relies on several R packages for data manipulation, cleaning, and visualization. Please make sure the following libraries are installed before running the scripts:

- dplyr – used for data wrangling and manipulation

- tidyr – used for tidying and reshaping datasets

- ggplot2 – used for creating visualizations and plots

To install these packages (if not already installed), run the following in R:

```{r}
install.packages(c("dplyr", "tidyr", "ggplot2"))
```
Once installed, the libraries can be loaded with:

```{r}
library(dplyr)

library(tidyr)

library(ggplot2)
```
## Running Instructions 

Before proceeding, please install the following:
- **R** - [Install here](https://tilburgsciencehub.com/topics/computer-setup/software-installation/rstudio/r/)
- If you are a Windows user, also install **Make** - [Download here](https://tilburgsciencehub.com/topics/automation/automation-tools/makefiles/make/)

Instructions to run the code: 
1. Fork the repository on Github.
2. Open your command-line or terminal.
3. Clone the forked repository to your computer:
```bash
git clone https://github.com/course-dprep/Rated-by-the-Lens.git
```
4. Set working directory to 'Rated-by-the-lens':
```bash
cd Rated-by-the-Lens
```
5. Run the automated workflow with the following command:
```bash
make
```
After executing 'make', it will generate the following:
- gen/data/ - downloaded data ('photos.csv and business.csv')
- gen/temp/ - intermediate file ('final_dataset.csv')
- gen/output/ - analysis outputs ('stars_total_photos.png', 'photo_category_plot.png', 
'model _central_moderation.png', 'model_categories.png' and  'main_effect.png')
6. Clean the project: 
```bash
make clean
```
This resets the project folder to its original state.

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
