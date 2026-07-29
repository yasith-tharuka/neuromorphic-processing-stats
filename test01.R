# =====================================================================
# CHAPTER 3: PRELIMINARY DATA ANALYSIS (DATA VISUALIZATION)
# 22 Individual, High-Precision Charts (Academic Color Palette)
# =====================================================================

# ---------------------------------------------------------------------
# PART 1: THE 9 CATEGORICAL PIE CHARTS
# ---------------------------------------------------------------------

size_median <- median(nmnist_data$bounding_area)
nmnist_data$spatial_size_class <- ifelse(nmnist_data$bounding_area >= size_median, "Large", "Small")

# Diagram 1: Digit Class (Uses a professional 10-color categorical palette)
digit_counts <- table(nmnist_data$digit_class)
pie(digit_counts, 
    main = "Figure 3.1: Distribution of Digit Classes (0-9)", 
    col = c("#4E79A7", "#F28E2B", "#E15759", "#76B7B2", "#59A14F", 
            "#EDC949", "#AF7AA1", "#FF9DA7", "#9C755F", "#BAB0AB"),
    labels = paste("Digit", names(digit_counts), "-", digit_counts))

# Diagram 2: Polarity Majority (Contrasting academic blue and red)
polarity_counts <- table(nmnist_data$polarity_majority)
pie(polarity_counts, 
    main = "Figure 3.2: Event Polarity Dominance", 
    col = c("#4E79A7", "#E15759"),
    labels = paste(names(polarity_counts), "-", polarity_counts, "events"))

# Diagram 3: Latency Speed Category (Contrasting teal and gold)
speed_counts <- table(nmnist_data$latency_speed)
pie(speed_counts, 
    main = "Figure 3.3: Hardware Processing Latency Speed", 
    col = c("#76B7B2", "#EDC949"),
    labels = paste(names(speed_counts), "-", speed_counts, "events"))

# Diagram 4: Density Category (Contrasting green and purple)
density_counts <- table(nmnist_data$density_category)
pie(density_counts, 
    main = "Figure 3.4: Spiking Event Density Classification", 
    col = c("#59A14F", "#AF7AA1"),
    labels = paste(names(density_counts), "-", density_counts, "events"))

# Diagram 5: Spatial Size Class (Contrasting slate gray and brown)
size_counts <- table(nmnist_data$spatial_size_class)
pie(size_counts, 
    main = "Figure 3.5: Physical Footprint Size Classification", 
    col = c("#BAB0AB", "#9C755F"),
    labels = paste(names(size_counts), "-", size_counts, "events"))

# Diagram 6: Spike Count Groups (Sequential Blue: Light -> Med -> Dark)
spike_group_counts <- table(nmnist_data$spike_groups)
pie(spike_group_counts, 
    main = "Figure 3.6: Total Spike Count Groupings", 
    col = c("#A0CBE8", "#4E79A7", "#2A5783"),
    labels = paste(names(spike_group_counts), "-", spike_group_counts))

# Diagram 7: Active Pixel Groups (Sequential Green: Light -> Med -> Dark)
pixel_group_counts <- table(nmnist_data$pixel_groups)
pie(pixel_group_counts, 
    main = "Figure 3.7: Sensor Pixel Usage Groupings", 
    col = c("#B3E2CD", "#59A14F", "#23631A"),
    labels = paste(names(pixel_group_counts), "-", pixel_group_counts))

# Diagram 8: Inter-Spike Interval Groups (Sequential Orange: Light -> Med -> Dark)
isi_group_counts <- table(nmnist_data$isi_groups)
pie(isi_group_counts, 
    main = "Figure 3.8: Inter-Spike Delay Groupings", 
    col = c("#FFBE7D", "#F28E2B", "#A65600"),
    labels = paste(names(isi_group_counts), "-", isi_group_counts))

# Diagram 9: Spatial Width Groups (Sequential Gray: Light -> Med -> Dark)
width_group_counts <- table(nmnist_data$width_groups)
pie(width_group_counts, 
    main = "Figure 3.9: Physical Width Groupings", 
    col = c("#D3D3D3", "#9C9C9C", "#595959"),
    labels = paste(names(width_group_counts), "-", width_group_counts))


