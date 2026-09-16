# IT1212 Probability and Statistics
# Statistical Characterization of N-MNIST Neuromorphic Spiking Data

# 1. Load the Dataset
nmnist_data <- read.csv("nmnist_features.csv")

# 2. Feature Engineering: Deriving 4 Categorical Features

# Derived Feature 1: Polarity Majority
nmnist_data$polarity_majority <- ifelse(nmnist_data$on_ratio > 0.5, "ON-dominant", "OFF-dominant")

# Derived Feature 2: Latency Speed
latency_median <- median(nmnist_data$latency_us)
nmnist_data$latency_speed <- ifelse(nmnist_data$latency_us > latency_median, "Slow", "Fast")

# Derived Feature 3: Density Category
density_median <- median(nmnist_data$spike_density)
nmnist_data$density_category <- ifelse(nmnist_data$spike_density > density_median, "High", "Low")

# Derived Feature 4: Spatial Size Class (>= median to correctly handle max=median boundary)
size_median <- median(nmnist_data$active_pixels)
nmnist_data$spatial_size_class <- ifelse(nmnist_data$active_pixels >= size_median, "Large", "Small")

# Ensure digit_class is treated as categorical
nmnist_data$digit_class <- as.factor(nmnist_data$digit_class)

# 3. Descriptive Statistics
summary(nmnist_data)
cat("Standard Deviation of Latency (us):", sd(nmnist_data$latency_us), "\n")
cat("Standard Deviation of Spike Density:", sd(nmnist_data$spike_density), "\n")
cat("Standard Deviation of Bounding Area:", sd(nmnist_data$bounding_area), "\n")

# 4. Data Visualization

# Histogram: Processing Latency
hist(nmnist_data$latency_us, 
     main = "Distribution of Event Processing Latency", 
     xlab = "Latency (microseconds)", 
     col = "steelblue", 
     breaks = 20)

# Bar Chart: Polarity Dominance
barplot(table(nmnist_data$polarity_majority), 
        main = "Event Polarity Dominance", 
        col = c("darkred", "darkgreen"),
        ylab = "Frequency")

# 5. Inferential Statistics: One-Sample t-test
# H0: mu = 306000 | H1: mu != 306000
t_test_latency <- t.test(nmnist_data$latency_us, mu = 306000)
print(t_test_latency)

# 6. Inferential Statistics: Chi-Square Test of Independence
# H0: Digit class and density category are independent
# Monte Carlo simulation used due to zero-count cells in contingency table
contingency_density_digit <- table(nmnist_data$digit_class, nmnist_data$density_category)
chi_sq_result <- chisq.test(contingency_density_digit, simulate.p.value = TRUE, B = 10000)
print(contingency_density_digit)
print(chi_sq_result)