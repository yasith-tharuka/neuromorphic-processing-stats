# =====================================================================
# Figure 22: Distribution of Center of Mass Y (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 22: Histogram of Center of Mass Y...\n")
png("figures/fig22_com_y_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

hist(nmnist_data$center_of_mass_y, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 22: Frequency Distribution of Center of Mass (Y-Axis)", 
     xlab = "Vertical Center of Mass Y (pixel index)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig22_com_y_hist.png\n")
