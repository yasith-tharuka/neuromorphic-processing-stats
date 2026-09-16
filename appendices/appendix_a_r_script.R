# =====================================================================
# APPENDIX A: COMPLETE R STATISTICAL ANALYSIS SCRIPT
# Module: IT1212 Probability and Statistics
# Dataset: N-MNIST Neuromorphic Spiking Data (N = 300)
# Description: The complete R script used for statistical analysis in this study.
# =====================================================================

# 1. Load Dataset
nmnist_data <- read.csv("nmnist_features.csv")

# 2. Feature Engineering (Categorical Derived Variables)
lat_med  <- median(nmnist_data$latency_us)
den_med  <- median(nmnist_data$spike_density)
area_med <- median(nmnist_data$active_pixels)

nmnist_data$polarity_majority  <- as.factor(ifelse(nmnist_data$on_ratio > 0.5, "ON-dominant", "OFF-dominant"))
nmnist_data$latency_speed      <- as.factor(ifelse(nmnist_data$latency_us > lat_med, "Slow", "Fast"))
nmnist_data$density_category   <- as.factor(ifelse(nmnist_data$spike_density > den_med, "High", "Low"))
nmnist_data$spatial_size_class <- as.factor(ifelse(nmnist_data$active_pixels > area_med, "Large", "Small"))
nmnist_data$digit_class_factor <- as.factor(nmnist_data$digit_class)

# Sub-RQ1: One-Sample t-Test on Processing Latency (mu = 306,000 us)
cat("=== Sub-RQ1: One-Sample t-test on Latency ===\n")
t_test_rq1 <- t.test(nmnist_data$latency_us, mu = 306000)
print(t_test_rq1)
cat("Standard Deviation:", sd(nmnist_data$latency_us), "\n\n")

# Sub-RQ2: Chi-Square Test of Independence (Digit Class vs Density Category)
cat("=== Sub-RQ2: Chi-Square Test of Independence ===\n")
tab_rq2 <- table(nmnist_data$digit_class_factor, nmnist_data$density_category)
print(tab_rq2)

# Monte Carlo simulation used due to zero-count cells in digits 0 and 1
chi_test_rq2 <- chisq.test(tab_rq2, simulate.p.value = TRUE, B = 10000)
print(chi_test_rq2)

# Effect Size: Cramer's V
cramers_v_rq2 <- sqrt(chi_test_rq2$statistic / (sum(tab_rq2) * (min(nrow(tab_rq2), ncol(tab_rq2)) - 1)))
cat("Sub-RQ2 Cramer's V:", round(cramers_v_rq2, 4), "\n\n")

# Sub-RQ3: 2x2 Chi-Square Test & Robustness Check (Spatial Size vs Latency Speed)
cat("=== Sub-RQ3: 2x2 Chi-Square Test ===\n")
tab_rq3 <- table(nmnist_data$spatial_size_class, nmnist_data$latency_speed)
print(tab_rq3)
chi_test_rq3 <- chisq.test(tab_rq3)
print(chi_test_rq3)

# Effect Size: Cramer's V
chi_uncorr_rq3 <- chisq.test(tab_rq3, correct = FALSE)$statistic
cramers_v_rq3 <- sqrt(chi_uncorr_rq3 / (sum(tab_rq3) * (min(nrow(tab_rq3), ncol(tab_rq3)) - 1)))
cat("Sub-RQ3 Cramer's V:", round(cramers_v_rq3, 4), "\n")

# Robustness Check: Direct Pearson Correlation on Continuous Variables
cat("--- Sub-RQ3 Robustness Check: Bounded Area vs Latency ---\n")
cor_rq3_robust <- cor.test(nmnist_data$bounding_area, nmnist_data$latency_us)
print(cor_rq3_robust)
cat("\n")

# Sub-RQ4: Welch Two-Sample Independent t-Test (Spike Count by Polarity)
cat("=== Sub-RQ4: Welch Two-Sample t-test ===\n")
t_test_rq4 <- t.test(nmnist_data$spike_count ~ nmnist_data$polarity_majority)
print(t_test_rq4)

# Group Standard Deviations and Cohen's d
off_spikes <- nmnist_data$spike_count[nmnist_data$polarity_majority == "OFF-dominant"]
on_spikes  <- nmnist_data$spike_count[nmnist_data$polarity_majority == "ON-dominant"]
cat("OFF-dominant SD:", sd(off_spikes), "\n")
cat("ON-dominant SD :", sd(on_spikes), "\n")

n_off <- length(off_spikes); n_on <- length(on_spikes)
s_pooled <- sqrt(((n_off - 1) * sd(off_spikes)^2 + (n_on - 1) * sd(on_spikes)^2) / (n_off + n_on - 2))
cohens_d_rq4 <- (mean(off_spikes) - mean(on_spikes)) / s_pooled
cat("Sub-RQ4 Cohen's d:", round(cohens_d_rq4, 4), "\n\n")

# Sub-RQ5: One-Way ANOVA & Post-Hoc Analysis (Active Pixels across Digits)
cat("=== Sub-RQ5: One-Way ANOVA ===\n")
fit_anova_rq5 <- aov(active_pixels ~ digit_class_factor, data = nmnist_data)
print(summary(fit_anova_rq5))

# Effect Size: Eta-squared (eta^2)
aov_sum_rq5 <- summary(fit_anova_rq5)[[1]]
eta_sq_rq5  <- aov_sum_rq5["digit_class_factor", "Sum Sq"] / sum(aov_sum_rq5[, "Sum Sq"])
cat("Sub-RQ5 Eta-squared (eta^2):", round(eta_sq_rq5, 4), "\n\n")

# Diagnostic Check: Levene's Test for Homogeneity of Variance
cat("--- Sub-RQ5: Levene's Test ---\n")
library(car)
lev_test_rq5 <- leveneTest(active_pixels ~ digit_class_factor, data = nmnist_data)
print(lev_test_rq5)

# Robustness Check: Welch's Heteroscedastic ANOVA
cat("\n--- Sub-RQ5 Robustness Check: Welch's ANOVA ---\n")
welch_anova_rq5 <- oneway.test(active_pixels ~ digit_class_factor, data = nmnist_data, var.equal = FALSE)
print(welch_anova_rq5)

# Post-Hoc Test: Tukey HSD (All 45 Pairwise Comparisons)
cat("\n--- Sub-RQ5: Full Tukey HSD Post-Hoc Test ---\n")
tukey_rq5 <- TukeyHSD(fit_anova_rq5)
print(tukey_rq5)
cat("\n")

# Sub-RQ6: Bivariate Pearson Correlation Matrix
cat("=== Sub-RQ6: Pearson Bivariate Correlation Matrix ===\n")
num_cols <- nmnist_data[, c("spike_count", "bounding_area", "mean_isi_us", "latency_us", "active_pixels", "spikes_per_pixel")]
cor_matrix <- cor(num_cols)
print(round(cor_matrix, 3))
