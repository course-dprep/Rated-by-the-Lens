# Stage 4 — reporting
.SILENT:
.DELETE_ON_ERROR:

OUT  := ../../gen/output
TEMP := ../../gen/temp
ROOT := $(abspath ../..)

.PHONY: all
all: $(OUT)/report.pdf

$(OUT)/report.pdf: Data_reporting.R $(OUT)/Rplots.pdf $(TEMP)/final_dataset.csv
	R -e "dir.create('$(OUT)', recursive = TRUE)"
	Rscript -e "setwd('$(ROOT)'); if (file.exists('src/4-reporting/Data_reporting.R') && file.info('src/4-reporting/Data_reporting.R')$$size > 0) { source('src/4-reporting/Data_reporting.R') } else { file.copy('gen/output/Rplots.pdf','gen/output/report.pdf', overwrite=TRUE) }"
