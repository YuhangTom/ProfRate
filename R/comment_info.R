#' Extracts information on comments including course, year, comments, number of thumbsups and number of thumbsdowns.
#'
#' @param u A Character value indicating the url of the webpage corresponding to an instructor.
#' @param y A number indicating the user are interested in comments after that year.
#' @import rvest
#' @import stringr
#' @import tidytext
#' @import dplyr
#' @import wordcloud2
#' @import polite
#' @export
#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' comment_info(u = url, y = 2018)

comment_info <- function(u, y = 2018){

  # Check for input
  stopifnot("Input url must be a character value!" = is.character(url))
  stopifnot("Input url must from Rate My Professors!" = str_detect(url, "https://www.ratemyprofessors.com/.+"))

  # Reading the Webpage with polite
  session <- bow(url)
  webpage <- scrape(session)

  # Extract course name
  course <- html_text(html_nodes(webpage, '.gxDIt'))
  course <- course[seq(1, length(course), 2)]

  # Extract commenting year
  dates <- html_text(html_nodes(webpage, '.BlaCV'))
  dates <- dates[seq(1, length(dates), 2)]
  year <- str_sub(dates, start = -4)

  # Extract comments
  comments <- html_text(html_nodes(webpage, '.gRjWel'))

  # Extract reations
  reation <- html_text(html_nodes(webpage, '.kAVFzA'))
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
