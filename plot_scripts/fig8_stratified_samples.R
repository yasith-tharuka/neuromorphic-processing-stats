# =====================================================================
# Figure 8: Population vs. Sample Stratified Distribution (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)

cat("Generating Figure 8: Population vs. Sample Stratified Distribution...\n")
png("figures/fig8_stratified_samples.png", width = 2800, height = 1800, res = 300)
par(mfrow = c(1, 2), mar = c(5, 5, 4, 2))

# Population distribution counts
pop_counts <- c(980, 1135, 1032, 1010, 982, 892, 958, 1028, 974, 1009)
digits <- 0:9

# Subplot A: Full Population (Uneven distribution, N = 10,000)
bp1 <- barplot(pop_counts, 
               names.arg = digits, 
               col = "gray85",
               density = 25,
               angle = 45,
               border = "black",
               ylim = c(0, 1300),
               main = "(A) Full N-MNIST Test Population (N = 10,000)",
               xlab = "Digit Class (0 - 9)", 
               ylab = "Population Frequency",
               cex.main = 1.0, cex.lab = 0.9)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
text(bp1, pop_counts + 40, labels = pop_counts, cex = 0.75, col = "black")

# Subplot B: Balanced Stratified Sample (Flat n = 30 per digit, N = 300)
sample_counts <- rep(30, 10)
bp2 <- barplot(sample_counts, 
               names.arg = digits, 
               col = "gray30", 
               border = "black",
               ylim = c(0, 40),
               main = "(B) Balanced Stratified Sample (n = 30 per digit, N = 300)",
               xlab = "Digit Class (0 - 9)", 
               ylab = "Sample Frequency (n)",
               cex.main = 1.0, cex.lab = 0.9)
abline(h = 30, col = "black", lty = 2, lwd = 2.5)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
text(bp2, sample_counts + 2, labels = "n=30", col = "black", font = 2, cex = 0.8)

dev.off()

cat("Successfully generated figures/fig8_stratified_samples.png\n")
