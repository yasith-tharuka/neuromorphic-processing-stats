# =====================================================================
# Figure 12: Distribution of Spike Count (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 12: Histogram of Spike Count...\n")
png("figures/fig12_spike_count_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

h <- hist(nmnist_data$spike_count, 
          breaks = 25, 
          col = "gray40", 
          density = 25,
          angle = 45,
          border = "black",
          main = "Figure 12: Frequency Distribution of Total Spike Count", 
          xlab = "Total Spike Count (events)", 
          ylab = "Frequency",
          cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig12_spike_count_hist.png\n")
