# Stage 3 — analysis & visualization
.SILENT:
.DELETE_ON_ERROR:

TEMP := ../../gen/temp
OUT  := ../../gen/output
ROOT := $(abspath ../..)

.PHONY: all
all: $(OUT)/Rplots.pdf

$(OUT)/Rplots.pdf: visualize.R $(TEMP)/final_dataset.csv
	R -e "dir.create('$(OUT)', recursive = TRUE)"
	Rscript -e "setwd('$(ROOT)'); source('src/3-analysis/visualize.R')"


