## Create output datasets from Rmd files in folder ./Rmd
## All files in this folder are saved output from the Rmd files in folder ./Rmd

rmd_files <- list.files(path = here::here("Rmd"), pattern = ".Rmd", full.names = TRUE)
## Render files and create output

purrr::walk(
  .x = rmd_files,
  .f = rmarkdown::render,
  output_format = "html_document",
  output_dir = here::here("Rmd")
)

#df_imp_long <- readr::read_rds(here::here(
#  "data",
#  "df_imp_long.rds"
#))

#usethis::use_data(df_imp_long)
