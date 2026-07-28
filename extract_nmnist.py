import tonic
import pandas as pd
import numpy as np
import os

print("Step 1: Initializing N-MNIST Dataset...")
# Using the test set for a faster download while maintaining statistical validity
dataset = tonic.datasets.NMNIST(save_to='./data', train=False)

sample_size = 300  
data_rows = []

print(f"\nStep 2: Randomly sampling {sample_size} event streams...")
# Ensures you extract the exact same 300 records if you ever need to rerun the script
np.random.seed(42) 
indices = np.random.choice(len(dataset), sample_size, replace=False)

# 3. Feature Extraction Loop
for count, i in enumerate(indices):
    if (count + 1) % 50 == 0:
        print(f"Processing record {count + 1}/{sample_size}...")
        
    events, target = dataset[i]
    spike_count = len(events)
    
    # Skip anomalies with too few spikes to prevent division by zero errors
    if spike_count < 2:
        continue
        
    # Extract base event arrays for cleaner math
    timestamps = events['t']
    x_coords = events['x']
    y_coords = events['y']
    polarities = events['p']
    
    # --- Temporal (Time-Based) Features ---
    latency_us = int(timestamps.max() - timestamps.min())
    isis = np.diff(timestamps)
    max_isi_us = int(isis.max()) if len(isis) > 0 else 0
    mean_isi_us = latency_us / (spike_count - 1)
    spike_density = (spike_count / latency_us) * 1000 if latency_us > 0 else 0
    
    # --- Spatial (Physical Size) Features ---
    spatial_width = int(x_coords.max() - x_coords.min())
    spatial_height = int(y_coords.max() - y_coords.min())
    bounding_area = spatial_width * spatial_height
    
    # Count unique (x, y) coordinates to see how many individual pixels actually fired
    active_pixels = len(np.unique(np.c_[x_coords, y_coords], axis=0))
    spikes_per_pixel = spike_count / active_pixels if active_pixels > 0 else 0
    
    center_of_mass_x = np.mean(x_coords)
    center_of_mass_y = np.mean(y_coords)
    
    # --- Polarity (Brightness) Features ---
    on_spikes = np.sum(polarities == 1)
    on_ratio = on_spikes / spike_count
    
    # Append all features to the dataset array
    data_rows.append({
        "digit_class": int(target),
        "spike_count": spike_count,
        "latency_us": latency_us,
        "mean_isi_us": round(mean_isi_us, 2),
        "max_isi_us": max_isi_us,
        "spike_density": round(spike_density, 4),
        "on_ratio": round(on_ratio, 4),
        "spatial_width": spatial_width,
        "spatial_height": spatial_height,
        "bounding_area": bounding_area,
        "active_pixels": active_pixels,
        "spikes_per_pixel": round(spikes_per_pixel, 2),
        "center_of_mass_x": round(center_of_mass_x, 2),
        "center_of_mass_y": round(center_of_mass_y, 2)
    })

print("\nStep 3: Feature extraction complete. Exporting to CSV...")

# 4. Export to CSV for R Analysis
df = pd.DataFrame(data_rows)
csv_filename = 'nmnist_features.csv'
df.to_csv(csv_filename, index=False)

print(f"\nSuccess! '{csv_filename}' has been generated.")
print(f"Total Records: {len(df)}")
print(f"Total Raw Features: {len(df.columns)}")