# ---------------------------------------------------------------------
# PART 2: THE 13 NUMERICAL HISTOGRAMS (Raw Data Distributions)
# ---------------------------------------------------------------------
# Histograms are grouped by data type (Time vs. Space) using cohesive colors.

# Diagram 10: Raw Processing Latency (Academic Blue)
hist(nmnist_data$latency_us, 
     main = "Figure 3.10: Distribution of Event Latency", 
     xlab = "Processing Time (microseconds)", 
     col = "#4E79A7", 
     breaks = 20)

# Diagram 11: Raw Spike Count (Academic Blue)
hist(nmnist_data$spike_count, 
     main = "Figure 3.11: Distribution of Total Spikes", 
     xlab = "Number of Spikes per Digit", 
     col = "#4E79A7", 
     breaks = 20)

# Diagram 12: Raw Spike Density (Academic Blue)
hist(nmnist_data$spike_density, 
     main = "Figure 3.12: Distribution of Spiking Density", 
     xlab = "Events per Microsecond", 
     col = "#4E79A7", 
     breaks = 20)

# Diagram 13: Raw Active Pixels (Academic Green)
hist(nmnist_data$active_pixels, 
     main = "Figure 3.13: Distribution of Active Pixels", 
     xlab = "Number of Pixels Fired", 
     col = "#59A14F", 
     breaks = 20)

# Diagram 14: Raw Bounding Area (Academic Green)
hist(nmnist_data$bounding_area, 
     main = "Figure 3.14: Distribution of Bounding Box Area", 
     xlab = "Area (Pixels Squared)", 
     col = "#59A14F", 
     breaks = 20)

# Diagram 15: Raw Mean Inter-Spike Interval (Academic Orange)
hist(nmnist_data$mean_isi_us, 
     main = "Figure 3.15: Distribution of Mean Inter-Spike Interval", 
     xlab = "Time (microseconds)", 
     col = "#F28E2B", 
     breaks = 20)

# Diagram 16: Raw Max Inter-Spike Interval (Academic Orange)
hist(nmnist_data$max_isi_us, 
     main = "Figure 3.16: Distribution of Maximum Inter-Spike Interval", 
     xlab = "Time (microseconds)", 
     col = "#F28E2B", 
     breaks = 20)

# Diagram 17: Raw ON-Spike Ratio (Slate Gray)
hist(nmnist_data$on_ratio, 
     main = "Figure 3.17: Distribution of ON-Spike Ratio", 
     xlab = "Ratio (0.0 to 1.0)", 
     col = "#7F8C8D", 
     breaks = 20)

# Diagram 18: Raw Spatial Width (Academic Green)
hist(nmnist_data$spatial_width, 
     main = "Figure 3.18: Distribution of Spatial Width", 
     xlab = "Width (pixels)", 
     col = "#59A14F", 
     breaks = 20)

# Diagram 19: Raw Spatial Height (Academic Green)
hist(nmnist_data$spatial_height, 
     main = "Figure 3.19: Distribution of Spatial Height", 
     xlab = "Height (pixels)", 
     col = "#59A14F", 
     breaks = 20)

# Diagram 20: Raw Spikes Per Pixel (Academic Green)
hist(nmnist_data$spikes_per_pixel, 
     main = "Figure 3.20: Distribution of Spikes per Active Pixel", 
     xlab = "Average Spikes per Pixel", 
     col = "#59A14F", 
     breaks = 20)

# Diagram 21: Raw Center of Mass X-Axis (Muted Purple)
hist(nmnist_data$center_of_mass_x, 
     main = "Figure 3.21: Distribution of Center of Mass (X)", 
     xlab = "X Coordinate (Sensor Array)", 
     col = "#AF7AA1", 
     breaks = 20)

# Diagram 22: Raw Center of Mass Y-Axis (Muted Purple)
hist(nmnist_data$center_of_mass_y, 
     main = "Figure 3.22: Distribution of Center of Mass (Y)", 
     xlab = "Y Coordinate (Sensor Array)", 
     col = "#AF7AA1", 
     breaks = 20)