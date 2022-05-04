#' URL by School Name Generator
#'
#' Finds the university's URL using its name.
#'
#' @param school_name A character value indicating the name of the university.
#' @import rvest
#' @import stringr
#' @import dplyr
#' @import polite
#' @export
#' @return A character value as the URL corresponding to the university of interest.
#' @examples
#' get_all_schools('Iowa State University')

get_all_schools <- function(school_name) {
  stopifnot("Input value must be a character!" = is.character(school_name))
  stopifnot("Input character must be length 1!" = length(school_name) == 1)

  school_name <- str_replace_all(school_name, " ", "+")
  url <- paste0("https://www.ratemyprofessors.com/search/schools?query=", school_name)

  # Read the webpage with polite
  session <- bow(url)
  webpage <- scrape(session)

  Links <- webpage %>%
    html_nodes(".bJboOI") %>%
    html_attr("href")

  School_list <- c()

  for (i in 1:length(Links)) {
    Name <- read_html(Links[i]) %>%
      html_nodes(".result-name") %>%
      html_text() %>%
      str_remove_all("[\r,\n,\t]") %>%
      str_trim(side = "both")

    School_list <- append(School_list, Name)
  }

  return(Links[1])
}


