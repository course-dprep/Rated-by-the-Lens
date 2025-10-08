# Stage 3 — Analysis and Visualization

# Paths
DATA_DIR    = ../../gen/temp
OUTPUT_DIR  = ../../gen/output
SCRIPT_DIR  = .
ROOT        = $(abspath ../..)

ANALYSIS_SCRIPT = $(SCRIPT_DIR)/analysis.R
INPUT_DATA      = $(DATA_DIR)/final_dataset.csv
OUTPUT_PDF      = $(OUTPUT_DIR)/analysis_output.pdf
RMD_FILE        = $(ROOT)/reporting/analysis_report.Rmd
REPORT_PDF      = $(ROOT)/reporting/analysis_output.pdf

# Default target
all: $(OUTPUT_PDF)

# Run analysis to generate Rmd and PDF
$(OUTPUT_PDF): $(ANALYSIS_SCRIPT) $(INPUT_DATA) | $(OUTPUT_DIR)
	R -e "dir.create('$(OUTPUT_DIR)', recursive = TRUE)"
	Rscript -e "setwd('$(ROOT)'); source('src/3-analysis/analysis.R')"
	if [ -f "$(REPORT_PDF)" ]; then \
		cp "$(REPORT_PDF)" "$(OUTPUT_PDF)"; \
		echo "Analysis completed successfully. PDF copied to $(OUTPUT_PDF)"; \
	else \
		echo "Error: $(REPORT_PDF) not found!"; \
		exit 1; \
	fi

# Ensure output directory exists
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Clean analysis outputs
clean:
	rm -f $(OUTPUT_DIR)/analysis_output.pdf
	rm -f $(RMD_FILE)
	@echo "Cleaned analysis output files."

