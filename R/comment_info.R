#' Provide wordcloud plots for positive words, negative words in the comments, and tags on the website.
#'
#' @param url A Character value indicating the url of the webpage corresponding to an instructor.
#' @param y A number indicating the user are interested in comments after that year.
#' @param word A string indicating the user are interested in positive words, or negative words, or tags.
#' @import rvest
#' @import stringr
#' @import tidytext
#' @import dplyr
#' @import wordcloud2

#' @export
#' @examples
#' comment_info(url = 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448', y = 2011, word = "negative")

comment_info <- function(url, y = numeric(0), word = "positive"){

  # Check for input
  stopifnot("Input url must be a character value!" = is.character(url))
  stopifnot("Input url must from Rate My Professors!" = str_detect(url, "https://www.ratemyprofessors.com/.+"))

  # Reading the Webpage
  webpage <- read_html(url)

  # Extract course name
  course <- html_text(html_nodes(webpage, '.gxDIt'))
  course <- course[seq(1, length(course), 2)]

  # Extract commenting year
  dates <- html_text(html_nodes(webpage, '.BlaCV'))
  dates <- dates[seq(1, length(dates), 2)]
  year <- str_sub(dates, start = -4)

  # Extract comments
  comments <- html_text(html_nodes(webpage, '.gRjWel'))

  # Extract reations
  reation <- html_text(html_nodes(webpage, '.kAVFzA'))
  up <- reation[seq(1, length(reation), 2)]
  down <- reation[seq(2, length(reation), 2)]

  # Combine all information extracted into a dataframe comment_df:
  # Course name, year of the comment, content of the comment,
  # Number of thumbsup, number of thumbsdown
  # Filter according to user's request
  comment_df <- data.frame(
    course = course,
    year = as.numeric(year),
    comments = comments,
    thumbsup = up,
    thumbsdown = down
  ) %>%
    filter(year >= y)

  # Stop further analysis if fewer than 1 comment
  stopifnot("Fewer than 1 comment!" = nrow(comment_df) > 1)

  # Sentiment analysis of words in all comments, using sentiment lexicons "bing"
  # from Bing Liu and collaborators
  comment_sentiment <- comment_df %>%
    unnest_tokens(word, comments, drop = FALSE) %>%
    inner_join(get_sentiments("bing"))

  # Filter and sort positive words by frequency
  positive_words <- comment_sentiment %>%
    filter(sentiment == "positive") %>%
    group_by(word) %>%
    count(sort = TRUE)

  # Filter and sort negative words by frequency
  negative_words <- comment_sentiment %>%
    filter(sentiment == "negative") %>%
    group_by(word) %>%
    count(sort = TRUE)

  # Extract Tags
  tags <- data.frame(tags = html_text(html_nodes(webpage, '.hHOVKF'))) %>%
    group_by(tags) %>%
    count(sort = TRUE)

  if(word == "positive"){
    # Wordcloud of positive words
    positive_words %>%
      wordcloud2()
  }else if(word == "negative"){
    # Wordcloud of negative words
    negative_words %>%
      wordcloud2()
  }else{
    # Wordcloud of tags
    tags %>%
      wordcloud2()
  }

  # # Tokenize and sort bigrams by frequency
  # comment_bigrams <- comment_df %>%
  #   unnest_tokens(bigram, comments, token = "ngrams", n = 2, drop = FALSE) %>%
  #   separate(bigram, c("word1", "word2"), sep = " ") %>%
  #   filter(!word1 %in% stop_words$word,
  #          !word2 %in% stop_words$word) %>%
  #   count(word1, word2, sort = TRUE) %>%
  #   unite(bigram, word1, word2, sep = " ")
  #
  # # Wordcloud of bigrams
  # comment_bigrams%>%
  #   wordcloud(main="Title")

}
