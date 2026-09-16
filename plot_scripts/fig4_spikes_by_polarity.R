# =====================================================================
# Figure 4: Total Spike Count by Event Polarity Dominance (Sub-RQ4) - B&W / Print-Optimized
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

nmnist_data$polarity_majority <- as.factor(ifelse(nmnist_data$on_ratio > 0.5, "ON-dominant", "OFF-dominant"))

cat("Generating Figure 4: Spike Count by Polarity Majority...\n")
png("figures/fig4_spikes_by_polarity.png", width = 2400, height = 1800, res = 300)
par(mar = c(5, 5, 4, 2))

# Boxplot with grayscale fill and clear distinct mean symbols
boxplot(spike_count ~ polarity_majority, 
        data = nmnist_data,
        col = c("gray90", "gray50"),
        border = "black",
        main = "Figure 4: Total Spike Count by Event Polarity Dominance",
        xlab = "Dominant Optical Polarity Stream",
        ylab = "Total Asynchronous Spikes",
        notch = TRUE,
        cex.main = 1.2, cex.lab = 1.0)

# Solid diamond mark for group mean with thick outline
points(1:2, c(mean(nmnist_data$spike_count[nmnist_data$polarity_majority == "OFF-dominant"]),
              mean(nmnist_data$spike_count[nmnist_data$polarity_majority == "ON-dominant"])),
       pch = 23, bg = "black", col = "white", cex = 2.2, lwd = 1.5)

legend("topright", legend = "Group Mean", pch = 23, pt.bg = "black", col = "white", pt.cex = 1.8, bty = "n")
grid(nx = NA, ny = NULL, col = "gray75", lty = "dotted")
dev.off()

cat("Successfully generated figures/fig4_spikes_by_polarity.png\n")
