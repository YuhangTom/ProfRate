#' Gets teacher IDs
#'
#' Gets teacher IDs and general information by the name, department and university.
#'
#' @param name A character value which is the name of an instructor.
#' @param department A character value which is the department of an instructor.
#' @param university A character value which is the university of an instructor.
#'
#' @import rvest
#' @import stringr
#' @import polite
#' @import purrr
#' @export
#'
#' @return A tibble of teacher ID and general information with 4 columns
#' \itemize{
#'   \item tID - Teacher ID for the instructor
#'   \item name - Complete name of the instructor
#'   \item department - The department of the instructor
#'   \item university - The unversity of the instructor
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
