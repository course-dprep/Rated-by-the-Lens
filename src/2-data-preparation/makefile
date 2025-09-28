# Stage 2 — clean & aggregate
.SILENT:
.DELETE_ON_ERROR:

DATA := ../../data
TEMP := ../../gen/temp
ROOT := $(abspath ../..)

.PHONY: all
all: $(TEMP)/final_dataset.csv

# If raw CSVs are missing, build them via Stage 1
$(DATA)/photos.csv $(DATA)/business.csv:
	$(MAKE) -C ../1-raw-data all

$(TEMP)/final_dataset.csv: clean.R $(DATA)/photos.csv $(DATA)/business.csv
	R -e "dir.create('$(TEMP)', recursive = TRUE)"
	Rscript -e "setwd('$(ROOT)'); source('src/2-data-preparation/clean.R')"


