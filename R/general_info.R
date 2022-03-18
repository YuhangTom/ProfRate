#' General Info Finder
#'
#' Extracts General Information for an Instructor
#'
#' @param url A Character value indicating the url of the webpage corresponding to an instructor
#' @export
#' @import rvest
#' @import stringr
#' @return A list with two elements
#' \itemize{
#'   \item name - Complete Name of the Instructor
#'   \item place - The department and university of the instructor
#' }
#' @examples
#' general_info(url = 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448')
#' general_info(url = 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=1801125')

general_info <- function(url){
  # Check for input
  stopifnot("Input url must be a character value!" = is.character(url))
  stopifnot("Input url must from Rate My Professors!" = str_detect(url, "https://www.ratemyprofessors.com/.+"))

  # Reading the Webpage
  webpage = read_html(url)

  # Extract Name
  name = html_text(html_nodes(webpage, '.cfjPUG'))
  name = str_to_title(name)
  name = str_trim(name, side = 'both')

  # Extract Place
  place = html_text(html_nodes(webpage, '.iLYGwn'))
  place = str_trim(place, side = 'both')

  # Output
  output = list(name=name, place=place)
  return(output)
}
