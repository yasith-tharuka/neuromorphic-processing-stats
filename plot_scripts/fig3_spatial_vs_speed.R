# =====================================================================
# Figure 3: Spatial Footprint vs. Latency Speed Category (Sub-RQ3) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

lat_med  <- median(nmnist_data$latency_us)
area_med <- median(nmnist_data$active_pixels)

nmnist_data$latency_speed      <- as.factor(ifelse(nmnist_data$latency_us > lat_med, "Slow", "Fast"))
nmnist_data$spatial_size_class <- as.factor(ifelse(nmnist_data$active_pixels > area_med, "Large", "Small"))

cat("Generating Figure 3: Spatial Footprint vs Latency Speed...\n")
png("figures/fig3_spatial_vs_speed.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

t3 <- table(nmnist_data$latency_speed, nmnist_data$spatial_size_class)

# Contrast grayscale fill with pattern hatching
barplot(t3, 
        beside = TRUE, 
        col = c("gray25", "gray85"),
        density = c(NA, 35),
        angle = c(0, 135),
        border = "black",
        main = "Figure 3: Sensor Utilization Footprint vs. Latency Speed Category",
        xlab = "Active Sensor Size Class (Median Split)", 
        ylab = "Frequency",
        legend.text = c("Fast Processing", "Slow Processing"),
        args.legend = list(x = "topright", bty = "n"),
        cex.main = 1.2, cex.lab = 1.0)

grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig3_spatial_vs_speed.png\n")
