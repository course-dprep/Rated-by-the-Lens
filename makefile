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

# Generate the final report
$(OUT)/report.pdf: $(TEMP)/final_dataset.csv src/3-analysis/visualize.R
	$(MAKE) -C src/3-analysis all

# Generate the cleaned dataset
$(TEMP)/final_dataset.csv: $(DATA)/photos.csv $(DATA)/business.csv src/2-data-preparation/clean.R
	$(MAKE) -C src/2-data-preparation all

# Download raw data
$(DATA)/photos.csv $(DATA)/business.csv: src/1-raw-data/download.R
	$(MAKE) -C src/1-raw-data all

# Clean temporary and output files
clean:
	R -e "unlink('$(DATA)', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE)"
	@echo "cleaned: $(DATA)/ and gen/"
