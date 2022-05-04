#' Sentiment Plot
#'
#' A wordcloud of common positive words and negative words extracted from comments, and tags from the website.
#'
#' @param url A character value indicating the URL of the professor's webpage.
#' @param y A numeric value to filter ratings after a certain year.
#' @param word A character value indicating the user's interest in positive words, negative words, or tags.
#' @import wordcloud2
#' @export
#' @return A wordcloud of common words or tags
#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' sentiment_plot(url = url, y = 2018, word = "Positive")


sentiment_plot <- function(url, y = 2018, word = "Positive") {
  sentiment_df <- sentiment_info(url = url, y = y, word = word)

  wordcloud2(sentiment_df, backgroundColor = "transparent", size = 1, color = "random-dark")
}

