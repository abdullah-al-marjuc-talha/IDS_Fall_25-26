# Creating Different Types of Vectors
# Numeric Vector
num_vec <- c(1, 2, 3, 4, 5)
print(num_vec)

# Character Vector
char_vec <- c("Apple", "Banana", "Cherry")
print(char_vec)

# Logical Vector
log_vec <- c(TRUE, FALSE, TRUE, FALSE)
print(log_vec)

# Vector Operations
# Arithmetic Operations
vec1 <- c(2, 4, 6)
vec2 <- c(1, 3, 5)

sum_vec <- vec1 + vec2  # Element-wise addition
prod_vec <- vec1 * vec2 # Element-wise multiplication

print(sum_vec) 
print(prod_vec)

# Accessing Elements in a Vector
# Create a vector
num_vec <- c(10, 20, 30, 40, 50)

# Access elements using index (1-based index)
print(num_vec[2])
print(num_vec[3])

# Access multiple elements
print(num_vec[c(1, 3, 5)])

# Access elements using a condition
print(num_vec[num_vec > 25]) 

# Modifying a Vector
# Modify an element
num_vec[2] <- 100
print(num_vec)

# Append new elements
num_vec <- c(num_vec, 60, 70)
print(num_vec)

# Vector Functions
vec <- c(5, 10, 15, 20, 25)

# Length of the vector
print(length(vec)) 

# Sum of all elements
print(sum(vec))

# Mean (average) of elements
print(mean(vec)) 

# Sorting a vector
sorted_vec <- sort(vec, decreasing = TRUE)
print(sorted_vec)

# Sequence and Repetition in Vectors
# Sequence from 1 to 10
seq_vec <- seq(1, 10, by = 2)  # Steps of 2
print(seq_vec) 

# Repeat elements
rep_vec <- rep(c(1, 2, 3), times = 3)  # Repeat entire vector
print(rep_vec)

# Creating a 3x3 matrix (filled column-wise by default)
mat <- matrix(1:9, nrow = 3, ncol = 3)
print(mat)

# Filling a Matrix Row-Wise
mat <- matrix(1:9, nrow = 3, byrow = TRUE)
print(mat)

# Naming Rows and Columns
# Creating a matrix
mat <- matrix(1:9, nrow = 3)

# Assigning row and column names
rownames(mat) <- c("Row1", "Row2", "Row3")
colnames(mat) <- c("Col1", "Col2", "Col3")

print(mat)

# Accessing Elements in a Matrix
# Create a 3x3 matrix
mat <- matrix(1:9, nrow = 3)

# Access element at row 2, column 3
print(mat[2, 3]) 

# Access entire row 1
print(mat[1, ])

# Access entire column 2
print(mat[, 2]) 

# Matrix Arithmetic
mat1 <- matrix(1:4, nrow = 2)
mat2 <- matrix(5:8, nrow = 2)

# Matrix addition
sum_mat <- mat1 + mat2
print(sum_mat)

# Matrix multiplication (element-wise)
prod_mat <- mat1 * mat2
print(prod_mat)

# Matrix multiplication (dot product)
dot_prod_mat <- mat1 %*% mat2  # %*% for matrix multiplication
print(dot_prod_mat)

#Transpose and Inverse of a Matrix
# Transpose of a matrix
t_mat <- t(mat)
print(t_mat)

# Inverse of a matrix (for square matrices)
square_mat <- matrix(c(2, 3, 1, 4), nrow = 2)
inv_mat <- solve(square_mat)
print(inv_mat)

# Creating an array with dimensions (3x3x2)
arr <- array(1:18, dim = c(3, 3, 2))
print(arr)

# Accessing Elements in an Array
# Create a 3x3x2 array
arr <- array(1:18, dim = c(3, 3, 2))

# Access element at [2nd row, 3rd column, 1st layer]
print(arr[2, 3, 1])

# Access entire 2nd row from Layer 1
print(arr[2, , 1])

# Access entire 3rd column from Layer 2
print(arr[, 3, 2])

#Performing Operations on Arrays
# Creating two 3x3x2 arrays
arr1 <- array(1:18, dim = c(3, 3, 2))
arr2 <- array(19:36, dim = c(3, 3, 2))

# Element-wise addition
sum_arr <- arr1 + arr2
print(sum_arr)

# Element-wise multiplication
prod_arr <- arr1 * arr2
print(prod_arr)

# Applying Functions to Arrays
# Creating an array
arr <- array(1:18, dim = c(3, 3, 2))

# Sum of all elements in the array
print(sum(arr))

# Mean of all elements
print(mean(arr))

# Apply function to each row (margin = 1)
apply(arr, MARGIN = 1, FUN = sum)

# Apply function to each column (margin = 2)
apply(arr, MARGIN = 2, FUN = mean)

# Creating a simple data frame
df <- data.frame(
  ID = c(101, 102, 103, 104),
  Name = c("Alice", "Bob", "Charlie", "David"),
  Age = c(23, 25, 22, 24),
  Score = c(89.5, 76.0, 91.2, 88.8),
  Passed = c(TRUE, FALSE, TRUE, TRUE)
)

# Print the data frame
print(df)

# Accessing Elements in a Data Frame
# Access a single column
print(df$Name)

# Access a specific row (row 2)
print(df[2, ])

# Access a specific element (Row 3, Column "Score")
print(df[3, "Score"])

# Access multiple columns
print(df[, c("Name", "Score")])  

# Access multiple rows
print(df[1:2, ])

