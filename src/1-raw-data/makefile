# Stage 1 — Download raw data 

# Ensure compatibility with Windows systems
MAKE := "$(MAKE)"

DATA := ../../gen/data
ROOT := $(abspath ../..)

.PHONY: all
all: $(DATA)/photos.csv $(DATA)/business.csv

# Both CSVs depend on the same "done" stamp
$(DATA)/photos.csv $(DATA)/business.csv: $(DATA)/.downloaded

$(DATA)/.downloaded: download.R
	R -e "dir.create('$(DATA)', recursive = TRUE)"
	Rscript -e "setwd('$(ROOT)'); source('src/1-raw-data/download.R')"
	Rscript -e "file.create('$(DATA)/.downloaded')"
