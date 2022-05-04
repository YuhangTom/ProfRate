#' Comments Extractor
#'
#' Extracts comments together with course, year, number of thumbs-ups, and number of thumbs-downs, and filters by year.
#'
#' @param url A character value indicating the URL of the professor's webpage.
#' @param y A numeric value to filter comments after a certain year.
#' @import rvest
#' @import stringr
#' @import tidytext
#' @import dplyr
#' @import polite
#' @export
#' @return A data frame with 5 columns
#' \itemize{
#'   \item course - Course code
#'   \item year - Delivery year of the course
#'   \item comments - Comments on the professor
#'   \item thumbsup - Number of thumbs-up
#'   \item thumbsdown - Number of thumbs-down
#' }
#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' comment_info(url = url, y = 2018)

comment_info <- function(url, y = 2018) {

  # Check for input
  stopifnot("Input url must be a character value!" = is.character(url))
  stopifnot("Input url must from Rate My Professors!" = str_detect(url, "https://www.ratemyprofessors.com/.+"))

  # Reading the Webpage with polite
  session <- bow(url)
  webpage <- scrape(session)

  # Extract course name
  course <- html_text(html_nodes(webpage, ".gxDIt"))
  course <- course[seq(1, length(course), 2)]

  # Extract commenting year
  dates <- html_text(html_nodes(webpage, ".BlaCV"))
  dates <- dates[seq(1, length(dates), 2)]
  year <- str_sub(dates, start = -4)

  # Extract comments
  comments <- html_text(html_nodes(webpage, ".gRjWel"))

  # Extract reations
  reation <- html_text(html_nodes(webpage, ".kAVFzA"))
  up <- reation[seq(1, length(reation), 2)]
  down <- reation[seq(2, length(reation), 2)]

  # Combine all information extracted into a data frame comment_df:
  # Course name, year of the comment, content of the comment,
  # Number of thumbs-up, number of thumbs-down
  # Filter according to user's request
  comment_df <- data.frame(
    course = course,
    year = as.numeric(year),
    comments = comments,
    thumbsup = up,
    thumbsdown = down
  ) %>%
    filter(year >= y)
  return(comment_df)
}
