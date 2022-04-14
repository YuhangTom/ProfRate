#'Finds the university ID using its name
#'
#' @param school_name A Character value indicating the name of the university
#' @import rvest
#' @import stringr
#' @import dplyr
#' @export
#' @return A url corresponding to the university of interest
#' @examples
#' get_all_schools('Iowa State University')
#' get_all_schools('University of Iowa')

get_all_schools <- function(school_name){

  school_name = str_replace_all(school_name, ' ', '+')
  url = paste0( "https://www.ratemyprofessors.com/search/schools?query=", school_name)

  Links = read_html(url) %>%
    html_nodes('.bJboOI') %>%
    html_attr('href')

  School_list = c()

  for (i in 1:length(Links)){

    Name = read_html(Links[i]) %>%
      html_nodes('.result-name') %>%
      html_text() %>%
      str_remove_all('[\r,\n,\t]') %>%
      str_trim(side='both')

    School_list = append(School_list, Name)
  }

  return(Links[1])
}


