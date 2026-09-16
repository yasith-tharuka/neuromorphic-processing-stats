# =====================================================================
# Figure 13: Distribution of Spike Density (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 13: Histogram of Spike Density...\n")
png("figures/fig13_spike_density_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

h <- hist(nmnist_data$spike_density, 
          breaks = 25, 
          col = "gray40", 
          density = 25,
          angle = 45,
          border = "black",
          main = "Figure 13: Frequency Distribution of Spiking Density", 
          xlab = "Spike Density (events / ms)", 
          ylab = "Frequency",
          cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig13_spike_density_hist.png\n")
