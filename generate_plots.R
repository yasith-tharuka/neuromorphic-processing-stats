# IT1212 Probability & Statistics - Assignment Figure Generation Script
# Generates publication-quality charts (PNG, 300 DPI) for assignment report
# Black & White / Grayscale Print-Optimized Version

# 1. Ensure output folder exists
dir.create("figures", showWarnings = FALSE)

# 2. Load and Prepare Dataset
nmnist_data <- read.csv("nmnist_features.csv")

lat_med <- median(nmnist_data$latency_us)
den_med <- median(nmnist_data$spike_density)
area_med <- median(nmnist_data$active_pixels)

nmnist_data$polarity_majority <- as.factor(ifelse(nmnist_data$on_ratio > 0.5, "ON-dominant", "OFF-dominant"))
nmnist_data$latency_speed <- as.factor(ifelse(nmnist_data$latency_us > lat_med, "Slow", "Fast"))
nmnist_data$density_category <- as.factor(ifelse(nmnist_data$spike_density > den_med, "High", "Low"))
nmnist_data$spatial_size_class <- as.factor(ifelse(nmnist_data$active_pixels >= area_med, "Large", "Small"))
nmnist_data$digit_class_factor <- as.factor(nmnist_data$digit_class)

# Figure 1: Distribution of Processing Latency (Sub-RQ1)
png("figures/fig1_latency_distribution.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
h <- hist(nmnist_data$latency_us / 1000,
    breaks = 25,
    col = "gray40",
    density = 25,
    angle = 45,
    border = "black",
    main = "Figure 1: Distribution of Event Processing Latency",
    xlab = "Processing Latency (milliseconds)",
    ylab = "Frequency",
    cex.main = 1.2, cex.lab = 1.0
)
abline(v = 306, col = "black", lwd = 2.5, lty = 2)
abline(v = mean(nmnist_data$latency_us) / 1000, col = "black", lwd = 2.5, lty = 1)
legend("topright",
    legend = c("Nominal Benchmark (306.0 ms)", "Sample Mean (306.05 ms)"),
    col = c("black", "black"),
    lty = c(2, 1),
    lwd = 2.5,
    bty = "n"
)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

# Figure 2: Spiking Density by Digit Class (Sub-RQ2)
png("figures/fig2_density_by_digit.png", width = 2600, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
t2 <- table(nmnist_data$density_category, nmnist_data$digit_class_factor)
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
    cex.main = 1.2, cex.lab = 1.0
)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

# Figure 3: Spatial Footprint vs Latency Speed (Sub-RQ3)
png("figures/fig3_spatial_vs_speed.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
t3 <- table(nmnist_data$latency_speed, nmnist_data$spatial_size_class)
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
    cex.main = 1.2, cex.lab = 1.0
)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

# Figure 4: Spike Count by Polarity Majority (Sub-RQ4)
png("figures/fig4_spikes_by_polarity.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
boxplot(spike_count ~ polarity_majority,
    data = nmnist_data,
    col = c("gray90", "gray50"),
    border = "black",
    main = "Figure 4: Total Spike Count by Event Polarity Dominance",
    xlab = "Dominant Optical Polarity Stream",
    ylab = "Total Asynchronous Spikes",
    notch = TRUE,
    cex.main = 1.2, cex.lab = 1.0
)
points(1:2, c(
    mean(nmnist_data$spike_count[nmnist_data$polarity_majority == "OFF-dominant"]),
    mean(nmnist_data$spike_count[nmnist_data$polarity_majority == "ON-dominant"])
),
pch = 23, bg = "black", col = "white", cex = 2.2, lwd = 1.5
)
legend("topright", legend = "Group Mean", pch = 23, pt.bg = "black", col = "white", pt.cex = 1.8, bty = "n")
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

# Figure 5: Active Pixels Across 10 Digit Classes (Sub-RQ5)
png("figures/fig5_active_pixels_by_digit.png", width = 2800, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
bw_palette_10 <- rep(c("gray92", "gray65"), 5)
boxplot(active_pixels ~ digit_class_factor,
    data = nmnist_data,
    col = bw_palette_10,
    border = "black",
    main = "Figure 5: Active Sensor Photosites Utilized Across Digit Classes",
    xlab = "Digit Class (0 - 9, n = 30 each)",
    ylab = "Unique Active Pixels",
    cex.main = 1.2, cex.lab = 1.0
)
means_pixels <- tapply(nmnist_data$active_pixels, nmnist_data$digit_class_factor, mean)
points(1:10, means_pixels, pch = 23, bg = "black", col = "white", cex = 1.8, lwd = 1.5)
legend("topright", legend = "Class Mean", pch = 18, pt.bg = "black", col = "white", pt.cex = 1.5, bty = "n")
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

# Figure 6: Bivariate Correlation Heatmap (Sub-RQ6)
png("figures/fig6_correlation_matrix.png", width = 2400, height = 2200, res = 300)
par(mar = c(3, 3, 4, 5))
num_cols <- nmnist_data[, c("spike_count", "bounding_area", "mean_isi_us", "latency_us", "active_pixels", "spikes_per_pixel")]
colnames(num_cols) <- c("Spike Count", "Bounding Area", "Mean ISI", "Latency", "Active Pixels", "Spikes/Pixel")
cor_m <- cor(num_cols)
colors_heatmap <- colorRampPalette(c("gray15", "gray98", "gray15"))(100)
image(1:6, 1:6, cor_m[, 6:1],
    col = colors_heatmap, axes = FALSE, xlab = "", ylab = "",
    main = "Figure 6: Pearson Bivariate Correlation Matrix (r)"
)
axis(1, at = 1:6, labels = colnames(num_cols), las = 2, cex.axis = 0.85)
axis(2, at = 1:6, labels = rev(colnames(num_cols)), las = 1, cex.axis = 0.85)
for (x in 1:6) {
    for (y in 1:6) {
        val <- cor_m[x, 7 - y]
        text(x, y, sprintf("%.2f", val),
            col = ifelse(abs(val) > 0.5, "white", "black"),
            cex = 1.1, font = 2
        )
    }
}
dev.off()

# Figure 7: Polarity Dominance Pie Chart (Descriptive)
png("figures/fig7_polarity_pie.png", width = 2200, height = 1800, res = 300)
par(mar = c(2, 2, 3, 2))
pol_tbl <- table(nmnist_data$polarity_majority)
pie(pol_tbl,
    col = c("gray40", "gray90"),
    density = c(30, NA),
    angle = c(45, 0),
    labels = paste0(names(pol_tbl), "\n", pol_tbl, " digits (", round(100 * prop.table(pol_tbl), 1), "%)"),
    main = "Figure 7: Event Polarity Dominance Distribution (N = 300)",
    cex.main = 1.2, cex = 1.0
)
dev.off()

# Figure 8: Population vs. Sample Stratified Distribution (Descriptive)
png("figures/fig8_stratified_samples.png", width = 2800, height = 1800, res = 300)
par(mfrow = c(1, 2), mar = c(5, 5, 4, 2))
pop_counts <- c(980, 1135, 1032, 1010, 982, 892, 958, 1028, 974, 1009)
digits <- 0:9
bp1 <- barplot(pop_counts,
    names.arg = digits,
    col = "gray85",
    density = 25,
    angle = 45,
    border = "black",
    ylim = c(0, 1300),
    main = "(A) Full N-MNIST Test Population (N = 10,000)",
    xlab = "Digit Class (0 - 9)",
    ylab = "Population Frequency",
    cex.main = 1.0, cex.lab = 0.9
)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
text(bp1, pop_counts + 40, labels = pop_counts, cex = 0.75, col = "black")
sample_counts <- rep(30, 10)
bp2 <- barplot(sample_counts,
    names.arg = digits,
    col = "gray30",
    border = "black",
    ylim = c(0, 40),
    main = "(B) Balanced Stratified Sample (n = 30 per digit, N = 300)",
    xlab = "Digit Class (0 - 9)",
    ylab = "Sample Frequency (n)",
    cex.main = 1.0, cex.lab = 0.9
)
abline(h = 30, col = "black", lty = 2, lwd = 2.5)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
text(bp2, sample_counts + 2, labels = "n=30", col = "black", font = 2, cex = 0.8)
dev.off()

# Figure 9: Latency Speed Category Distribution (Descriptive)
png("figures/fig9_speed_pie.png", width = 2200, height = 1800, res = 300)
par(mar = c(2, 2, 3, 2))
speed_tbl <- table(nmnist_data$latency_speed)
pie(speed_tbl,
    col = c("gray40", "gray90"),
    density = c(30, NA),
    angle = c(45, 0),
    labels = paste0(names(speed_tbl), "\n", speed_tbl, " digits (", round(100 * prop.table(speed_tbl), 1), "%)"),
    main = "Figure 9: Latency Speed Category Distribution (N = 300)",
    cex.main = 1.2, cex = 1.0
)
dev.off()

# Figure 10: Spiking Density Category Distribution (Descriptive)
png("figures/fig10_density_pie.png", width = 2200, height = 1800, res = 300)
par(mar = c(2, 2, 3, 2))
den_tbl <- table(nmnist_data$density_category)
pie(den_tbl,
    col = c("gray40", "gray90"),
    density = c(30, NA),
    angle = c(45, 0),
    labels = paste0(names(den_tbl), " Density\n", den_tbl, " digits (", round(100 * prop.table(den_tbl), 1), "%)"),
    main = "Figure 10: Spiking Density Category Distribution (N = 300)",
    cex.main = 1.2, cex = 1.0
)
dev.off()

# Figure 11: Spatial Size Class Distribution (Descriptive)
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

# Figure 12: Histogram of Spike Count
png("figures/fig12_spike_count_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$spike_count, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 12: Frequency Distribution of Total Spike Count", 
     xlab = "Total Spike Count (events)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 13: Histogram of Spike Density
png("figures/fig13_spike_density_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$spike_density, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 13: Frequency Distribution of Spiking Density", 
     xlab = "Spike Density (events / ms)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 14: Histogram of Processing Latency
png("figures/fig14_latency_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$latency_us / 1000, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 14: Frequency Distribution of Processing Latency", 
     xlab = "Processing Latency (milliseconds)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 15: Histogram of Mean Inter-Spike Interval
png("figures/fig15_mean_isi_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$mean_isi_us, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 15: Frequency Distribution of Mean Inter-Spike Interval", 
     xlab = "Mean Inter-Spike Interval (microseconds)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 16: Histogram of Maximum Inter-Spike Interval
png("figures/fig16_max_isi_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$max_isi_us / 1000, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 16: Frequency Distribution of Maximum Inter-Spike Interval", 
     xlab = "Maximum Inter-Spike Interval (milliseconds)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 17: Histogram of Spatial Width
png("figures/fig17_spatial_width_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$spatial_width, 
     breaks = seq(30.5, 33.5, by = 0.5), 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 17: Frequency Distribution of Spatial Width", 
     xlab = "Spatial Width (pixels)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 18: Histogram of Spatial Height
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
box(col = "black", lwd = 1.5)
dev.off()

# Figure 19: Histogram of Bounding Area
png("figures/fig19_bounding_area_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$bounding_area, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 19: Frequency Distribution of Bounding Area", 
     xlab = "Bounding Area (square pixels)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 20: Histogram of Active Pixels
png("figures/fig20_active_pixels_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$active_pixels, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 20: Frequency Distribution of Active Pixels", 
     xlab = "Active Pixels (count)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 21: Histogram of Center of Mass (X-Axis)
png("figures/fig21_com_x_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$center_of_mass_x, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 21: Frequency Distribution of Center of Mass (X-Axis)", 
     xlab = "Horizontal Center of Mass X (pixel index)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 22: Histogram of Center of Mass (Y-Axis)
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
box(col = "black", lwd = 1.5)
dev.off()

# Figure 23: 2D Center of Mass Scatter Plot
png("figures/fig23_com_scatter.png", width = 2400, height = 2400, res = 300)
par(mar = c(5, 5, 4, 2))
plot(nmnist_data$center_of_mass_x, nmnist_data$center_of_mass_y,
     pch = 19, col = adjustcolor("black", alpha.f = 0.5), cex = 0.8,
     xlim = c(14, 19), ylim = c(14, 19),
     main = "Figure 23: 2D Spatial Centroid Distribution on DVS Sensor Grid",
     xlab = "Horizontal Center of Mass X (pixels)",
     ylab = "Vertical Center of Mass Y (pixels)",
     cex.main = 1.2, cex.lab = 1.0)
abline(v = 16.5, col = "black", lty = 2, lwd = 1.5)
abline(h = 16.5, col = "black", lty = 2, lwd = 1.5)
legend("topright", 
       legend = c("Digit Centroids (n = 300)", "Sensor Frame Center (16.5, 16.5)"),
       pch = c(19, NA),
       lty = c(NA, 2),
       col = c("black", "black"),
       bty = "n", cex = 0.9)
grid(col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 24: Histogram of Spikes per Pixel
png("figures/fig24_spikes_per_pixel_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$spikes_per_pixel, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 24: Frequency Distribution of Spikes per Pixel", 
     xlab = "Spikes per Pixel (events / active pixel)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

# Figure 25: Histogram of ON Polarity Ratio
png("figures/fig25_on_ratio_hist.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))
hist(nmnist_data$on_ratio, 
     breaks = 25, 
     col = "gray40", 
     density = 25,
     angle = 45,
     border = "black",
     main = "Figure 25: Frequency Distribution of Raw ON Polarity Ratio", 
     xlab = "ON Polarity Ratio (proportion of total spikes)", 
     ylab = "Frequency",
     cex.main = 1.2, cex.lab = 1.0)
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
box(col = "black", lwd = 1.5)
dev.off()

cat("\nAll 25 figures successfully generated in the 'figures/' folder!\n")
