# ------------------------------------------------
# EXACT-style "Variable | Description" table (gt)
# ------------------------------------------------

# 1) Packages
pkgs <- c("dplyr","readr","readxl","tibble","tools","gt")
to_install <- pkgs[!pkgs %in% installed.packages()[,"Package"]]
if (length(to_install)) install.packages(to_install, dependencies = TRUE)
invisible(lapply(pkgs, library, character.only = TRUE))

# 2) File path (CSV or Excel)
file_path <- "finaldataset.csv"   # change if needed

# 3) Read data (auto by extension)
ext <- tolower(tools::file_ext(file_path))
dat <- switch(
  ext,
  "xlsx" = readxl::read_excel(file_path),
  "xls"  = readxl::read_excel(file_path),
  "csv"  = readr::read_csv(file_path, show_col_types = FALSE),
  stop("Use a .csv, .xlsx, or .xls file.")
)

# 4) Variables from your dataset (preserve order)
vars_tbl <- tibble::tibble(Variable = names(dat))

# 5) Descriptions — short, “The …” phrasing like the picture
desc_lookup <- tibble::tribble(
  ~Variable,          ~Description,
  "business_id",      "The unique Yelp ID of the business.",
  "name",             "The business name as shown on Yelp.",
  "attributes",       "The map on Yelp of a restaurant’s amenities, services, and policies.",
  "categories",       "The list of Yelp categories of cuisines for the business.",
  "stars",            "The average Yelp scale star rating (1–5).",
  "review_count",     "The total number of Yelp reviews.",
  "environment",      "The number of environment photos.",
  "food & drink",     "The number of food & drink photos.",
  "menu",             "The number of menu photos.",
  "total_photos",     "The total number of photos for the business."
)

# 6) Merge names with descriptions (blank if not specified)
table_data <- vars_tbl %>%
  dplyr::left_join(desc_lookup, by = "Variable") %>%
  dplyr::mutate(Description = dplyr::if_else(is.na(Description), "", Description))

# 7) Render to match the screenshot style
tbl_gt <- table_data %>%
  gt::gt() %>%
  gt::cols_label(Variable = "Variable", Description = "Description") %>%
  gt::cols_align("left", columns = c(Variable, Description)) %>%
  gt::cols_width(Variable ~ gt::px(260), Description ~ gt::px(620)) %>%
  # header band + stripe rows like the picture
  gt::opt_row_striping() %>%
  gt::tab_style(
    style = gt::cell_text(weight = "bold"),
    locations = gt::cells_column_labels(everything())
  ) %>%
  # subtle grid/borders + padding tuned to the screenshot
  gt::tab_options(
    table.width = gt::px(900),
    table.border.top.color = "#d9d9d9",
    table.border.bottom.color = "#d9d9d9",
    column_labels.background.color = "#f2f2f2",
    column_labels.border.top.color = "#d9d9d9",
    column_labels.border.bottom.color = "#d9d9d9",
    row.striping.background_color = "#f7f7f7",
    data_row.padding = gt::px(8),
    column_labels.padding = gt::px(10)
  ) %>%
  # faint horizontal separators like the screenshot
  gt::tab_style(
    style = gt::cell_borders(
      sides = "top",
      color = "#e6e6e6",
      weight = gt::px(1)
    ),
    locations = gt::cells_body(rows = gt::everything())
  )

# 8) View and save
tbl_gt
gt::gtsave(tbl_gt, "variables_table_clean_exact.html")
# If you also want PNG: install.packages("webshot2"); gt::gtsave(tbl_gt, "variables_table_clean_exact.png")

