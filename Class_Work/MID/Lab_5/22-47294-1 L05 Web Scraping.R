# Install the package if you don't have it
install.packages("rvest")

# Load the package
library(rvest)

# Define the URL of the page to scrape
url <- "https://www.imdb.com/chart/top/"

# Read the HTML from the URL
webpage <- read_html(url)

library(stringr)
# Extract the movie titles
# The selector points to h3 tags with the class 'ipc-title__text'
# We use [1:250] to get only the top 250 movie titles and not other text
titles_raw <- webpage %>%
  html_elements("h3.ipc-title_ _text") %>%
  html_text2()
titles <- titles_raw[2:26] # The first element is "IMDb Charts", so we skip it

# Extract the movie years
# This selector finds the metadata block and then selects the first span (the year)
years <- webpage %>%
  html_elements(".cli-title-metadata-item:nth-child(1)") %>%
  html_text2()

# Extract the ratings
# The selector finds the span containing the rating value
ratings <- webpage %>%
  html_elements(".ipc-rating-star--rating") %>%
  html_text2()

# Create a data frame
movies_df <- data.frame(
  Rank = 1:25,
  Title = titles,
  Year = as.integer(years), # Convert year to a number
  Rating = as.numeric(ratings) # Convert rating to a number
)

# Display the first few rows of the data frame
head(movies_df)