# Add a new column 'Grade'
df$Grade <- c("A", "B", "A+", "A-")
print(df)

# Filter students who passed
passed_students <- df[df$Passed == TRUE, ]
print(passed_students)


# Filter students with Score > 85
high_scorers <- df[df$Score > 85, ]
print(high_scorers)

# Sorting by Age (Ascending)
df_sorted <- df[order(df$Age), ]
print(df_sorted)


# Sorting by Score (Descending)
df_sorted_desc <- df[order(-df$Score), ]
print(df_sorted_desc)

# Changing a value (Changing Bob’s Score to 80)
df$Score[df$Name == "Bob"] <- 80
print(df)

# Renaming column names
colnames(df) <- c("Student_ID", "Student_Name", "Student_Age", "Exam_Score", "Passed_Exam", "Final_Grade")
print(df)

# Remove a column
df$Grade <- NULL
print(df)

# Remove a row (removing row 2)
df <- df[-2, ]
print(df)

# Get summary statistics
summary(df)

# Get structure of the data frame
str(df)

# Creating a list with different data types
my_list <- list(
  Name = "Alice",
  Age = 25,
  Scores = c(90, 85, 88),
  Passed = TRUE
)

# Print the list
print(my_list)

# Access by index
print(my_list[[1]])

# Access by name
print(my_list$Scores)

# Access specific elements within a list item
print(my_list$Scores[2])

# Change an element
my_list$Age <- 26
print(my_list$Age) 

# Add a new element
my_list$Country <- "USA"
print(my_list)

# Remove an element
my_list$Passed <- NULL
print(my_list)

# Creating a list with a matrix and a data frame
my_complex_list <- list(
  Numbers = c(1, 2, 3, 4),
  Matrix = matrix(1:9, nrow = 3),
  DataFrame = data.frame(ID = c(101, 102), Name = c("Bob", "Charlie"))
)

# Print the list
print(my_complex_list)

# Access elements inside the matrix
print(my_complex_list$Matrix[2, 3]) 

list1 <- list(A = 1:5, B = "Hello")
list2 <- list(C = c(TRUE, FALSE), D = matrix(1:4, nrow = 2))

# Merge lists
merged_list <- c(list1, list2)
print(merged_list)

# Convert list to data frame
list_to_df <- data.frame(
  Name = c("Alice", "Bob"),
  Age = c(25, 27),
  Score = c(89, 92)
)

print(list_to_df)



#Exercises

#Exercise 1:

# Create a numeric vector 'scores' with 8 random numbers between 50 and 100
scores <- sample(50:100, 8)

# Calculate statistics
min_score <- min(scores)
max_score <- max(scores)
mean_score <- mean(scores)
median_score <- median(scores)

# Print the results
print(scores)
print(paste("Minimum:", min_score))
print(paste("Maximum:", max_score))
print(paste("Mean:", mean_score))
print(paste("Median:", median_score))

# Create a character vector 'cities' with names of 5 cities
cities <- c("New York", "Tokyo", "Paris", "London", "Sydney")

# Print the cities
print(cities)


#Exercise 2:

# Create a list 'student_info'
student_info <- list(
  name = "John Doe",
  age = 20,
  grades = c(85, 90, 78)
)

# Extract the age from the list
student_age <- student_info$age

# Extract the second grade
second_grade <- student_info$grades[2]

# Print the results
print(paste("Age:", student_age))
print(paste("Second Grade:", second_grade))


#Exercise 3:

# Create a 4x4 matrix of numbers from 1 to 16
matrix_4x4 <- matrix(1:16, nrow = 4, byrow = TRUE)

# Print the matrix
print("4x4 Matrix:")
print(matrix_4x4)

# Extract the third row
third_row <- matrix_4x4[3, ]

# Extract the second column
second_column <- matrix_4x4[, 2]

# Calculate the sum of the diagonal elements
diagonal_sum <- sum(diag(matrix_4x4))

# Print the results
print("Third Row:")
print(third_row)
print("Second Column:")
print(second_column)
print(paste("Sum of Diagonal Elements:", diagonal_sum))

#Exercise 4:

# Create a data frame 'students'
students <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "David"),
  Math = c(85, 78, 92, 88),
  English = c(90, 82, 95, 87)
)

# Display the structure of the data frame
str(students)

# Extract the English scores column
english_scores <- students$English

# Add a new column 'Average' with the average of Math and English scores
students$Average <- rowMeans(students[, c("Math", "English")])

# Print the updated data frame
print(students)

#Exercise 5:

# Create a factor 'blood_group'
blood_group <- factor(c("A", "B", "O", "AB", "A", "O"))

# Display the levels of the factor
levels(blood_group)

# Count how many students belong to each blood group
blood_group_count <- table(blood_group)

# Print the counts
print(blood_group_count)

#Exercise 6:

# Create a data frame 'class'
class <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "David", "Eva"),
  Age = c(20, 21, 19, 22, 20),
  Gender = factor(c("Female", "Male", "Male", "Male", "Female")),
  Scores = I(list(c(85, 90, 78), c(70, 75, 80), c(92, 88, 95), c(60, 65, 70), c(88, 90, 92)))
)

# Calculate the average scores for each student
class$Average_Score <- sapply(class$Scores, mean)

# Extract the names of students with an average score greater than 80
high_achievers <- class$Name[class$Average_Score > 80]

# Count how many male and female students are in the class
gender_count <- table(class$Gender)

# Print the results
print("Students with an average score greater than 80:")
print(high_achievers)

print("Count of male and female students:")
print(gender_count)

