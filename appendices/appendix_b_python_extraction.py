"""
=====================================================================
APPENDIX B: PYTHON FEATURE EXTRACTION SCRIPT
Module: IT1212 Probability and Statistics
Dataset: N-MNIST Neuromorphic Spiking Data (Tonic Library Integration)
Description: The Python script used to extract features from the raw N-MNIST event data.
=====================================================================
"""

import tonic
import pandas as pd
import numpy as np

# 1. Initialize Dataset & Reproducible Sampling
np.random.seed(42)
dataset = tonic.datasets.NMNIST(save_to='./data', train=False)

samples_per_stratum = 30
targets = np.array(dataset.targets)

indices = []
for digit in range(10):
    digit_indices = np.where(targets == digit)[0]
    sampled = np.random.choice(digit_indices, samples_per_stratum, replace=False)
    indices.extend(sampled)

indices = np.array(indices)
np.random.shuffle(indices)

# 2. Extract Raw Physical and Temporal Features
data_rows = []

for idx in indices:
    events, target = dataset[idx]
    spike_count = len(events)
    
    if spike_count < 2:
        continue
        
    timestamps = events['t']
    x_coords   = events['x']
    y_coords   = events['y']
    polarities = events['p']
    
    # Temporal Features
    latency_us    = int(timestamps.max() - timestamps.min())
    isis          = np.diff(timestamps)
    max_isi_us    = int(isis.max()) if len(isis) > 0 else 0
    mean_isi_us   = latency_us / (spike_count - 1)
    spike_density = (spike_count / latency_us) * 1000 if latency_us > 0 else 0
    on_ratio      = float(np.mean(polarities == 1))
    
    # Spatial Features
    spatial_width  = int(x_coords.max() - x_coords.min())
    spatial_height = int(y_coords.max() - y_coords.min())
    bounding_area  = spatial_width * spatial_height
    active_pixels  = len(np.unique(np.c_[x_coords, y_coords], axis=0))
    spikes_per_pixel = spike_count / active_pixels if active_pixels > 0 else 0
    
    center_of_mass_x = float(np.mean(x_coords))
    center_of_mass_y = float(np.mean(y_coords))
    
    data_rows.append({
        'digit_class': target,
        'spike_count': spike_count,
        'latency_us': latency_us,
        'mean_isi_us': mean_isi_us,
        'max_isi_us': max_isi_us,
        'spike_density': spike_density,
        'on_ratio': on_ratio,
        'spatial_width': spatial_width,
        'spatial_height': spatial_height,
        'bounding_area': bounding_area,
        'active_pixels': active_pixels,
        'spikes_per_pixel': spikes_per_pixel,
        'center_of_mass_x': center_of_mass_x,
        'center_of_mass_y': center_of_mass_y
    })

# 3. Export to CSV
df = pd.DataFrame(data_rows)
df.to_csv("nmnist_features.csv", index=False)
print("Dataset successfully extracted and saved to nmnist_features.csv")
