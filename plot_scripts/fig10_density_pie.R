# =====================================================================
# Figure 10: Spiking Density Category Distribution (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

den_med <- median(nmnist_data$spike_density)
nmnist_data$density_category <- as.factor(ifelse(nmnist_data$spike_density > den_med, "High", "Low"))

cat("Generating Figure 10: Spiking Density Pie Chart...\n")
png("figures/fig10_density_pie.png", width = 2200, height = 1800, res = 300)
par(mar = c(2, 2, 3, 2))

den_tbl <- table(nmnist_data$density_category)

# High contrast grayscale fill with hatch lines for non-ambiguous pie slices in B&W
pie(den_tbl, 
    col = c("gray40", "gray90"),
    density = c(30, NA),
    angle = c(45, 0),
    labels = paste0(names(den_tbl), " Density\n", den_tbl, " digits (", round(100 * prop.table(den_tbl), 1), "%)"),
    main = "Figure 10: Spiking Density Category Distribution (N = 300)",
    cex.main = 1.2, cex = 1.0)

dev.off()

cat("Successfully generated figures/fig10_density_pie.png\n")
