#' Gets url
#'
#' Gets url by name, department and university.
#'
#' @param name A character value which is the name of an instructor
#' @param department A character value which is the department of an instructor
#' @param university A character value which is the university of an instructor
#'
#' @export
#'
#' @import stringr
#'
#' @return A vector of urls
#' @examples
#' name <- "Brakor"
#' department <- "Biology"
#' university <- "California Berkeley"
#' get_url(name = name)
#' get_url(name = name, department = department)
#' get_url(name = name, university = university)
#' get_url(name = name, department = department, university = university)

get_url <- function(name, department = NULL, university = NULL) {
  out <- get_tid(name = name, department = department, university = university)

  ### output url
  str_c("https://www.ratemyprofessors.com/ShowRatings.jsp?tid=", out$tID)
}
