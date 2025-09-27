# Directories
DATA := data
GEN  := gen
TEMP := $(GEN)/temp
OUT  := $(GEN)/output

# Scripts
RAW_R   := src/1-raw-data/download.R
CLEAN_R := src/2-data-preparation/clean.R
AN_R    := src/3-analysis/analysis.R
VIS_R   := src/3-analysis/visualize.R
# REP_R := src/4-reporting/Data_reporting.R   # optional

# Artifacts
FINAL := $(TEMP)/final_dataset.csv
PLOTS := $(OUT)/stars_vs_photos.pdf $(OUT)/photos_per_category.pdf

.PHONY: all clean raw-data data-prep analysis reporting

# Build everything
all: analysis
# all: reporting   # uncomment if you add the reporting step

# ---------- Step 1: Download raw data ----------
$(DATA)/photos.csv $(DATA)/business.csv: $(RAW_R) | $(DATA)
	R -e "dir.create('$(DATA)', recursive = TRUE)"
	Rscript $(RAW_R)

raw-data: $(DATA)/photos.csv $(DATA)/business.csv

# ---------- Step 2: Clean / prepare data (run in SAME R session as download) ----------
$(FINAL): $(CLEAN_R) $(RAW_R) | $(TEMP)
	R -e "dir.create('$(TEMP)', recursive = TRUE)"
	Rscript -e "source('$(RAW_R)'); source('$(CLEAN_R)')"

# ---------- Step 3: Analysis (plots) ----------
$(PLOTS): $(AN_R) $(VIS_R) $(FINAL) | $(OUT)
	R -e "dir.create('$(OUT)', recursive = TRUE)"
	Rscript $(AN_R)
	Rscript $(VIS_R)

analysis: $(PLOTS)

# ---------- Step 4: Reporting (optional) ----------
# reporting: $(REP_R) $(FINAL)
# 	Rscript $(REP_R)

# ---------- Utilities ----------
$(DATA) $(TEMP) $(OUT):
	mkdir -p $@

clean:
	R -e "unlink('data', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE)"
