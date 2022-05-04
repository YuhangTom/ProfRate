#' Ratings Summarizer
#'
#' Extracts and summarizes all rating information for an instructor.
#'
#' @param url A character value indicating the URL of the webpage corresponding to an instructor.
#' @param y A number indicating the user are interested in ratings after that year.
#' @import rvest
#' @import stringr
#' @import dplyr
#' @import polite
#' @export
#' @return A list of the number of ratings after filtering and 2 data frames
#' \itemize{
#'   \item n - Number of ratings after filtering
#'   \item ratings - All rating information after a given year
#'   \item summary - Summary statistics

#' }
#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' ratings_info(url = url)

ratings_info <- function(url, y = 2018) {
  ### Check for input
  stopifnot("Input url must be a character value!" = is.character(url))
  stopifnot("Input url must from Rate My Professors!" = str_detect(url, "https://www.ratemyprofessors.com/.+"))

  ### Read the webpage with polite
  session <- bow(url)
  webpage <- scrape(session)

  ### Overall rating
  rating <- html_text(html_nodes(webpage, ".EmotionLabel__StyledEmotionLabel-sc-1u525uj-0"))
  rating <- rating[seq(1, length(rating), 2)]
  rating[str_detect(rating, "awful")] <- 1
  rating[str_detect(rating, "average")] <- 3
  rating[str_detect(rating, "awesome")] <- 5
  rating <- as.numeric(rating)

  ### Extract commenting year
  dates <- html_text(html_nodes(webpage, ".BlaCV"))
  dates <- dates[seq(1, length(dates), 2)]
  year <- str_sub(dates, start = -4)

  ### Extract course name
  course <- html_text(html_nodes(webpage, ".gxDIt"))
  course <- course[seq(1, length(course), 2)]

  quadiff <- webpage %>%
    html_nodes(".CardNumRating__CardNumRatingNumber-sc-17t4b9u-2") %>%
    html_text() %>%
    as.numeric()

  ### Get quality
  quality <- quadiff[seq(1, length(quadiff), 2)]

  ### Get difficulty
  difficulty <- quadiff[seq(2, length(quadiff), 2)]


  ### Follows the order of questions on questionnaire version 3/17/2022.
  ### Take again; for credit; textbook; attendance; grade
  detail_ratings <- webpage %>%
    html_nodes(".fPJDHT") %>%
    html_text()

  take_again <- detail_ratings %>% str_extract("Would Take Again: Yes|Would Take Again: No")
  ### Transform as logical vector
  take_again_logic <- take_again == "Would Take Again: Yes"

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

  Year <- NULL
  rating_raw <- data.frame(
    Year = year,
    Course = course,
    Overall = rating,
    Quality = quality,
    Difficulty = difficulty,
    Take_again = take_again_logic,
    For_credit = for_credit_logic,
    Textbooks = textbooks_logic,
    Attendance = attendance_logic,
    Grade = grade_key
  )

  rating_df <- rating_raw %>%
    filter(Year >= y)

  n_filtered <- nrow(rating_df)

  rating_summ <- data.frame(
    avgRating = round(mean(rating_df$Overall), 2),
    avgQuality = round(mean(rating_df$Quality), 2),
    avgDifficulty = round(mean(rating_df$Difficulty), 2),
    percentTakeAgain = round(100 * sum(rating_df$Take_again, na.rm = TRUE) / n_filtered, 2),
    percentForCredit = round(100 * sum(rating_df$For_credit, na.rm = TRUE) / n_filtered, 2),
    percentTextbook = round(100 * sum(rating_df$Textbooks, na.rm = TRUE) / n_filtered, 2),
    percentAttendance = round(100 * sum(rating_df$Attendance, na.rm = TRUE) / n_filtered, 2)
  )

  ### Output
  list(n = n_filtered, ratings = rating_df, summary = rating_summ)
}
