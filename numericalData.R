# Figure 3.x.5: Bar Graph of Total Spike Count
hist(nmnist_data$spike_count, 
     main = "Bar Graph: Total Spike Count per Digit", 
     xlab = "Number of Spikes", 
     col = "cadetblue", 
     breaks = 15)

# Figure 3.x.6: Bar Graph of Active Pixels
hist(nmnist_data$active_pixels, 
     main = "Bar Graph: Sensor Pixel Utilization", 
     xlab = "Number of Active Pixels", 
     col = "coral", 
     breaks = 15)

# Figure 3.x.7: Bar Graph of Spike Density
hist(nmnist_data$spike_density, 
     main = "Bar Graph: Spiking Density", 
     xlab = "Events per Microsecond", 
     col = "gold", 
     breaks = 15)