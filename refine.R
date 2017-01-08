## Data Wrangling Exercise 1: Basic Data Manipulation (Springboard)
## Exercise: Using R, clean this data set to make it easier to visualize 
## and analyze.
## Author: T. Sironen
## ---------------------------------------------------------------------

## 0: Load Data in RStudio 
## Set working directory to Springboard 
setwd("~/Desktop/Springboard")
## Download refine_orginal.csv into R
refine = read.csv("refine_original.csv")
library(dplyr)
library(tidyr)

## 1: Clean up the misspelled brand names (all lowercase)

refine$company <- gsub(pattern = "ak zo|akz0|Akzo|AKZO", replacement = "akzo", x = refine$company) 
refine$company <- gsub(pattern = "Phillips|phillips|phlips|phllips|phillps|phillipS|fillips", replacement = "philips", x = refine$company)
refine$company <- gsub(pattern = "Unilever|unilver", replacement = "unilever", x = refine$company)
refine$company <- gsub(pattern = "Van Houten|van Houten", replacement = "van houten", x = refine$company)

## 2: Separate product code and number 

refine <- separate(refine, Product.code...number, c("product_code", "product_number"), sep = "-")

## 3: Add product categories for each record
## the product categories are: p = Smartphone, v = TV, x = Laptop, q = Tablet

codes <- c("p" = "Smartphone", "v" = "TV", "x" = "Laptop", "q" = "Tablet")
refine$product_category <- codes[refine$product_code]


## 4: Add full address for geocoding

refine <- unite(refine, "full_address", address, city, country, sep = ", ")

## 5: Create dummy variables for company and product category
## 5.1. Create four binary columms for companies: 
refine <- mutate(refine, company_philips = ifelse(company == "philips", 1, 0))
refine <- mutate(refine, company_akzo = ifelse(company == "akzo", 1, 0))
refine <- mutate(refine, company_van_houten = ifelse(company == "van houten", 1, 0))
refine <- mutate(refine, company_unilever = ifelse(company == "unilever", 1, 0))

## 5.2. Create four binary columns for product categories:
refine <- mutate(refine, product_smartphone = ifelse(product_category == "Smartphone", 1, 0))
refine <- mutate(refine, product_tv = ifelse(product_category == "TV", 1, 0))
refine <- mutate(refine, product_laptop = ifelse(product_category == "Laptop", 1, 0))
refine <- mutate(refine, product_tablet = ifelse(product_category == "Tablet", 1, 0))

## 6: Submit your project in Github
## export the cleaned dataset 
write.csv(refine, "refine_clean.csv")

