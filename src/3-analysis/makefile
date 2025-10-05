# Stage 3 — Analysis and visualization

# Ensure compatibility with Windows systems
MAKE := "$(MAKE)"

TEMP := ../../gen/temp
OUT  := ../../gen/output
ROOT := $(abspath ../..)

.PHONY: all
all: $(OUT)/analysis_done.txt

# Run the existing visualize.R script (no changes needed in the script itself)
$(OUT)/analysis_done.txt: visualize.R $(TEMP)/final_dataset.csv
	R -e "dir.create('$(OUT)', recursive = TRUE)"
	Rscript -e "setwd('$(ROOT)'); source('src/3-analysis/visualize.R')"
	@echo "Analysis completed successfully." > $(OUT)/analysis_done.txt
