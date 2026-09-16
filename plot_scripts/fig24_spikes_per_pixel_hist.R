# =====================================================================
# Figure 24: Distribution of Spikes per Pixel (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 24: Histogram of Spikes Per Pixel...\n")
png("figures/fig24_spikes_per_pixel_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

hist(nmnist_data$spikes_per_pixel, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 24: Frequency Distribution of Spikes per Pixel", 
     xlab = "Spikes per Pixel (events / active pixel)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig24_spikes_per_pixel_hist.png\n")
