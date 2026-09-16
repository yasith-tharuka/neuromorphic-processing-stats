# =====================================================================
# Figure 16: Distribution of Maximum Inter-Spike Interval (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 16: Histogram of Maximum Inter-Spike Interval...\n")
png("figures/fig16_max_isi_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

hist(nmnist_data$max_isi_us / 1000, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 16: Frequency Distribution of Maximum Inter-Spike Interval", 
     xlab = "Maximum Inter-Spike Interval (milliseconds)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig16_max_isi_hist.png\n")
