library(rvest)
library(dplyr)
library(stringr)


# Source to look up
"https://github.com/Nobelz/RateMyProfessorAPI/blob/master/ratemyprofessor/__init__.py"



get_ProfName <- function(ProfName){
  ProfName = str_replace_all(ProfName, ' ', '+')
  paste0("https://www.ratemyprofessors.com/search/teachers?query=", ProfName) %>%
    read_html() %>%
    html_nodes('.kdXwyM') %>%
    html_text() %>%
    return()
}




# Approach 1: RVEST

read_html("https://www.ratemyprofessors.com/search/teachers?query=%Heike+Hofmann") %>%
  html_node('.fVETNc') %>%
  html_text()
  html_attr('href')




# Approach 2: Using JSON
data <- jsonlite::fromJSON(url)



### Approach 3: RSelenium Way
library(RSelenium)

client_server <- RSelenium::rsDriver()
remDr <- rD[["client"]]
driver$navigate("https://www.google.com/")







