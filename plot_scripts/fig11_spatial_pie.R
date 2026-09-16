# Figure 11: Spatial Size Class Distribution (Descriptive) - B&W / Print-Optimized

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

area_med <- median(nmnist_data$active_pixels)
# Use >= to correctly classify records at the median boundary (max = median = 1089 in DVS 34x34 frame)
nmnist_data$spatial_size_class <- as.factor(ifelse(nmnist_data$active_pixels >= area_med, "Large", "Small"))

png("figures/fig11_spatial_pie.png", width = 2200, height = 1800, res = 300)
par(mar = c(2, 2, 3, 2))
spatial_tbl <- table(nmnist_data$spatial_size_class)
pie(spatial_tbl, 
    col = c("gray40", "gray90"),
    density = c(30, NA),
    angle = c(45, 0),
    labels = paste0(names(spatial_tbl), " Footprint\n", spatial_tbl, " digits (", round(100 * prop.table(spatial_tbl), 1), "%)"),
    main = "Figure 11: Spatial Size Class Distribution (N = 300)",
    cex.main = 1.2, cex = 1.0)
dev.off()

cat("Successfully generated figures/fig11_spatial_pie.png\n")
