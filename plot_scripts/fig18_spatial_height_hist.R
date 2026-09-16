# =====================================================================
# Figure 18: Distribution of Spatial Height (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 18: Histogram of Spatial Height...\n")
png("figures/fig18_spatial_height_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

hist(nmnist_data$spatial_height, 
     breaks = seq(28.5, 33.5, by = 0.5), 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 18: Frequency Distribution of Spatial Height", 
     xlab = "Spatial Height (pixels)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig18_spatial_height_hist.png\n")
