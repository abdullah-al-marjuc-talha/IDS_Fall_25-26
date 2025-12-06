
data("mtcars")
head(mtcars)

library(ggplot2)
ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "HP vs MPG", x = "Horsepower", y = "Miles per Gallon")

ggplot(mtcars, aes(y = mpg)) +
  geom_boxplot(fill = "purple") +
  labs(title = "Boxplot of Miles per Gallon", y = "MPG")

library(GGally)
ggcorr(mtcars, label = TRUE)

# --- Handling Missing Values ---

# Check how many NA values are in each column
colSums(is.na(mtcars))

# Create a new dataframe with rows containing NA values removed
mtcars_clean <- na.omit(mtcars)

# Verify that there are no more NA values
cat("Total NA values after cleaning:", sum(is.na(mtcars_clean)), "\n")

mtcars_clean <- mtcars_clean[!duplicated(mtcars_clean), ]

library(dplyr)
mtcars_filtered <- mtcars_clean %>% filter(mpg > 20)

mtcars_selected <- mtcars_filtered %>% select(mpg, hp, wt)

mtcars_mutated <- mtcars_selected %>%
  mutate(power_to_weight = hp / wt)

mtcars_scaled <- mtcars_selected %>%
  mutate(across(c(mpg, hp, wt), ~ scale(.)[,1]))
head(mtcars_scaled)

# ___________________________________________________________



#Reading Data from a URL
url <- "https://raw.githubusercontent.com/abdullah-al-marjuc-talha/IDS-Fall-25-26/refs/heads/main/Class%20Work/Lab_4/cancer-risk-factors.csv"
dataset <- read.csv(url)
head(dataset)

library(ggplot2)
ggplot(dataset, aes(x = BMI, y = Overall_Risk_Score  )) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "BMI vs Overall Risk Score  ", x = "BMI", y = "Overall Risk Score")

ggplot(dataset, aes(y = Physical_Activity_Level)) +
  geom_boxplot(fill = "tomato") +
  labs(title = "Boxplot of Physical_Activity_Level", y = "Physical_Activity_Level")

library(GGally)
ggcorr(dataset, label = TRUE)

# --- Handling Missing Values ---

# Check how many NA values are in each column
colSums(is.na(dataset))

library(dplyr)

dataset_cleaned <- dataset[!duplicated(dataset), ]

dataset_filtre <- dataset %>%
  filter(Age > 60)

dataset_selectionne <- dataset %>%
  select(Patient_ID, Age, Cancer_Type, Risk_Level)

dataset_nouveau <- dataset %>%
  mutate(
    BMI_to_PAL_Ratio = if_else(Physical_Activity_Level == 0, NA_real_, BMI / Physical_Activity_Level)
  )

dataset_normalise <- dataset_nouveau %>% mutate(across(c(Age, BMI, Overall_Risk_Score), ~ (. - min(., na.rm = TRUE)) / (max(., na.rm = TRUE) - min(., na.rm = TRUE)), .names = "{.col}_minmax"))
