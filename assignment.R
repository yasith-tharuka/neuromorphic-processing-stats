# =====================================================================
# IT1212 Probability and Statistics
# Statistical Characterization of N-MNIST Neuromorphic Spiking Data
# =====================================================================

# 1. Load the Dataset
nmnist_data <- read.csv("nmnist_features.csv")

# =====================================================================
# 2. Feature Engineering: Deriving 4 Categorical Features
# =====================================================================

# Derived Feature 1: Polarity Majority
nmnist_data$polarity_majority <- ifelse(nmnist_data$on_ratio > 0.5, "ON-dominant", "OFF-dominant")

# Derived Feature 2: Latency Speed
latency_median <- median(nmnist_data$latency_us)
nmnist_data$latency_speed <- ifelse(nmnist_data$latency_us > latency_median, "Slow", "Fast")

# Derived Feature 3: Density Category
density_median <- median(nmnist_data$spike_density)
nmnist_data$density_category <- ifelse(nmnist_data$spike_density > density_median, "High", "Low")

# Derived Feature 4: Spatial Size Class
size_median <- median(nmnist_data$bounding_area)
nmnist_data$spatial_size_class <- ifelse(nmnist_data$bounding_area > size_median, "Large", "Small")

# Ensure digit_class is treated as categorical
nmnist_data$digit_class <- as.factor(nmnist_data$digit_class)

# =====================================================================
# 3. Descriptive Statistics (All 22 Features)
# =====================================================================

# Output the high-level summary of every single column
print("--- Full Dataset Descriptive Statistics ---")
summary(nmnist_data)

# Print specific standard deviations for your report tables
cat("Standard Deviation of Latency (us):", sd(nmnist_data$latency_us), "\n")
cat("Standard Deviation of Spike Density:", sd(nmnist_data$spike_density), "\n")
cat("Standard Deviation of Bounding Area:", sd(nmnist_data$bounding_area), "\n")

# =====================================================================
# 4. Data Visualization 
# =====================================================================

# Histogram 1: Processing Latency
hist(nmnist_data$latency_us, 
     main = "Distribution of Event Processing Latency", 
     xlab = "Latency (microseconds)", 
     col = "steelblue", 
     breaks = 20)

# Histogram 2: Spatial Footprint
# hist(nmnist_data$bounding_area, 
     main = "Distribution of Active Spatial Area", 
     xlab = "Bounding Box Area (pixels squared)", 
     col = "darkorange", 
     breaks = 20)

# Bar Chart 1: Polarity Dominance
barplot(table(nmnist_data$polarity_majority), 
        main = "Event Polarity Dominance", 
        col = c("darkred", "darkgreen"),
        ylab = "Frequency")

# =====================================================================
# 5. Inferential Statistics: One-Sample t-test
# =====================================================================
# Research Question 1: Does the mean latency fall below 150,000 us?
# H0: mu >= 150000 | H1: mu < 150000

t_test_latency <- t.test(nmnist_data$latency_us, mu = 150000, alternative = "less")
print("--- One-Sample T-Test Result ---")
print(t_test_latency)

# =====================================================================
# 6. Inferential Statistics: Chi-Square Test of Independence
# =====================================================================
# Research Question 2: Is Event Density independent of Digit Class?
# Using simulate.p.value to avoid approximation errors

contingency_density_digit <- table(nmnist_data$digit_class, nmnist_data$density_category)
chi_sq_result <- chisq.test(contingency_density_digit, simulate.p.value = TRUE, B = 10000)

print("--- Chi-Square Contingency Table ---")
print(contingency_density_digit)
print("--- Chi-Square Test Result ---")
print(chi_sq_result)