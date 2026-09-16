# =====================================================================
# Figure 5: Active Sensor Photosites Across 10 Digit Classes (Sub-RQ5) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

nmnist_data$digit_class_factor <- as.factor(nmnist_data$digit_class)

# Alternating light and dark gray shades to make adjacent boxplots distinguishable in B&W
bw_palette_10 <- rep(c("gray92", "gray65"), 5)

cat("Generating Figure 5: Active Pixels Across 10 Digit Classes...\n")
png("figures/fig5_active_pixels_by_digit.png", width = 2800, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

boxplot(active_pixels ~ digit_class_factor, 
        data = nmnist_data,
        col = bw_palette_10,
        border = "black",
        main = "Figure 5: Active Sensor Photosites Utilized Across Digit Classes",
        xlab = "Digit Class (0 - 9, n = 30 each)",
        ylab = "Unique Active Pixels",
        cex.main = 1.2, cex.lab = 1.0)

means_pixels <- tapply(nmnist_data$active_pixels, nmnist_data$digit_class_factor, mean)

# White-filled black diamonds for prominent visibility over any gray box fill
points(1:10, means_pixels, pch = 23, bg = "black", col = "white", cex = 1.8, lwd = 1.5)

legend("topright", legend = "Class Mean", pch = 23, pt.bg = "black", col = "white", pt.cex = 1.5, bty = "n")
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig5_active_pixels_by_digit.png\n")
