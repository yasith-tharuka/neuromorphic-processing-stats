import tonic
import pandas as pd
import numpy as np

# Using the test set for a faster download while maintaining statistical validity
dataset = tonic.datasets.NMNIST(save_to='./data', train=False)

# Target balanced sampling: 30 samples per digit class (0 to 9) = 300 total samples
np.random.seed(42)
samples_per_stratum = 30
targets = np.array(dataset.targets)

indices = []
for digit in range(10):
    digit_indices = np.where(targets == digit)[0]
    sampled = np.random.choice(digit_indices, samples_per_stratum, replace=False)
    indices.extend(sampled)

# Shuffle selected indices so processing order is random
indices = np.array(indices)
np.random.shuffle(indices)
sample_size = len(indices)

data_rows = []

# Feature Extraction Loop
for count, i in enumerate(indices):
    events, target = dataset[i]
    spike_count = len(events)
    
    # Skip anomalies with too few spikes to prevent division by zero errors
    if spike_count < 2:
        continue
        
    # Extract base event arrays
    timestamps = events['t']
    x_coords = events['x']
    y_coords = events['y']
    polarities = events['p']
    
    # Temporal (Time-Based) Features
    latency_us = int(timestamps.max() - timestamps.min())
    isis = np.diff(timestamps)
    max_isi_us = int(isis.max()) if len(isis) > 0 else 0
    mean_isi_us = latency_us / (spike_count - 1)
    spike_density = (spike_count / latency_us) * 1000 if latency_us > 0 else 0
    
    # Spatial (Physical Size) Features
    spatial_width = int(x_coords.max() - x_coords.min())
    spatial_height = int(y_coords.max() - y_coords.min())
    bounding_area = spatial_width * spatial_height
    
    # Count unique (x, y) coordinates to see how many individual pixels fired
    active_pixels = len(np.unique(np.c_[x_coords, y_coords], axis=0))
    spikes_per_pixel = spike_count / active_pixels if active_pixels > 0 else 0
    
    center_of_mass_x = np.mean(x_coords)
    center_of_mass_y = np.mean(y_coords)
    
    # Polarity (Brightness) Features
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

# Export to CSV for R Analysis
df = pd.DataFrame(data_rows)
csv_filename = 'nmnist_features.csv'
df.to_csv(csv_filename, index=False)