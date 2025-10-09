# Stage 2 — Clean and aggregate data
MAKE := "$(MAKE)"

DATA := ../../gen/data
TEMP := ../../gen/temp

.PHONY: all
all: $(TEMP)/final_dataset.csv

# If raw CSVs are missing, build them via Stage 1
$(DATA)/photos.csv $(DATA)/business.csv:
	$(MAKE) -C ../1-raw-data all

# Create the cleaned and aggregated dataset
$(TEMP)/final_dataset.csv: clean.R $(DATA)/photos.csv $(DATA)/business.csv
	R -e "dir.create('$(TEMP)', recursive = TRUE)"
	Rscript clean.R
	@echo "Data preparation complete. Output saved to $(TEMP)/final_dataset.csv"