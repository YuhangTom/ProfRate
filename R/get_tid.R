#' Professor ID Extractor
#'
#' Extracts the professor's ID and combines it with general information.
#'
#' @param name A character value of the professor's full name (required).
#' @param department A character value of the professor's department (optional).
#' @param university A character value of the professor's university (required).
#'
#' @import rvest
#' @import stringr
#' @import polite
#' @import purrr
#' @export
#'
#' @return A tibble of the professor's ID and the general information with 4 columns
#' \itemize{
#'   \item tID - ID of the professor
#'   \item name - Full name of the professor
#'   \item department - The department of the professor
#'   \item university - The university of the professor
#' }
#' @examples
#' name <- "Brakor"
#' department <- "Biology"
#' university <- "California Berkeley"
#' get_tid(name = name, university = university)
#' get_tid(name = name, department = department, university = university)

get_tid <- function(name, department = NULL, university) {
  ### Check for input
  stopifnot("Input name must be a character value!" = is.character(name))
  stopifnot("Input university must be a character value!" = is.character(university))
  if (!is.null(department)) {
    stopifnot("Input department must be a character value!" = is.character(department))
  }

  ### Get school id
  sID <- get_all_schools(university) %>% str_extract("[0-9]+")

  ### Make url
  name <- str_replace(name, " ", "+")
  url <- str_c("https://www.ratemyprofessors.com/search/teachers?query=", name, "&sid=", sID)

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

  ### Get general info
  info <- map_dfr(tID, function(tid) {
    url <- str_c("https://www.ratemyprofessors.com/ShowRatings.jsp?tid=", tid)
    general_info(url = url)
  })

  out <- tibble(tID = tID, info)

  ### Filter output
  if (is.null(department)) {
    return(out)
  } else if (!is.null(department)) {
    return(out[str_detect(toupper(out$department), toupper(department)), ])
  }
}
