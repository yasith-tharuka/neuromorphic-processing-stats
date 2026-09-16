# =====================================================================
# Figure 9: Latency Speed Distribution (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

lat_med <- median(nmnist_data$latency_us)
nmnist_data$latency_speed <- as.factor(ifelse(nmnist_data$latency_us > lat_med, "Slow", "Fast"))

cat("Generating Figure 9: Latency Speed Pie Chart...\n")
png("figures/fig9_speed_pie.png", width = 2200, height = 1800, res = 300)
par(mar = c(2, 2, 3, 2))

speed_tbl <- table(nmnist_data$latency_speed)

# Matching style: High contrast grayscale fill with hatch lines for non-ambiguous pie slices in B&W
pie(speed_tbl, 
    col = c("gray40", "gray90"),
    density = c(30, NA),
    angle = c(45, 0),
    labels = paste0(names(speed_tbl), "\n", speed_tbl, " digits (", round(100 * prop.table(speed_tbl), 1), "%)"),
    main = "Figure 9: Latency Speed Category Distribution (N = 300)",
    cex.main = 1.2, cex = 1.0)

dev.off()

cat("Successfully generated figures/fig9_speed_pie.png\n")
