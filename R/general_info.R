#' General Info Finder
#'
#' Extracts general information for an instructor
#'
#' @param url A Character value indicating the url of the webpage corresponding to an instructor
#' @export
#' @import rvest
#' @import stringr
#' @import dplyr
#' @import polite
#' @return A list with two elements
#' \itemize{
#'   \item name - Complete Name of the Instructor
#'   \item place - The department and university of the instructor
#' }
#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' general_info(url = url)

general_info <- function(url){
  # Check for input
  stopifnot("Input url must be a character value!" = is.character(url))
  stopifnot("Input url must from Rate My Professors!" = str_detect(url, "https://www.ratemyprofessors.com/.+"))

  # Reading the Webpage
  session <- bow(url)
  webpage <- scrape(session)

  # Extract Name
  name = html_text(html_nodes(webpage, '.cfjPUG'))
  name = str_to_title(name)
  name = str_trim(name, side = 'both')

  # Extract Place
  department = webpage %>%
    html_nodes('b') %>%
    html_text() %>%
    str_trim(side = 'both')

  university <- webpage %>%
    html_nodes('.iLYGwn a') %>%
    html_text() %>%
    str_trim(side = 'both')

  # Output
  output = list(name=name, department=department, university=university)
  return(output)
}
