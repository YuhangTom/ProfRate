#' Professor ID Extractor
#'
#' Extracts professor's ID and combines with general information.
#'
#' @param name A character value of the professor's name.
#' @param department A character value of the professor's department.
#' @param university A character value of the professor's university.
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
#'   \item name - Complete name of the professor
#'   \item department - The department of the professor
#'   \item university - The unversity of the professor
#' }
#' @examples
#' name <- "Brakor"
#' department <- "Biology"
#' university <- "California Berkeley"
#' get_tid(name = name)
#' get_tid(name = name, department = department)
#' get_tid(name = name, university = university)
#' get_tid(name = name, department = department, university = university)

get_tid <- function(name, department = NULL, university = NULL) {
  ### Non of the input are case sensitive or full

  ### Check for input
  stopifnot("Input name must be a character value!" = is.character(name))
  if (!is.null(department)) {
    stopifnot("Input department must be a character value!" = is.character(department))
  }
  if (!is.null(university)) {
    stopifnot("Input university must be a character value!" = is.character(university))
  }

  ### Make url
  name <- str_replace(name, " ", "+")
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

  ### Get general info
  info <- map_dfr(tID, function(tid) {
    url <- str_c("https://www.ratemyprofessors.com/ShowRatings.jsp?tid=", tid)
    general_info(url = url)
  })

  out <- tibble(tID = tID, info)

  ### Filter output
  if (is.null(department) & is.null(university)) {
    return(out)
  } else if (!is.null(department) & is.null(university)) {
    return(out[str_detect(toupper(out$department), toupper(department)), ])
  } else if (is.null(department) & !is.null(university)) {
    return(out[str_detect(toupper(out$university), toupper(university)), ])
  } else if (!is.null(department) & !is.null(university)) {
    return(out[str_detect(toupper(out$department), toupper(department)) & str_detect(toupper(out$university), toupper(university)), ])
  }
}
