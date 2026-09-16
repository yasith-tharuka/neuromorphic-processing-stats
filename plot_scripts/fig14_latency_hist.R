# =====================================================================
# Figure 14: Distribution of Processing Latency (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 14: Histogram of Latency...\n")
png("figures/fig14_latency_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

hist(nmnist_data$latency_us / 1000, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 14: Frequency Distribution of Processing Latency", 
     xlab = "Processing Latency (milliseconds)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig14_latency_hist.png\n")
