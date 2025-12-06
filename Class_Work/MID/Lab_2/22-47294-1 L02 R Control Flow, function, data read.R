#if Statement
x <- 10
if (x > 5) {
  print("x is greater than 5")
}

#if…else Statement
x <- 3
if (x > 5) {
  print("x is greater than 5")
} else {
  print("x is 5 or less")
}

#if…else if…else Ladder
score <- 75
if (score >= 90) {
  print("Grade A")
} else if (score >= 80) {
  print("Grade B")
} else if (score >= 70) {
  print("Grade C")
} else {
  print("Grade F")
}

#for Loop
for (i in 1:5) {
  print(paste("Iteration", i))
}

#repeat Loop (with break)
i <- 1
repeat {
  print(i)
  i <- i + 1
  if (i > 5) break
}

#next Statement (skip to next iteration)
for (i in 1:5) {
  if (i == 3) next
  print(i)
}

#break Statement (exit the loop)
for (i in 1:5) {
  if (i == 4) break
  print(i)
}

#mean()
numbers <- c(10, 20, 30, 40, 50)
mean(numbers)

sum(numbers)
length(numbers)

#round()
pi_val <- 3.14159
round(pi_val, 2)

paste("Hello", "Data", "Science")

#User-Defined Functions
#Simple function to add two numbers
add_numbers <- function(a, b) {
  return(a + b)
}

add_numbers(5, 3)

#Function to check if a number is even
is_even <- function(x) {
  if (x %% 2 == 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

is_even(4) 

#Function with default parameter
greet <- function(name = "Data Science") {
  paste("Hello", name)
}

greet()  

greet("Talha")   


#Anonymous (Lambda) Function with sapply()
numbers <- 1:5
squared <- sapply(numbers, function(x) x^2)
print(squared) 

#Data Read
#Reading a CSV File
data <- read.csv("D:/EDU/12th Semester/Data Science/country_full.csv")
head(data)  # View the first few rows

#Data Read
#Reading a CSV File
data <- read.csv("D:\\EDU\\12th Semester\\Data Science\\country_full.csv")
head(data) 


#Reading a Text File (tab-delimited)
data <- read.table("D:\\EDU\\12th Semester\\Data Science\\sample1.txt", header = TRUE, sep = "\t")
head(data)

#Reading Data from a URL
url <- "https://raw.githubusercontent.com/abdullah-al-marjuc-talha/IDS-Fall-25-26/refs/heads/main/Class%20Work/Lab_2/country_full.csv"
data <- read.csv(url)
head(data)

#Exercises:

#Exercise 1:

# Create a variable score with a numeric value between 0 and 100
score <- 85

# Write an if-else statement to print the appropriate message
if (score >= 90) {
  cat("Excellent\n")
} else if (score >= 75) {
  cat("Good\n")
} else if (score >= 50) {
  cat("Pass\n")
} else {
  cat("Fail\n")
}

#Exercise 2:

# Create a numeric vector from 1 to 10
numbers <- 1:10

# Use a for loop to print the square of each number
for (num in numbers) {
  square <- num^2
  print(square)
}

#Exercise 3:

count <- 1

# Use a while loop to print all even numbers less than 20
while (count < 20) {
  # Check if the number is even
  if (count %% 2 == 0) {
    print(count)
  }
  # Increment count
  count <- count + 1
}

#Exercise 4:

# Create a function multiply that takes two numbers and returns their product
multiply <- function(x, y) {
  product <- x * y
  return(product)
}

# Test the function with two numbers
result1 <- multiply(5, 3)
print(result1)  

result2 <- multiply(7, 4)
print(result2)  

result3 <- multiply(2.5, 6)
print(result3) 

print(multiply(10, 2))

#Exercise 5:

calculate_stats <- function(numbers) {
  # Calculate the statistics
  mean_val <- mean(numbers)
  median_val <- median(numbers)
  sd_val <- sd(numbers)
  
  # Return as a list
  stats_list <- list(
    mean = mean_val,
    median = median_val,
    standard_deviation = sd_val
  )
  
  return(stats_list)
}

# Basic test
test_vector1 <- c(10, 20, 30, 40, 50)
result1 <- calculate_stats(test_vector1)
print(result1)

#Exercise 6:

# Create a function grade_result that takes a numeric score and prints the grade
grade_result <- function(score) {
  if (score >= 90) {
    print("A")
  } else if (score >= 75) {
    print("B")
  } else if (score >= 50) {
    print("C")
  } else {
    print("F")
  }
}

# Test with different scores
grade_result(95)   
grade_result(85)   
grade_result(70)   
grade_result(45)   
grade_result(90)   
grade_result(75)   
grade_result(50)

#Exercise 7:

# Read the CSV file
students <- read.csv("D:\\EDU\\12th Semester\\Data Science\\students.csv")

# Display the first 5 rows
print("First 5 rows:")
print(head(students, 5))

# Display the structure of the dataset
print("Structure of the dataset:")
print(str(students))
