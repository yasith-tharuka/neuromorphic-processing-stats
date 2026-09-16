# =====================================================================
# Figure 17: Distribution of Spatial Width (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 17: Histogram of Spatial Width...\n")
png("figures/fig17_spatial_width_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

hist(nmnist_data$spatial_width, 
     breaks = seq(30.5, 33.5, by = 0.5), 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 17: Frequency Distribution of Spatial Width", 
     xlab = "Spatial Width (pixels)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig17_spatial_width_hist.png\n")
