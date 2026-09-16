# =====================================================================
# Figure 15: Distribution of Mean Inter-Spike Interval (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 15: Histogram of Mean Inter-Spike Interval...\n")
png("figures/fig15_mean_isi_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

hist(nmnist_data$mean_isi_us, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 15: Frequency Distribution of Mean Inter-Spike Interval", 
     xlab = "Mean Inter-Spike Interval (microseconds)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig15_mean_isi_hist.png\n")
