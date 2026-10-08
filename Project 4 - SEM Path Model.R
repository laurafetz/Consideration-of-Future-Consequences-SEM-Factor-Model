### Laura Maria Fetz
### SEM Factor Model Multi-group
### Last updated: 8th of October 2026

#------------------------------------------------------------------------------- LOADING DATA AND PACKAGES
# Load packages
library(lavaan)
library(semTools)
library(tidyverse)
library(haven)
library(dplyr)
library(countrycode)
library(psych)

# Import Data
CFCS <- read_delim("UvA/second year/SEM/CFCS.csv", 
                   delim = "\t", escape_double = FALSE, 
                   trim_ws = TRUE,
                   na = "0")

# Final age group
data <- CFCS %>%
  filter(age >= 13 & age <= 19) 

#------------------------------------------------------------------------------- RECODE ITEMS
# Recode the negatively worded items
data$Q3 <- 6 - data$Q3
data$Q4 <- 6 - data$Q4
data$Q5 <- 6 - data$Q5
data$Q9 <- 6 - data$Q9
data$Q10 <- 6 - data$Q10
data$Q11 <- 6 - data$Q11
data$Q12 <- 6 - data$Q12

#------------------------------------------------------------------------------- MEAN CENTER ITEMS
# Mean centering the items
data$Q1 <- data$Q1 - mean(data$Q1, na.rm = TRUE)
data$Q2 <- data$Q2 - mean(data$Q2, na.rm = TRUE)
data$Q3 <- data$Q3 - mean(data$Q3, na.rm = TRUE)
data$Q4 <- data$Q4 - mean(data$Q4, na.rm = TRUE)
data$Q5 <- data$Q5 - mean(data$Q5, na.rm = TRUE)
data$Q6 <- data$Q6 - mean(data$Q6, na.rm = TRUE)
data$Q7 <- data$Q7 - mean(data$Q7, na.rm = TRUE)
data$Q8 <- data$Q8 - mean(data$Q8, na.rm = TRUE)
data$Q9 <- data$Q9 - mean(data$Q9, na.rm = TRUE)
data$Q10 <- data$Q10 - mean(data$Q10, na.rm = TRUE)
data$Q11 <- data$Q11 - mean(data$Q11, na.rm = TRUE)
data$Q12 <- data$Q12 - mean(data$Q12, na.rm = TRUE)

#------------------------------------------------------------------------------- DESCRIPTIVES
# describe data
describe(data)

# Get the counts per country
counts <- table(data$country)

# Calculate percentages
percentages <- round(100 * counts / sum(counts), 1)

# Combine the counts and percentages into a data frame for a table view
country_stats <- data.frame(Country = names(counts), 
                            Count = counts, 
                            Percentage = percentages)

# View the table
View(country_stats)


# Use countrycode with custom dictionary
data$continent <- countrycode(data$country, "iso2c", "continent", nomatch = NA)

# gender continent counts
gender_continent_counts <- table(data$gender, data$continent)

# Calculate percentages for each gender
calculate_percentages <- function(counts) {
  percentages <- round((counts / sum(counts)) * 100, 1) # Calculate and round percentages
  labels <- paste(names(counts), "-", percentages, "%") # Create labels with percentages
  return(labels)
}

# Create pie charts with percentages in labels
par(mfrow = c(1, 3)) # Set up the plotting area to have 3 columns for 3 pie charts

# Male pie chart with percentages
male_counts <- gender_continent_counts[1, ]
male_labels <- calculate_percentages(male_counts)
pie(male_counts, labels = male_labels, main = "Male Counts per Continent")

# Female pie chart with percentages
female_counts <- gender_continent_counts[2, ]
female_labels <- calculate_percentages(female_counts)
pie(female_counts, labels = female_labels, main = "Female Counts per Continent")

# Diverse pie chart with percentages
diverse_counts <- gender_continent_counts[3, ]
diverse_labels <- calculate_percentages(diverse_counts)
pie(diverse_counts, labels = diverse_labels, main = "Diverse Counts per Continent")

# Get the counts per gender
counts2 <- table(data$gender)

# Create a pie chart using counts as values and predefined gender names as labels
pie(counts2, labels = c("Male", "Female", "Diverse"), 
    main = "Counts per Gender")


# Calculate percentages
percentages2 <- round(100 * counts2 / sum(counts2), 1)

# Combine the counts and percentages into a data frame for a table view
gender_stats <- data.frame(Gender = names(counts2), 
                           Count = counts2, 
                           Percentage = percentages2)

# View the table
View(gender_stats)

#------------------------------------------------------------------------------- MISSINGNESS
# Calculate the percentage of missing values for each column
percentagemissing <- colMeans(is.na(data)) * 100

# Print the result
print(percentagemissing)
#------------------------------------------------------------------------------- REMOVING UNNECESSARY VARIABLES
# Final data set for analysis
data <- data %>%
  select (-country, -accuracy, -continent) %>%
  mutate_all(as.numeric)

#------------------------------------------------------------------------------- ONE COMMON FACTOR
# One factor model
mod.1 <- '
    # Factor loadings
      CFC =~ Q1 + Q2 + Q3 + Q4 + Q5 + Q6 + Q7 + Q8 + Q9 + Q10 + Q11 + Q12'

# Run model
mod.1.out <- cfa(mod.1, data = data, 
                 std.lv = TRUE, 
                 meanstructure = TRUE, 
                 missing = "fiml", 
                 group = "gender")


