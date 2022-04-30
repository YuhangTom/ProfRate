#' Gets teacher IDs
#'
#' Gets teacher IDs and general information by name.
#'
#' @param name A character value which is the name of an instructor
#'
#' @export
#'
#' @import rvest
#' @import stringr
#' @import polite
#' @import purrr
#'
#' @return A tibble of teacher ID and general information
#' @examples
#' name <- "Brakor"
#' get_tid(name = name)

get_tid <- function(name) {
  ### Check for input
  stopifnot("Input must be a character value!" = is.character(name))

  ### Make url
  url <- str_c("https://www.ratemyprofessors.com/search/teachers?query=", name)

  ### Read the webpage with polite
  session <- bow(url)
  webpage <- scrape(session)

  ### Get tid
  tID <- webpage %>%
    html_text(".TeacherCard__StyledTeacherCard-syjs0d-0.dLJIlx") %>%
    str_extract_all('\\"legacyId\\":[0-9]+') %>%
    unlist() %>%
    str_remove_all('\\"legacyId\\":') %>%
    as.numeric()

  info <- map_dfr(tID, function(tid) {
    url <- str_c("https://www.ratemyprofessors.com/ShowRatings.jsp?tid=", tid)
    general_info(url = url)
  })

  tibble(tID = tID, info)
}
