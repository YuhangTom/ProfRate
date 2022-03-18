#' Ratings Summarizer
#'
#' Summarize all rating information for an instructor
#'
#' @param url A Character value indicating the url of the webpage corresponding to an instructor
#' @param ifplot Show the bar plots for overall quality and difficulty for an instructor
#' @export
#' @import rvest
#' @import stringr
#' @import ggplot2
#' @return A list with eight elements
#' \itemize{
#'   \item n_ratings - Number of ratings
#'   \item percent_take_again - Percentage of students that would take again
#'   \item difficulty - Summary statistics for difficulty ratings
#'   \item take_again_logic - A logical vector indicating the response of taking again
#'   \item for_credit_logic - A logical vector indicating the response of for credit
#'   \item textbooks_logic - A logical vector indicating the response of textbooks needed
#'   \item attendance_logic - A logical vector indicating the response of attendance needed
#'   \item grade_key - A character vector showing students' grades
#' }
#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' ratings_summ(url = url)
#' ratings_summ(url = url, ifplot = TRUE)
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=1801125'
#' ratings_summ(url = url)
#' ratings_summ(url = url, ifplot = TRUE)

ratings_summ <- function(url, ifplot = FALSE){
  ### Read the webpage
  webpage <- read_html(url)

  ### Get quality
  quality <- webpage %>% html_nodes(".kMhQxZ") %>% html_text() %>% as.numeric

  ### Get difficulty
  difficulty <- webpage %>% html_nodes(".cDKJcc") %>% html_text() %>% as.numeric

  ### Number of ratings
  n_ratings <-length(quality)

  ### Plot when ifplot = TRUE
  ### Factor, make a data frame and plot
  if (ifplot){
    quality_plot <- quality %>% factor(., levels = seq(0, 5, 0.5)) %>% data.frame(Quality = .) %>%
      ggplot(aes(x = Quality)) +
      geom_bar()
      scale_x_discrete(drop=FALSE)
    print(quality_plot)

    difficulty_plot <- difficulty %>% factor(., levels = seq(0, 5, 0.5)) %>% data.frame(Difficulty = .) %>%
      ggplot(aes(x = Difficulty)) +
      geom_bar() +
      scale_x_discrete(drop=FALSE)
    print(difficulty_plot) %>% suppressWarnings()
  }

  ### Follows the order of questions on questionnaire version 3/17/2022.
  ### Take again; for credit; textbook; attendance; grade
  detail_ratings <- webpage %>% html_nodes(".fPJDHT") %>% html_text()

  take_again <- detail_ratings %>% str_extract("Would Take Again: Yes|Would Take Again: No")
  ### Transform as logical vector
  take_again_logic <- take_again == "Would Take Again: Yes"
  ### Percentage that would take again
  percent_take_again <- sum(take_again_logic, na.rm = TRUE) / n_ratings

  for_credit <- detail_ratings %>% str_extract("For Credit: Yes|For Credit: No")
  ### Transform as logical vector
  for_credit_logic <- for_credit == "For Credit: Yes"

  textbooks <- detail_ratings %>% str_extract("Textbook: Yes|Textbook: No")
  ### Transform as logical vector
  textbooks_logic <- textbooks == "Textbook: Yes"

  attendance <- detail_ratings %>% str_extract("Attendance: Mandatory|Attendance: Not Mandatory")
  ### Transform as logical vector
  attendance_logic <- attendance == "Attendance: Mandatory"

  grade <- detail_ratings %>% str_extract("Grade: [:upper:][:^alnum:]*|Grade: Audit/No Grade|Grade: Drop/Withdrawal|Grade: Incomplete|Grade: Not sure yet|Grade: Rather not say")
  ### Get the grades
  grade_key <- grade %>% str_sub(start = 8L)

  ### Ouptut
  list(n_ratings = n_ratings, percent_take_again = percent_take_again, difficulty = summary(difficulty), take_again_logic = take_again_logic, for_credit_logic = for_credit_logic, textbooks_logic = textbooks_logic, attendance_logic = attendance_logic, grade_key = grade_key)
}









