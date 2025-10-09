# Stage 3 — Analysis and Visualization

# Paths
DATA_DIR    = ../../gen/temp
OUTPUT_DIR  = ../../gen/output
SCRIPT_DIR  = .
ROOT        = $(abspath ../..)

VISUALIZE_SCRIPT = $(SCRIPT_DIR)/visualize.R
ANALYSIS_SCRIPT  = $(SCRIPT_DIR)/analysis.R
INPUT_DATA       = $(DATA_DIR)/final_dataset.csv
OUTPUT_PDF       = $(OUTPUT_DIR)/analysis_output.pdf
RMD_FILE         = $(OUTPUT_DIR)/analysis_report.Rmd
REPORT_PDF       = $(OUTPUT_DIR)/analysis_output.pdf

.PHONY: all clean visualize analysis

# Default target: run both visualization and analysis
all: visualize analysis

# Visualization step
visualize: $(VISUALIZE_SCRIPT)
	R -e "dir.create('$(OUTPUT_DIR)', recursive = TRUE)"
	Rscript visualize.R

# Analysis step
analysis: $(ANALYSIS_SCRIPT)
	R -e "dir.create('$(OUTPUT_DIR)', recursive = TRUE)"
	Rscript analysis.R

# Clean outputs
clean:
	rm -f $(OUTPUT_DIR)/analysis_output.pdf
	rm -f $(OUTPUT_DIR)/analysis_report.Rmd
	@echo "Cleaned analysis output files."
