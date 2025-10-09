# Stage 3 — Analysis and Visualization (PNG)

# Paths
DATA_DIR    = ../../gen/temp
OUTPUT_DIR  = ../../gen/output
SCRIPT_DIR  = .
ROOT        = $(abspath ../..)

VISUALIZE_SCRIPT = $(SCRIPT_DIR)/visualize.R
ANALYSIS_SCRIPT  = $(SCRIPT_DIR)/analysis.R
INPUT_DATA       = $(DATA_DIR)/final_dataset.csv
OUTPUT_PNG       = $(OUTPUT_DIR)/analysis_output.png
RMD_FILE         = $(OUTPUT_DIR)/analysis_report.Rmd
REPORT_PNG       = $(OUTPUT_DIR)/analysis_output.png

.PHONY: all clean visualize analysis

# Default target: run both visualization and analysis
all: visualize analysis

# Visualization step
visualize: $(VISUALIZE_SCRIPT) $(INPUT_DATA)
	R -e "dir.create('$(OUTPUT_DIR)', recursive = TRUE)"
	Rscript $(VISUALIZE_SCRIPT)

# Analysis step
analysis: $(ANALYSIS_SCRIPT) $(INPUT_DATA)
	R -e "dir.create('$(OUTPUT_DIR)', recursive = TRUE)"
	Rscript $(ANALYSIS_SCRIPT)

# Clean outputs
clean:
	rm -f $(OUTPUT_DIR)/analysis_output.png
	rm -f $(OUTPUT_DIR)/analysis_report.Rmd
	rm -f $(OUTPUT_DIR)/stars_vs_photos.png
	rm -f $(OUTPUT_DIR)/photos_per_category.png
	@echo "Cleaned analysis output files."

