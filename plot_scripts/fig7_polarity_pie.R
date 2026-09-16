# =====================================================================
# Figure 7: Polarity Dominance Distribution (Descriptive) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

nmnist_data$polarity_majority <- as.factor(ifelse(nmnist_data$on_ratio > 0.5, "ON-dominant", "OFF-dominant"))

cat("Generating Figure 7: Polarity Dominance Pie Chart...\n")
png("figures/fig7_polarity_pie.png", width = 2200, height = 1800, res = 300)
par(mar = c(2, 2, 3, 2))

pol_tbl <- table(nmnist_data$polarity_majority)

# High contrast grayscale fill with hatch lines for non-ambiguous pie slices in B&W
pie(pol_tbl, 
    col = c("gray40", "gray90"),
    density = c(30, NA),
    angle = c(45, 0),
    labels = paste0(names(pol_tbl), "\n", pol_tbl, " digits (", round(100 * prop.table(pol_tbl), 1), "%)"),
    main = "Figure 7: Event Polarity Dominance Distribution (N = 300)",
    cex.main = 1.2, cex = 1.0)

dev.off()

cat("Successfully generated figures/fig7_polarity_pie.png\n")
