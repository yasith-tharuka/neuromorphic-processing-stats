# =====================================================================
# Figure 23: 2D Spatial Centroid Distribution (Center of Mass X vs Y) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 23: 2D Center of Mass Scatter Plot...\n")
png("figures/fig23_com_scatter.png", width = 2400, height = 2400, res = 300)
par(mar = c(5, 5, 4, 2))

plot(nmnist_data$center_of_mass_x, nmnist_data$center_of_mass_y,
     pch = 19, col = adjustcolor("black", alpha.f = 0.5), cex = 0.8,
     xlim = c(14, 19), ylim = c(14, 19),
     main = "Figure 23: 2D Spatial Centroid Distribution on DVS Sensor Grid",
     xlab = "Horizontal Center of Mass X (pixels)",
     ylab = "Vertical Center of Mass Y (pixels)",
     cex.main = 1.2, cex.lab = 1.0)

# Add reference lines for sensor field-of-view center (16.5, 16.5)
abline(v = 16.5, col = "black", lty = 2, lwd = 1.5)
abline(h = 16.5, col = "black", lty = 2, lwd = 1.5)

legend("topright", 
       legend = c("Digit Centroids (n = 300)", "Sensor Frame Center (16.5, 16.5)"),
       pch = c(19, NA),
       lty = c(NA, 2),
       col = c("black", "black"),
       bty = "n", cex = 0.9)

grid(col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig23_com_scatter.png\n")
