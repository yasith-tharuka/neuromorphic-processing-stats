# =====================================================================
# Figure 1: Distribution of Processing Latency (Sub-RQ1) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 1: Distribution of Processing Latency...\n")
png("figures/fig1_latency_distribution.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

# Use shading lines (density & angle) for histogram bars to enhance grayscale distinction
h <- hist(nmnist_data$latency_us / 1000, 
          breaks = 25, 
          col = "gray40", 
          density = 25,
          angle = 45,
          border = "black",
          main = "Figure 1: Distribution of Event Processing Latency", 
          xlab = "Processing Latency (milliseconds)", 
          ylab = "Frequency",
          cex.main = 1.2, cex.lab = 1.0)

# Dashed line with square point vs solid line with circle point
abline(v = 306, col = "black", lwd = 2.5, lty = 2)
abline(v = mean(nmnist_data$latency_us) / 1000, col = "black", lwd = 2.5, lty = 1)

legend("topright", 
       legend = c("Nominal Benchmark (306.0 ms)", "Sample Mean (306.05 ms)"),
       col = c("black", "black"), 
       lty = c(2, 1), 
       lwd = 2.5, 
       bty = "n")

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig1_latency_distribution.png\n")
