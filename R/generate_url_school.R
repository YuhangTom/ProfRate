library(rvest)
library(dplyr)
library(stringr)




SchoolID_to_Name <- function(url){

  SchoolName = read_html(url) %>%
    html_nodes('.result-name') %>%
    html_text() %>%
    str_remove_all('[\r,\n,\t]') %>%
    str_trim(side='both')

    return(SchoolName)
}





get_all_schools <- function(school_name){

  school_name = str_replace_all(school_name, ' ', '+')
  url = paste0( "https://www.ratemyprofessors.com/search/schools?query=", school_name)

  Links = read_html(url) %>%
    html_nodes('.bJboOI') %>%
    html_attr('href')

  School_list = c()

  for (i in 1:length(Links)){
    School_list = append(School_list, SchoolID_to_Name(Links[i]))
  }
  print(School_list)
  num = readline(prompt="Which one do you want: ")
  return(Links[as.integer(num)])
}




# Example
get_all_schools('Iowa State')
