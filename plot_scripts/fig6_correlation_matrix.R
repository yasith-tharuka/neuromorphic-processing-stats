# =====================================================================
# Figure 6: Pearson Bivariate Correlation Matrix (Sub-RQ6) - Rectangular Table Visual
# =====================================================================

dir.create("figures", showWarnings = FALSE)
nmnist_data <- read.csv("nmnist_features.csv")

cat("Generating Figure 6: Bivariate Correlation Matrix Rectangular Table...\n")

# Wide rectangular image canvas (aspect ratio ~ 2.3 : 1)
png("figures/fig6_correlation_matrix.png", width = 3400, height = 1500, res = 300)

num_cols <- nmnist_data[, c("spike_count", "bounding_area", "mean_isi_us", "latency_us", "active_pixels", "spikes_per_pixel")]
col_labels <- c("Spike Count", "Bounding Area", "Mean ISI", "Latency", "Active Pixels", "Spikes/Pixel")
cor_m <- cor(num_cols)

par(mar = c(1, 1, 3, 1))

# Setup wide grid: 7 columns (0=row labels, 1..6=data) and 7 rows (0=header, 1..6=data)
plot(1, type = "n", xlim = c(0, 7), ylim = c(7, 0), axes = FALSE, xlab = "", ylab = "")
title(main = "Figure 6: Pearson Bivariate Correlation Matrix (r)", cex.main = 1.3, line = 1.0)

# Render Header Row (Row 0) - Dark Grayscale
rect(0, 0, 1, 1, col = "gray25", border = "black", lwd = 1.5)
text(0.5, 0.5, "Feature", col = "white", font = 2, cex = 1.0)

for (c in 1:6) {
  rect(c, 0, c + 1, 1, col = "gray25", border = "black", lwd = 1.5)
  text(c + 0.5, 0.5, col_labels[c], col = "white", font = 2, cex = 1.0)
}

# Render Table Body (Rows 1 to 6)
for (r in 1:6) {
  # Left Row Header Column
  rect(0, r, 1, r + 1, col = "gray85", border = "black", lwd = 1.5)
  text(0.5, r + 0.5, col_labels[r], col = "black", font = 2, cex = 1.0)
  
  # Data Cells
  for (c in 1:6) {
    val <- cor_m[r, c]
    
    # Grayscale Shading Logic:
    # Diagonal -> Soft Gray
    # Strong correlation (|r| > 0.85) -> Dark Gray fill with bold white text
    # Moderate correlation -> Soft Gray
    # Weak correlation -> Clean White
    if (r == c) {
      bg_col <- "gray90"
      txt_col <- "black"
      txt_font <- 3
    } else if (abs(val) > 0.85) {
      bg_col <- "gray40"
      txt_col <- "white"
      txt_font <- 2
    } else if (abs(val) > 0.70) {
      bg_col <- "gray75"
      txt_col <- "black"
      txt_font <- 2
    } else {
      bg_col <- "white"
      txt_col <- "black"
      txt_font <- 1
    }
    
    rect(c, r, c + 1, r + 1, col = bg_col, border = "black", lwd = 1.2)
    
    txt_val <- ifelse(r == c, "1.000", sprintf("%.3f", val))
    text(c + 0.5, r + 0.5, labels = txt_val, col = txt_col, cex = 1.05, font = txt_font)
  }
}

dev.off()

cat("Successfully generated figures/fig6_correlation_matrix.png\n")
