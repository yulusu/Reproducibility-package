R7 MATLAB REPRODUCIBILITY INSTRUCTIONS

Purpose
-------
These scripts reproduce the deterministic figures and numerical values used
in the R7 manuscript "Authority Windows for Full Retention of Co-Moving
Realizability Sets." No external experimental dataset is required.

Recommended procedure
---------------------
1. Start MATLAB.
2. Change the current folder to this matlab/ directory.
3. Run:

   verify_paper_values

   This checks the numerical values explicitly reported in the manuscript.

4. Run:

   run_all_figures

   This regenerates the figure outputs in PDF, PNG, and EPS formats using
   the shared parameter definitions and export helpers.

Main scripts
------------
paper_params.m
    Shared manuscript parameters.

verify_paper_values.m
    Assertions for reported closed-form and numerical values.

run_all_figures.m
    Convenience driver that runs all archived figure-generation scripts.

fig1_phase_diagram.m
    Generates the target-space phase diagram.

fig2_qratio_windows.m
    Generates normalized holding-demand curves.

fig3_n3_compact_window.m
    Generates the three-dimensional k>p compact-window example.

fig4_shell_sandwich.m
    Generates the shell-bound illustration.

fig5_mainiv_witness.m
    Generates the former standalone regular active-orbit / implicit-function
    witness graphic. In R7 this graphic has been folded into the manuscript
    text and is no longer inserted as a numbered figure; the script is kept
    in the archive for reproducibility of the analytic example.

fig6_grid_benchmark.m
    Generates the grid verification plot. Although the filename retains
    "fig6" for provenance, this graphic is displayed as Figure 5 in R7.

grid_viability_left.m
    Helper used by fig6_grid_benchmark.m.

ieee_figure.m
    Shared IEEE-style figure setup helper.

export_ieee.m
    Shared export helper.

Expected outputs
----------------
The archived outputs are stored in ../figures/ as PDF, PNG, and EPS files.

Verification notes
------------------
- All plotted/numerical content is deterministic.
- No random seed is required.
- No external data download is required.
- If a newer MATLAB release changes renderer details, minor visual differences
  may occur without changing the numerical values.
