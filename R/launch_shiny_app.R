#' Launch Shiny App
#'
#' This function launches the Shiny app included with the package.
#'
#' @export
launch_shiny_app <- function() {
  appDir <- system.file("app.R", package = "painr")
  if (appDir == "") {
    stop("Shiny app not found in the package")
  }
  shiny::runApp(appDir)
}
