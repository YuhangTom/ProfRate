#' Shiny app
#'
#' Runs shiny app.
#'
#' @export
runExample <- function() {
  appDir <- system.file("shiny", package = "ProfRate")
  if (appDir == "") {
    stop("Could not find shiny directory. Try re-installing `ProfRate`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}


