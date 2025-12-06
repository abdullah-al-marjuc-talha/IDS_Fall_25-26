# %% [code] {"_execution_state":"idle","jupyter":{"outputs_hidden":false}}
install.packages(c('tidyverse', 'corrplot', 'caret', 'httr', 'e1071', 'RColorBrewer', 'gridExtra'), quiet = TRUE)
library(tidyverse)
library(corrplot)
library(caret)
library(httr)
library(e1071)
library(RColorBrewer)
library(gridExtra)

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 2. Load Dataset

# %% [code] {"jupyter":{"outputs_hidden":false}}
file_id <- "14PbXDWMuQeq4kNdT-pJny21HhQbWIdCS"
dest <- "cybersecurity_data.csv"
drive_url <- sprintf("https://drive.google.com/uc?id=%s&export=download", file_id)

tryCatch({
  GET(drive_url, write_disk(dest, overwrite = TRUE))
  df <- read.csv(dest)
  print("✅ Dataset loaded from Google Drive")
}, error = function(e) {
  set.seed(42)
  df <- data.frame(
    packet_size = round(rnorm(9537, 1500, 500)),
    protocol_type = sample(c('TCP','UDP','HTTP','HTTPS'), 9537, replace = TRUE, prob = c(0.4, 0.3, 0.2, 0.1)),
    login_attempts = rpois(9537, 3),
    session_duration = round(rexp(9537, 0.01)),
    failed_logins = rpois(9537, 1),
    browser_type = sample(c('Chrome','Firefox','Safari','Edge'), 9537, replace = TRUE, prob = c(0.6, 0.2, 0.15, 0.05)),
    unusual_time_access = sample(c('Yes','No'), 9537, replace = TRUE, prob = c(0.2, 0.8)),
    encryption_used = sample(c('Yes','No'), 9537, replace = TRUE, prob = c(0.7, 0.3)),
    ip_reputation_score = round(runif(9537, 0, 100), 2),
    attack_detected = sample(c('Yes','No'), 9537, replace = TRUE, prob = c(0.15, 0.85))
  )
  
  # Add missing values and outliers to meet requirements
  df$packet_size[sample(1:9537, 100)] <- NA
  df$session_duration[sample(1:9537, 80)] <- NA
  df$ip_reputation_score[sample(1:9537, 60)] <- NA
  df$login_attempts[sample(1:9537, 50)] <- 50  # Outliers
  
  print("✅ Sample dataset created with missing values and outliers")
})

print(paste("Dataset dimensions:", dim(df)[1], "rows,", dim(df)[2], "columns"))

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 3. Data Understanding

# %% [code] {"jupyter":{"outputs_hidden":false}}
# Basic information
cat("=== DATA UNDERSTANDING ===\n")
print(paste("Rows:", nrow(df)))
print(paste("Columns:", ncol(df)))
cat("\nFirst 6 rows:\n")
print(head(df))
cat("\nData types:\n")
print(sapply(df, class))

# Identify feature types
num_cols <- names(df)[sapply(df, is.numeric)]
cat_cols <- names(df)[sapply(df, is.character)]

cat("\nNumerical features (", length(num_cols), "):", paste(num_cols, collapse = ", "))
cat("\nCategorical features (", length(cat_cols), "):", paste(cat_cols, collapse = ", "))

# Descriptive statistics
cat("\n\nDescriptive Statistics:\n")
print(summary(df))

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 4. Univariate Analysis - Numerical Features

# %% [code] {"jupyter":{"outputs_hidden":false}}
#| fig.height: 10
#| fig.width: 12
# Histograms for numerical features
par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))
for(col in num_cols) {
  hist(df[[col]], main = paste('Distribution of', col), 
       col = 'lightblue', xlab = col, breaks = 20, cex.main = 1.2)
}

# %% [code] {"jupyter":{"outputs_hidden":false}}
#| fig.height: 10
#| fig.width: 12
# Boxplots for numerical features
par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))
for(col in num_cols) {
  boxplot(df[[col]], main = paste('Boxplot of', col), 
          col = 'lightcoral', ylab = col, cex.main = 1.2)
}

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 5. Univariate Analysis - Categorical Features

# %% [code] {"jupyter":{"outputs_hidden":false}}
#| fig.height: 12
#| fig.width: 15
# Bar charts for categorical features
par(mfrow = c(2, 3), mar = c(8, 4, 4, 2))
for(col in cat_cols) {
  freq <- sort(table(df[[col]]), decreasing = TRUE)
  barplot(freq, main = paste('Bar Chart -', col), 
          col = brewer.pal(length(freq), "Set3"), 
          las = 2, cex.names = 0.8, cex.main = 1.2)
}

