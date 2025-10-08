# Main Makefile — Full Pipeline

MAKE := "$(MAKE)"

.PHONY: all clean

# Directory paths
DATA := data
TEMP := gen/temp
OUT  := gen/output

# Default goal
.DEFAULT_GOAL := all

# Main build rule
all: $(OUT)/report.pdf

# Final report depends on the completed analysis
$(OUT)/report.pdf: $(OUT)/analysis_output.pdf
	cp $(OUT)/analysis_output.pdf $(OUT)/report.pdf
	@echo "Final report ready: $(OUT)/report.pdf"

# Stage 3 — Analysis and Visualization
$(OUT)/analysis_output.pdf: $(TEMP)/final_dataset.csv src/3-analysis/analysis.R
	$(MAKE) -C src/3-analysis all

# Stage 2 — Data Preparation
$(TEMP)/final_dataset.csv: $(DATA)/photos.csv $(DATA)/business.csv src/2-data-preparation/clean.R
	$(MAKE) -C src/2-data-preparation all

# Stage 1 — Download raw data
$(DATA)/photos.csv $(DATA)/business.csv: src/1-raw-data/download.R
	$(MAKE) -C src/1-raw-data all

# Clean everything
clean:
	R -e "unlink('$(DATA)', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE)"
	@echo "Cleaned data/ and gen/ directories."

