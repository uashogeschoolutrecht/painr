## extract .R scripts from .Rmd

rmds <- list.files(here::here(
  "Rmd"),
  full.names = TRUE,
  pattern = "\\.Rmd"
)

rmds

new_names <- map(
  .x = rmds,
  .f = basename
)

new_names <- map(
  .x = new_names,
  tools::file_path_sans_ext
)


new_names <- file.path("inst", paste0(new_names, ".R"))
new_names

walk2(
  .x = rmds,
  .y = new_names,
  .f = knitr::purl
)
