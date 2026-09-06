# Reproducibility Package

## Manuscript

**Authority Windows for Full Retention of Co-Moving Realizability Sets**

Authors:

- Guangqing Zhang
- Lei Zhang
- Ning Zhang (corresponding author)
- Chuanhui Huang
- Xiangdong Ni

This repository is the reproducibility package accompanying the IEEE Transactions on Automatic Control manuscript above. It contains the R7 manuscript source/PDF, deterministic MATLAB scripts, figure assets, and a figure/value reproducibility map.

## Package contents

```text
README.md
LICENSE
CITATION.cff
R7_TAC_manuscript.tex
R7_TAC_manuscript.pdf
figures/
matlab/
  README.txt
  *.m
reproducibility_map.txt
```

## Reproducing the numerical material

Requirements:

- MATLAB with standard plotting and numerical functions used by the supplied scripts.
- No external experimental dataset is required.

From MATLAB, change the working directory to `matlab/` and run:

```matlab
verify_paper_values
run_all_figures
```

`verify_paper_values.m` checks the closed-form/numerical values reported in the manuscript. `run_all_figures.m` regenerates the supplied deterministic figure files.

See `matlab/README.txt` and `reproducibility_map.txt` for script-level details.

## R7 figure note

The former standalone implicit-function witness graphic is no longer inserted as a figure in the R7 manuscript; its script and generated files are retained in the archive for reproducibility of that analytic example. Consequently, the grid benchmark stored as `fig6_grid_benchmark.*` is displayed as Figure 5 in the R7 manuscript.

## Building the manuscript

The manuscript uses the IEEEtran class. From the repository root, a standard build is:

```bash
pdflatex R7_TAC_manuscript.tex
pdflatex R7_TAC_manuscript.tex
```

The supplied `R7_TAC_manuscript.pdf` was built from the included `R7_TAC_manuscript.tex` and figure assets.

## Archival release

Recommended release tag: `v1.0.0`.

After this repository is enabled in the Zenodo GitHub integration, publish a GitHub Release from that tag. Zenodo will archive the release and assign the version-specific DOI. Do not move or recreate the archived tag after publication.

The Zenodo DOI is intentionally not fabricated in this pre-archive package. After Zenodo assigns it, cite the version-specific DOI in the submitted manuscript and add it to the live GitHub README.

## Funding

Universities in Xuzhou Serving the 343 Industrial Development Project, Grant gx2024026.

## Contact

Corresponding author: Ning Zhang, `ningzhang@xzit.edu.cn`.