# Summary
summary(mod.1.out, standardized = TRUE, fit = TRUE, rsquare = TRUE, ci =TRUE)

#------------------------------------------------------------------------------- PLOT MODEL
# Simple plot 
semPaths(mod.1.out, what = "std", layout = "tree", rotation = 1)


#------------------------------------------------------------------------------- TWO COMMON FACTOR 
# Two factor model
mod.2 <- '
  # Factor loading 
    PCFC =~ Q1 + Q2 + Q6 + Q7 + Q8
    ICFC =~ Q3 + Q4 + Q5 + Q9 + Q10 + Q11 + Q12
'

# Run model 
mod.2.out <- cfa(mod.2, data = data, 
                 std.lv = TRUE, 
                 meanstructure = TRUE, 
                 missing = "fiml", 
                 group = "gender")

# Summary
summary(mod.2.out, fit = TRUE)

#------------------------------------------------------------------------------- PLOT MODEL
# Simple plot 
semPaths(mod.2.out, what = "std", layout = "tree", rotation = 1)

#------------------------------------------------------------------------------- COMPARE WHICH MODEL FITS BETTER
# Model comparison
anova(mod.1.out, mod.2.out)

#------------------------------------------------------------------------------- CONFIGURAL MEASURMENT INVARIANCE
# Configural Model
confi.mod <- '
    # Factor Analysis Model
    # Define latent factors
    PCFC =~ Q1 + Q2 + Q6 + Q7 + Q8
    ICFC =~ Q3 + Q4 + Q5 + Q9 + Q10 + Q11 + Q12
    '

# Run Model
mod.confi.out <- cfa(confi.mod, data = data, 
                     std.lv = TRUE, 
                     meanstructure = TRUE,
                     missing = "fiml",
                     group = "gender")

# Summary
summary(mod.confi.out,  standardized = TRUE, fit = TRUE, rsquare = TRUE, ci =TRUE)

#------------------------------------------------------------------------------- METRIC MEASURMENT INVARIANCE
# Metric model
metric.mod <- '
    # Factor Analysis Model
    # Define latent factors
    PCFC =~ c(L11, L11, L11)*Q1 + c(L21, L21, L21)*Q2 + 
              c(L31, L31, L31)*Q6 + c(L41, L41, L41)*Q7 + 
              c(L51, L51, L51)*Q8
            
    ICFC =~ c(L12, L12, L12)*Q3 + c(L22, L22, L22)*Q4 + 
               c(L32, L32, L32)*Q5 + c(L42, L42, L42)*Q9 + 
               c(L52, L52, L52)*Q10 + c(L62, L62, L62)*Q11 + 
               c(L72, L72, L72)*Q12
    
    PCFC ~~ c(1,NA,NA)*PCFC
    ICFC ~~ c(1,NA,NA)*ICFC
'

# Run Model
mod.metric.out <- cfa(metric.mod, data = data, 
                      std.lv = TRUE, 
                      meanstructure = TRUE, 
                      missing = "fiml",
                      group = "gender")

# Summary
summary(mod.metric.out,  standardized = TRUE, fit = TRUE, rsquare = TRUE, ci =TRUE)

#------------------------------------------------------------------------------- TESTING IF METRIC INVARIANCE HOLDS
# Chi square difference test
anova(mod.confi.out, mod.metric.out)

#------------------------------------------------------------------------------- SCALAR MEASURMENT INVARIANCE
# Scalar model
scalar.mod <- '
    # Factor Analysis Model
    # Define latent factors
    PCFC =~ c(L11, L11, L11)*Q1 + c(L21, L21, L21)*Q2 + 
              c(L31, L31, L31)*Q6 + c(L41, L41, L41)*Q7 + 
              c(L51, L51, L51)*Q8
              
    ICFC =~ c(L12, L12, L12)*Q3 + c(L22, L22, L22)*Q4 + 
               c(L32, L32, L32)*Q5 + c(L42, L42, L42)*Q9 + 
               c(L52, L52, L52)*Q10 + c(L62, L62, L62)*Q11 + 
               c(L72, L72, L72)*Q12
    
    PCFC ~~ c(1,NA,NA)*PCFC
    ICFC ~~ c(1,NA,NA)*ICFC
    
    # Mean Structure
    Q1 ~ c(T1, T1, T1)*1
    Q2 ~ c(T2, T2, T2)*1
    Q3 ~ c(T3, T3, T3)*1
    Q4 ~ c(T4, T4, T4)*1
    Q5 ~ c(T5, T5, T5)*1
    Q6 ~ c(T6, T6, T6)*1
    Q7 ~ c(T7, T7, T7)*1
    Q8 ~ c(T8, T8, T8)*1
    Q9 ~ c(T9, T9, T9)*1
    Q10 ~ c(T10, T10, T10)*1
    Q11 ~ c(T11, T11, T11)*1
    Q12 ~ c(T12, T12, T12)*1
    
    PCFC ~ c(0, NA, NA)*1
    ICFC ~ c(0,NA, NA)*1
'

#Run Model
mod.scalar.out <- cfa(scalar.mod, data = data, 
                      std.lv = TRUE, 
                      meanstructure = TRUE, 
                      missing = "fiml",
                      group = "gender")

# Summary
summary(mod.scalar.out,  standardized = TRUE, fit = TRUE, rsquare = TRUE, ci =TRUE)
#------------------------------------------------------------------------------- TESTING IF SCALAR MEASURMENT INVARIANCE HOLDS
# Chi square difference test
anova(mod.scalar.out, mod.metric.out)

