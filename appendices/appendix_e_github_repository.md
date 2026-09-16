# Appendix E: Supplementary Code Repository & Reproducibility Statement

## 1. Code Repository
The complete computational workflow, raw feature extraction scripts, statistical analysis routines, and plot generation code are hosted in the following public repository for complete computational audit and peer review:

* **Repository URL**: `https://github.com/yasith-tharuka/neuromorphic-processing-stats`
* **Dataset Identifier**: N-MNIST Neuromorphic Dataset (Tonic API Python Integration)
* **Random Seed**: `42` (ensures 100% computational reproducibility across stratified random sampling)

---

## 2. Environment & Tooling Specifications
* **Statistical Environment**: R version `4.6.1` (x86_64-w64-mingw32)
* **Python Environment**: Python `3.11.x` with `tonic`, `numpy`, and `pandas` libraries
* **Graphics Device**: High-resolution PNG device (`300 DPI`, print-optimized grayscale)

---

## 3. Reproducibility Guarantee
All statistical results presented in Chapter 4 (including sample means, standard deviations, $t$-statistics, $\chi^2$ metrics, $F$-ratios, Cramér's $V$, Cohen's $d$, Eta-squared $\eta^2$, Tukey HSD pairwise confidence intervals, and Pearson correlation coefficients $r$) can be reproduced by executing the script [`appendix_a_r_script.R`](file:///d:/PS_Assignment/appendices/appendix_a_r_script.R) against the extracted feature file `nmnist_features.csv`.
