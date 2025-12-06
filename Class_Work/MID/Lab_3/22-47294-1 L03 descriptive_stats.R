#Reading Data from a URL
url <- "https://raw.githubusercontent.com/abdullah-al-marjuc-talha/IDS-Fall-25-26/refs/heads/main/Class%20Work/Lab_3/dataset_data_science_student_marks.csv"
dataset <- read.csv(url)
head(dataset) #Shows the first 6 rows.

str(dataset) #Displays the structure of the dataset.

summary(dataset) #Provides a quick statistical summary of each variable.


# Calculate mean
mean(dataset$age)

# Calculate median
median(dataset$age)

# To find the mode, create a table of frequencies
freq_table <- table(dataset$age)
# Find the name of the most frequent value
names(freq_table)[which.max(freq_table)]


# Calculate the range
range_val <- range(dataset$age)
max(range_val) - min(range_val)

# Calculate variance
var(dataset$age)

# Calculate standard deviation
sd(dataset$age)

# Calculate the Interquartile Range
IQR(dataset$age)

# Get specific quantiles (e.g., 25th and 75th percentiles)
quantile(dataset$age, probs = c(0.25, 0.75))


#Step 4: Group-wise Descriptive Statistics
library(dplyr)

# Calculate mean, sd, and count for each location
dataset %>%
  group_by(location) %>%
  summarise(
    count = n(),
    mean_age = mean(age),
    sd_age = sd(age),
    mean_sql_marks = mean(sql_marks),
    sd_sql_marks = sd(sql_marks)
  )

#Multivariate Analysis

# --- Step 1: Make the plot with Outer Margins (oma) ---
# This creates empty space on the right side (the '15')
pairs(dataset[, c("sql_marks", "excel_marks", "python_marks", "power_bi_marks")], 
      main = "Scatterplot Matrix of data science student Dataset", 
      col = as.factor(dataset$location),
      pch = 19,  # Use solid dots (like the iris example often does)
      oma = c(3, 3, 3, 15)) # Make room for the legend

# --- Step 2: Add the legend to the new empty space ---
# Run this line immediately after the pairs() command
legend("right", 
       legend = unique(dataset$location), 
       fill = as.factor(unique(dataset$location)),
       bty = "n", # No box
       cex = 0.8) # Smaller text