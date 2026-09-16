# Comprehensive Statistical Analysis Script
# IT1212 Probability and Statistics
# N-MNIST Neuromorphic Dataset Analysis

# 1. Load Data
nmnist_data <- read.csv("nmnist_features.csv")

# 2. Derive 4 Categorical Features
lat_med  <- median(nmnist_data$latency_us)
den_med  <- median(nmnist_data$spike_density)
area_med <- median(nmnist_data$active_pixels)

nmnist_data$polarity_majority  <- as.factor(ifelse(nmnist_data$on_ratio > 0.5, "ON-dominant", "OFF-dominant"))
nmnist_data$latency_speed      <- as.factor(ifelse(nmnist_data$latency_us > lat_med, "Slow", "Fast"))
nmnist_data$density_category   <- as.factor(ifelse(nmnist_data$spike_density > den_med, "High", "Low"))
nmnist_data$spatial_size_class <- as.factor(ifelse(nmnist_data$active_pixels >= area_med, "Large", "Small"))
nmnist_data$digit_class_factor <- as.factor(nmnist_data$digit_class)

# RESEARCH QUESTION 1: Parametric One-Sample t-Test on Latency
# RQ1: Does the average processing delay of N-MNIST digits differ significantly from 306,000 microseconds?
# H0: mu = 306000  |  H1: mu != 306000
cat("=== RQ1: One-Sample t-test on Latency (mu = 306,000 us) ===\n")
t_test_rq1 <- t.test(nmnist_data$latency_us, mu = 306000)
print(t_test_rq1)

# RESEARCH QUESTION 2: Chi-Square Test of Independence (Digit Class vs Density)
# RQ2: Is event density classification independent of visual digit class?
# H0: Independent  |  H1: Dependent
# Note: Monte Carlo simulation used because zero-count cells in the 10x2 contingency table
# violate the expected-cell-count assumption (E_ij >= 5) required for asymptotic chi-square tests.
cat("\n=== RQ2: Chi-Square Test (digit_class vs density_category) ===\n")
t2 <- table(nmnist_data$digit_class_factor, nmnist_data$density_category)
print(t2)
chi_test_rq2 <- chisq.test(t2, simulate.p.value = TRUE, B = 10000)
print(chi_test_rq2)

# Effect Size: Cramer's V for RQ2 (10x2 contingency table)
# V = sqrt(chisq / (N * (min(r, c) - 1)))
cramers_v_rq2 <- sqrt(chi_test_rq2$statistic / (sum(t2) * (min(nrow(t2), ncol(t2)) - 1)))
cat("RQ2 Effect Size (Cramer's V):", round(cramers_v_rq2, 4), "\n")

# RESEARCH QUESTION 3: 2x2 Chi-Square Test (Spatial Footprint vs Speed)
# RQ3: Is physical spatial footprint size associated with latency speed?
# H0: Independent  |  H1: Dependent
cat("\n=== RQ3: 2x2 Chi-Square Test (spatial_size_class vs latency_speed) ===\n")
t3 <- table(nmnist_data$spatial_size_class, nmnist_data$latency_speed)
print(t3)
chi_test_rq3 <- chisq.test(t3)
print(chi_test_rq3)

# Effect Size: Cramer's V for RQ3 (2x2 table)
chi_uncorr_rq3 <- chisq.test(t3, correct = FALSE)$statistic
cramers_v_rq3 <- sqrt(chi_uncorr_rq3 / (sum(t3) * (min(nrow(t3), ncol(t3)) - 1)))
cat("RQ3 Effect Size (Cramer's V):", round(cramers_v_rq3, 4), "\n")

cat("\n--- RQ3 Robustness Check: Direct Pearson Correlation (Continuous) ---\n")
cor_rq3_robust <- cor.test(nmnist_data$bounding_area, nmnist_data$latency_us)
print(cor_rq3_robust)

# RESEARCH QUESTION 4: Two-Sample Independent t-Test (Spike Count by Polarity)
# RQ4: Does total spike count differ between ON-dominant and OFF-dominant streams?
# H0: mu_ON = mu_OFF  |  H1: mu_ON != mu_OFF
cat("\n=== RQ4: Two-Sample t-test (spike_count by polarity_majority) ===\n")
t_test_rq4 <- t.test(nmnist_data$spike_count ~ nmnist_data$polarity_majority)
print(t_test_rq4)

# Effect Size: Cohen's d for RQ4
off_spikes <- nmnist_data$spike_count[nmnist_data$polarity_majority == "OFF-dominant"]
on_spikes  <- nmnist_data$spike_count[nmnist_data$polarity_majority == "ON-dominant"]
n_off <- length(off_spikes); n_on <- length(on_spikes)
s_pooled <- sqrt(((n_off - 1) * sd(off_spikes)^2 + (n_on - 1) * sd(on_spikes)^2) / (n_off + n_on - 2))
cohens_d_rq4 <- (mean(off_spikes) - mean(on_spikes)) / s_pooled
cat("RQ4 Effect Size (Cohen's d):", round(cohens_d_rq4, 4), "\n")

# RESEARCH QUESTION 5: One-Way ANOVA (Active Pixels across Digits)
# RQ5: Does mean sensor pixel utilization differ across the 10 digit classes?
# H0: All mu_i are equal  |  H1: At least one mean differs
cat("\n=== RQ5: One-Way ANOVA (active_pixels across digit_class) ===\n")
fit_anova_rq5 <- aov(active_pixels ~ digit_class_factor, data = nmnist_data)
print(summary(fit_anova_rq5))

# Effect Size: Eta-squared (eta^2 = SS_between / SS_total)
aov_sum_rq5 <- summary(fit_anova_rq5)[[1]]
eta_sq_rq5  <- aov_sum_rq5["digit_class_factor", "Sum Sq"] / sum(aov_sum_rq5[, "Sum Sq"])
cat("RQ5 Effect Size (Eta-squared, eta^2):", round(eta_sq_rq5, 4), "\n")

cat("\n--- RQ5: Levene's Test for Homogeneity of Variance ---\n")
library(car)
lev_test_rq5 <- leveneTest(active_pixels ~ digit_class_factor, data = nmnist_data)
print(lev_test_rq5)

cat("\n--- RQ5 Robustness Check: Welch's Heteroscedastic ANOVA ---\n")
welch_anova_rq5 <- oneway.test(active_pixels ~ digit_class_factor, data = nmnist_data, var.equal = FALSE)
print(welch_anova_rq5)

cat("\n--- RQ5: Tukey HSD Post-Hoc Pairwise Comparisons ---\n")
tukey_rq5 <- TukeyHSD(fit_anova_rq5)
print(tukey_rq5)

# RESEARCH QUESTION 6: Pearson & Spearman Bivariate Correlation Analysis
# RQ6: How strongly do spike count, bounding area, ISI, and active pixels correlate?
# H0: rho = 0  |  H1: rho != 0
cat("\n=== RQ6: Pearson Correlation Matrix ===\n")
num_cols <- nmnist_data[, c("spike_count", "bounding_area", "mean_isi_us", "latency_us", "active_pixels", "spikes_per_pixel")]
cor_matrix <- cor(num_cols)
print(round(cor_matrix, 3))
