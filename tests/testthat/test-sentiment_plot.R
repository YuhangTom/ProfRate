test_that("sentiment_plot output works", {
  ### Inputs are checked in ratings_summ()

  ### Check output
  url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
  out <- sentiment_plot(url = url)

  expect_visible(out)
  expect_type(out, "list")
  expect_s3_class(out, c('wordcloud2', 'htmlwidget'))
})
