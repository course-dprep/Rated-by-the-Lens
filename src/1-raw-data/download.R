# LOAD PACKAGES

## Step 1: Upload all necessary packages to library
library(dplyr)
library(tidyr)
library(ggplot2)

photos_file <- "./data/photos.csv"
business_file <- "./data/business.csv"

# DOWNLOAD DATA

## Step 2: Setting up the data set that will be used for the analysis

# Load Yelp data sets directly from Google Drive

photos_url <- "https://drive.google.com/uc?export=download&id=117td66LNCSkpULb3ee4pprGYVpOzVQVv"
business_url <- "https://drive.google.com/uc?export=download&id=13AZqPcwUro0jwsZIv6Q3WXeEn58YD5_x"

# From the Yelp Open data set, only the "dataset_business" and "dataset_photos" data sets are downloaded.

download.file(photos_url, photos_file)
download.file(business_url, business_file)