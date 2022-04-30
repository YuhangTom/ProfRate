#' Provides positive words and negative words extracted from comments, and tags from the website.
#'
#' @param url A Character value indicating the url of the webpage corresponding to an instructor.
#' @param y A number indicating the user are interested in comments after that year.
#' @param word A string indicating the user are interested in positive words, or negative words, or tags.
#' @import rvest
#' @import stringr
#' @import tidytext
#' @import dplyr
#' @import wordcloud2
#' @import polite
#' @export
#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' sentiment_info(url = url, y = 2018, word = "Negative")

sentiment_info <- function(url = url, y = 2018, word = "Positive"){
  # Reading the Webpage with polite
  session <- bow(url)
  webpage <- scrape(session)

  comment_df <- comment_info(u = url, y = y)

  # Stop further analysis if fewer than 1 comment
  stopifnot("Fewer than 1 comment!" = nrow(comment_df) > 1)

  # Sentiment analysis of words in all comments, using sentiment lexicons "bing"
  # from Bing Liu and collaborators
  comment_sentiment <- comment_df %>%
    unnest_tokens(word, comments, drop = FALSE) %>%
    inner_join(get_sentiments("bing"))

  # Filter and sort positive words by frequency
  sentiment <- NULL

  positive <- comment_sentiment %>%
    filter(sentiment == "positive") %>%
    group_by(word) %>%
    count(sort = TRUE)

  # Filter and sort negative words by frequency
  negative <- comment_sentiment %>%
    filter(sentiment == "negative") %>%
    group_by(word) %>%
    count(sort = TRUE)

  # Extract Tags
  tags <- data.frame(tags = html_text(html_nodes(webpage, '.hHOVKF'))) %>%
    group_by(tags) %>%
    count(sort = TRUE)

  if(word == "Positive"){
    return(positive)
  }else if(word == "Negative"){
    return(negative)
  }else{
    return(tags)
  }
}
