# Figure 3.x.1: Pie Chart for Polarity Majority (Like "Gender")
polarity_counts <- table(nmnist_data$polarity_majority)
pie(polarity_counts, 
    main = "Pie Chart: Event Polarity Dominance", 
    col = c("darkred", "darkgreen"),
    labels = paste(names(polarity_counts), "\n", polarity_counts, " events"))

# Figure 3.x.2: Pie Chart for Latency Speed
speed_counts <- table(nmnist_data$latency_speed)
pie(speed_counts, 
    main = "Pie Chart: Hardware Latency Speed", 
    col = c("lightblue", "salmon"),
    labels = paste(names(speed_counts), "\n", speed_counts, " events"))

# Figure 3.x.3: Pie Chart for Density Category
density_counts <- table(nmnist_data$density_category)
pie(density_counts, 
    main = "Pie Chart: Spiking Event Density", 
    col = c("lightgreen", "mediumpurple"),
    labels = paste(names(density_counts), "\n", density_counts, " events"))

# Figure 3.x.4: Pie Chart for Digit Class (Like "Program/School")
digit_counts <- table(nmnist_data$digit_class)
pie(digit_counts, 
    main = "Pie Chart: Digit Class Distribution",
    col = rainbow(10))