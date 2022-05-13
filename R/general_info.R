#' General Info Extractor
#'
#' Extracts general information on a professor.
#'
#' @param url A character value indicating the URL of the professor's webpage.
#' @import rvest
#' @import stringr
#' @import dplyr
#' @import polite
#' @export
#' @return A list with three elements
#' \itemize{
#'   \item name - Complete name of the professor
#'   \item department - The department of the professor
#'   \item university - The university of the professor
#' }
#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' general_info(url = url)

general_info <- function(url) {
  # Check for input
  stopifnot("Input url must be a character value!" = is.character(url))
  stopifnot("Input url must from Rate My Professors!" = str_detect(url, "https://www.ratemyprofessors.com/.+"))

  # Reading the Webpage
  session <- bow(url)
  webpage <- scrape(session)

  # Extract Name
  name <- html_text(html_nodes(webpage, ".cfjPUG"))
  name <- str_to_title(name)
  name <- str_trim(name, side = "both")

  # Extract Place
  department <- webpage %>%
    html_nodes("b") %>%
    html_text() %>%
    str_trim(side = "both")

  university <- webpage %>%
    html_nodes(".iLYGwn a") %>%
    html_text() %>%
    str_trim(side = "both")

  # Output
  output <- list(name = name, department = department, university = university)
  return(output)
}
