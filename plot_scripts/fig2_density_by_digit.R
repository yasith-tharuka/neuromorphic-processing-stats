# =====================================================================
# Figure 2: Spiking Event Density by Digit Class (Sub-RQ2) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

den_med <- median(nmnist_data$spike_density)
nmnist_data$density_category   <- as.factor(ifelse(nmnist_data$spike_density > den_med, "High", "Low"))
nmnist_data$digit_class_factor <- as.factor(nmnist_data$digit_class)

cat("Generating Figure 2: Spiking Density by Digit Class...\n")
png("figures/fig2_density_by_digit.png", width = 2600, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

t2 <- table(nmnist_data$density_category, nmnist_data$digit_class_factor)

# High contrast gray palette + hatch lines for clear B&W printing
barplot(t2, 
        beside = TRUE, 
        col = c("gray20", "gray80"),
        density = c(NA, 30),
        angle = c(0, 45),
        border = "black",
        main = "Figure 2: Spiking Event Density Classification Across Digit Classes",
        xlab = "Visual Digit Class (0 - 9)", 
        ylab = "Number of Digits (n = 30 each)",
        legend.text = c("High Density", "Low Density"),
        args.legend = list(x = "topright", bty = "n"),
        cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig2_density_by_digit.png\n")
