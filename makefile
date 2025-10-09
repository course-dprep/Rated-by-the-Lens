# Main Makefile — Full Pipeline (PNG output)

MAKE := "$(MAKE)"

.PHONY: all clean

# Directory paths
DATA := gen/data
TEMP := gen/temp
OUT  := gen/output

# Default goal
.DEFAULT_GOAL := all

# Main build rule
all: $(OUT)/report.png

# Generate the final report (built by Stage 3 and copied as report.png)
$(OUT)/report.png: $(TEMP)/final_dataset.csv
	$(MAKE) -C src/3-analysis all
	Rscript -e "file.copy('$(OUT)/analysis_output.png', '$(OUT)/report.png', overwrite=TRUE)"
	@echo "All analysis and plots saved in $(OUT)"

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
