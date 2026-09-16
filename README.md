# Neuromorphic Processing Statistics
### IT1212 Probability & Statistics — N-MNIST Event-Based Sensor Analysis

Statistical characterization of spiking neural data extracted from the **N-MNIST neuromorphic dataset** using a Dynamic Vision Sensor (DVS). The study applies parametric and non-parametric inferential tests across six sub-research questions.

---

## Project Structure

```
├── extract_nmnist.py          # Python: feature extraction from raw N-MNIST events
├── assignment.R               # R: core analysis script (descriptive + inferential)
├── scratch_analysis.R         # R: full inferential analysis (all 6 sub-RQs)
├── generate_plots.R           # R: master pipeline — generates all 25 figures
│
├── plot_scripts/              # Individual R scripts for each figure (fig1–fig25)
├── figures/                   # Generated PNG figures (300 DPI, print-optimized B&W)
├── appendices/                # LaTeX appendix source + console output + CSV sample
│   ├── appendices.tex
│   ├── appendix_a_r_script.R
│   ├── appendix_b_python_extraction.py
│   ├── appendix_c_console_output.txt
│   ├── appendix_d_csv_sample.csv
│   └── appendix_e_github_repository.md
│
└── nmnist_features.csv        # Extracted feature dataset (N = 300 samples)
```

---

## Dataset

- **Source**: N-MNIST (Neuromorphic-MNIST) via the [Tonic](https://tonic.readthedocs.io) Python library (test split)
- **Sampling**: Stratified Random Sampling Without Replacement — 30 recordings per digit class (0–9), **N = 300 total**
- **Random Seed**: `42`

### Features Extracted per Recording (14 variables)

| Group | Features |
|-------|----------|
| **Temporal** | `latency_us`, `mean_isi_us`, `max_isi_us`, `spike_density` |
| **Spike** | `spike_count`, `spikes_per_pixel`, `on_ratio` |
| **Spatial** | `spatial_width`, `spatial_height`, `bounding_area`, `active_pixels` |
| **Centroid** | `center_of_mass_x`, `center_of_mass_y` |
| **Label** | `digit_class` |

### Derived Categorical Variables

| Variable | Rule |
|----------|------|
| `polarity_majority` | ON-dominant if `on_ratio > 0.5`, else OFF-dominant |
| `latency_speed` | Slow if `latency_us > median`, else Fast |
| `density_category` | High if `spike_density > median`, else Low |
| `spatial_size_class` | Large if `active_pixels >= median`, else Small |

---

## Reproducing the Analysis

### 1. Extract Features (Python)
```bash
pip install tonic numpy pandas
python extract_nmnist.py
```
> Generates `nmnist_features.csv`

### 2. Run Statistical Analysis (R)
```r
Rscript scratch_analysis.R
```
> Runs all six sub-RQ tests and prints results to console

### 3. Generate All Figures (R)
```r
Rscript generate_plots.R
```
> Outputs 25 PNG figures to the `figures/` folder

---

## Statistical Tests Performed

| Sub-RQ | Test | Variable(s) |
|--------|------|-------------|
| RQ1 | One-sample *t*-test | `latency_us` (μ₀ = 306,000 µs) |
| RQ2 | Chi-square (Monte Carlo) | `digit_class` × `density_category` |
| RQ3 | 2×2 Chi-square + Pearson *r* | `spatial_size_class` × `latency_speed` |
| RQ4 | Two-sample Welch *t*-test | `spike_count` by `polarity_majority` |
| RQ5 | One-way ANOVA + Levene + Tukey HSD | `active_pixels` across digit classes |
| RQ6 | Pearson correlation matrix | `spike_count`, `bounding_area`, `mean_isi_us`, `latency_us`, `active_pixels`, `spikes_per_pixel` |

---

## Environment

| Tool | Version |
|------|---------|
| R | 4.6.1 |
| Python | 3.11.x |
| `tonic` | latest |
| `numpy` | latest |
| `pandas` | latest |
| R `car` package | (Levene's test) |

---

*Repository maintained by Yasith Tharuka — IT1212 Probability & Statistics Assignment*
