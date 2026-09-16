# =====================================================================
# Figure 25: Distribution of Raw ON Polarity Ratio (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 25: Histogram of ON Ratio...\n")
png("figures/fig25_on_ratio_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

hist(nmnist_data$on_ratio, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 25: Frequency Distribution of Raw ON Polarity Ratio", 
     xlab = "ON Polarity Ratio (proportion of total spikes)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig25_on_ratio_hist.png\n")