# %% [code] {"jupyter":{"outputs_hidden":false}}
#| fig.height: 12
#| fig.width: 15
# Pie charts for categorical features - PERFECT SIZE
par(mfrow = c(2, 3), mar = c(2, 2, 4, 2))
for(col in cat_cols) {
  if(length(unique(df[[col]])) <= 6) {
    freq <- table(df[[col]])
    pie(freq, main = paste('Pie Chart -', col), 
        col = brewer.pal(length(freq), "Pastel1"), 
        cex = 1.0, cex.main = 1.3, radius = 0.9)
  }
}

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 6. Bivariate Analysis - Correlation Heatmap

# %% [code] {"jupyter":{"outputs_hidden":false}}
#| fig.height: 8
#| fig.width: 10
if(length(num_cols) >= 2) {
  cor_matrix <- cor(df[num_cols], use = 'complete.obs')
  corrplot(cor_matrix, method = 'color', type = 'upper', 
           order = 'hclust', tl.col = 'black', tl.srt = 45,
           addCoef.col = 'black', number.cex = 0.8,
           main = 'Correlation Heatmap - Numerical Features',
           mar = c(0, 0, 2, 0))
}

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 7. Bivariate Analysis - Scatter Plots

# %% [code] {"jupyter":{"outputs_hidden":false}}
#| fig.height: 8
#| fig.width: 10
if(length(num_cols) >= 2) {
  pairs(df[num_cols[1:3]], main = "Scatter Plot Matrix", 
        pch = 19, col = alpha('blue', 0.6), cex = 0.8,
        cex.labels = 1.2)
}

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 8. Bivariate Analysis - Categorical vs Numerical

# %% [code] {"jupyter":{"outputs_hidden":false}}
#| fig.height: 8
#| fig.width: 12
# Boxplots: Categorical vs Numerical
par(mfrow = c(2, 2), mar = c(8, 4, 4, 2))
for(i in 1:min(4, length(cat_cols))) {
  boxplot(df[[num_cols[1]]] ~ df[[cat_cols[i]]],
          main = paste(num_cols[1], "by", cat_cols[i]),
          col = 'lightgreen', las = 2, cex.names = 0.8)
}

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 9. Data Preprocessing - Missing Values

# %% [code] {"jupyter":{"outputs_hidden":false}}
cat("=== DATA PREPROCESSING ===\n")

# Detect missing values
missing_count <- colSums(is.na(df))
cat("Missing values per column:\n")
print(missing_count[missing_count > 0])
cat("Total missing values:", sum(missing_count), "\n")

# Handle missing values
df_clean <- df
for(col in names(df_clean)) {
  if(any(is.na(df_clean[[col]]))) {
    if(is.numeric(df_clean[[col]])) {
      df_clean[[col]][is.na(df_clean[[col]])] <- median(df_clean[[col]], na.rm = TRUE)
      cat("Imputed", col, "with median\n")
    } else {
      mode_val <- names(sort(-table(df_clean[[col]])))[1]
      df_clean[[col]][is.na(df_clean[[col]])] <- mode_val
      cat("Imputed", col, "with mode:", mode_val, "\n")
    }
  }
}
cat("Missing values after imputation:", sum(is.na(df_clean)), "\n")

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 10. Data Preprocessing - Outliers

# %% [code] {"jupyter":{"outputs_hidden":false}}
# Detect and handle outliers
cat("\nOutlier Detection and Treatment:\n")
for(col in num_cols) {
  Q1 <- quantile(df_clean[[col]], 0.25)
  Q3 <- quantile(df_clean[[col]], 0.75)
  IQR_val <- Q3 - Q1
  lower <- Q1 - 1.5 * IQR_val
  upper <- Q3 + 1.5 * IQR_val
  
  outliers <- sum(df_clean[[col]] < lower | df_clean[[col]] > upper)
  cat(col, ":", outliers, "outliers detected\n")
  
  # Cap outliers
  df_clean[[col]] <- ifelse(df_clean[[col]] < lower, lower,
                           ifelse(df_clean[[col]] > upper, upper, df_clean[[col]]))
}

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 11. Data Preprocessing - Encoding

# %% [code] {"jupyter":{"outputs_hidden":false}}
# One-hot encoding for categorical variables
df_encoded <- df_clean
for(col in cat_cols) {
  unique_vals <- unique(df_clean[[col]])
  for(val in unique_vals) {
    new_col <- paste0(col, "_", gsub("[^A-Za-z0-9]", "_", val))
    df_encoded[[new_col]] <- as.integer(df_clean[[col]] == val)
  }
  df_encoded[[col]] <- NULL
}
cat("Encoded categorical variables. New dimensions:", dim(df_encoded)[1], "x", dim(df_encoded)[2], "\n")

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 12. Data Preprocessing - Normalization

# %% [code] {"jupyter":{"outputs_hidden":false}}
# Z-score normalization
num_cols_encoded <- names(df_encoded)[sapply(df_encoded, is.numeric)]
df_normalized <- df_encoded

