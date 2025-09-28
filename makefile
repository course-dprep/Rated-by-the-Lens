.SILENT:
.DELETE_ON_ERROR:
.PHONY: all preview clean help

DATA := data
TEMP := gen/temp
OUT  := gen/output

.DEFAULT_GOAL := all
all: $(OUT)/report.pdf

$(OUT)/report.pdf: $(TEMP)/final_dataset.csv src/3-analysis/visualize.R
	$(MAKE) -C src/3-analysis all

$(TEMP)/final_dataset.csv: $(DATA)/photos.csv $(DATA)/business.csv src/2-data-preparation/clean.R
	$(MAKE) -C src/2-data-preparation all

$(DATA)/photos.csv $(DATA)/business.csv: src/1-raw-data/download.R
	$(MAKE) -C src/1-raw-data all

clean:
	R -e "unlink('$(DATA)', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE)"
	@echo "cleaned: $(DATA)/ and gen/"
