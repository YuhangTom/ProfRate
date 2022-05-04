#' Sentiment Plot
#'
#' A wordcloud of sentiment information extracted from comments and tags from the website.
#'
#' @param url A character value indicating the URL of the webpage corresponding to an instructor.
#' @param y A number indicating the user are interested in comments after that year.
#' @param word A string indicating the user is interested in positive words, negative words, or tags.
#' @import wordcloud2
#' @export
#' @return A wordcloud
#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' sentiment_plot(url = url, y = 2018, word = "Positive")


sentiment_plot <- function(url, y = 2018, word = "Positive") {
  sentiment_df <- sentiment_info(url = url, y = y, word = word)

  wordcloud2(sentiment_df, backgroundColor = "transparent", size = 1, color = "random-dark")
}