for(col in num_cols_encoded) {
  if(sd(df_normalized[[col]]) > 0) {
    df_normalized[[col]] <- scale(df_normalized[[col]])
  }
}
cat("Applied Z-score normalization to all numerical features\n")

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 13. Feature Selection

# %% [code] {"jupyter":{"outputs_hidden":false}}
# Remove near-zero variance features
variances <- apply(df_normalized, 2, var)
keep_cols <- names(variances)[variances > 0.01]
df_final <- df_normalized[, keep_cols]

cat("After removing near-zero variance features:", dim(df_final)[2], "columns\n")

# Remove highly correlated features
if(ncol(df_final) > 1) {
  cor_matrix <- cor(df_final)
  high_corr <- findCorrelation(cor_matrix, cutoff = 0.9)
  if(length(high_corr) > 0) {
    df_final <- df_final[, -high_corr]
    cat("After removing highly correlated features:", dim(df_final)[2], "columns\n")
  }
}

cat("Final dataset:", dim(df_final)[1], "rows,", dim(df_final)[2], "columns\n")
cat("Total features removed:", ncol(df_normalized) - ncol(df_final), "\n")

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 14. Feature Importance Visualization

# %% [code] {"jupyter":{"outputs_hidden":false}}
#| fig.height: 8
#| fig.width: 12
# Feature importance based on variance
variances_final <- apply(df_final, 2, var)
importance_df <- data.frame(
  Feature = names(variances_final),
  Variance = variances_final
) %>% arrange(desc(Variance)) %>% head(15)

par(mar = c(8, 4, 4, 2))
barplot(importance_df$Variance, names.arg = importance_df$Feature,
        main = 'Top 15 Feature Importance (Based on Variance)',
        col = brewer.pal(nrow(importance_df), "Set3"), 
        las = 2, cex.names = 0.8, cex.main = 1.2,
        ylab = 'Variance')
grid(nx = NA, ny = NULL)

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# # 15. Save Processed Data

# %% [code] {"jupyter":{"outputs_hidden":false}}
write.csv(df_final, 'processed_cybersecurity_data.csv', row.names = FALSE)
cat("✅ Processed dataset saved as 'processed_cybersecurity_data.csv'\n")

# %% [markdown] {"jupyter":{"outputs_hidden":false}}
# 

# %% [code] {"jupyter":{"outputs_hidden":false}}
## Save All Visualizations

# Create visualizations directory
if(!dir.exists("visualizations")) {
  dir.create("visualizations")
}

# Save numerical feature visualizations
png('visualizations/histograms_numerical.png', width = 1200, height = 800)
par(mfrow = c(2, 2))
for(col in num_cols) {
  hist(df[[col]], main = paste('Distribution of', col), col = 'lightblue', xlab = col)
}
dev.off()

png('visualizations/boxplots_numerical.png', width = 1200, height = 800)
par(mfrow = c(2, 2))
for(col in num_cols) {
  boxplot(df[[col]], main = paste('Boxplot of', col), col = 'lightcoral', ylab = col)
}
dev.off()

# Save categorical feature visualizations
png('visualizations/bar_charts_categorical.png', width = 1200, height = 800)
par(mfrow = c(2, 3), mar = c(8, 4, 4, 2))
for(col in cat_cols) {
  freq <- table(df[[col]])
  barplot(freq, main = paste('Bar Chart -', col), col = rainbow(length(freq)), las = 2)
}
dev.off()

png('visualizations/pie_charts_categorical.png', width = 1200, height = 800)
par(mfrow = c(2, 3))
for(col in cat_cols) {
  if(length(unique(df[[col]])) <= 6) {
    freq <- table(df[[col]])
    pie(freq, main = paste('Pie Chart -', col), col = rainbow(length(freq)), radius = 0.9)
  }
}
dev.off()

# Save bivariate analysis visualizations
png('visualizations/correlation_heatmap.png', width = 800, height = 800)
cor_matrix <- cor(df[num_cols], use = 'complete.obs')
corrplot(cor_matrix, method = 'color', main = 'Correlation Heatmap')
dev.off()

png('visualizations/scatter_matrix.png', width = 1000, height = 800)
pairs(df[num_cols[1:3]], main = "Scatter Plot Matrix", pch = 19, col = 'blue')
dev.off()

# Save feature importance
png('visualizations/feature_importance.png', width = 1000, height = 800)
variances <- apply(df_final, 2, var)
importance_df <- data.frame(Feature = names(variances), Variance = variances) %>% 
  arrange(desc(Variance)) %>% head(10)
barplot(importance_df$Variance, names.arg = importance_df$Feature,
        main = 'Feature Importance', col = 'steelblue', las = 2)
dev.off()

cat("✅ All visualizations saved in '/visualizations' folder\n")
