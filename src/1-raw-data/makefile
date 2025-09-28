# Stage 1 — download raw data (single run via a stamp)
.SILENT:
.DELETE_ON_ERROR:

DATA := ../../data
ROOT := $(abspath ../..)

.PHONY: all
all: $(DATA)/photos.csv $(DATA)/business.csv

# Both CSVs depend on the same "done" stamp
$(DATA)/photos.csv $(DATA)/business.csv: $(DATA)/.downloaded

$(DATA)/.downloaded: download.R
	R -e "dir.create('$(DATA)', recursive = TRUE)"
	Rscript -e "setwd('$(ROOT)'); source('src/1-raw-data/download.R')"
	@touch $@

