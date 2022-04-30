test_that("sentiment_info inputs work", {
  expect_error(sentiment_info(123))
  expect_error(sentiment_info(list(1:2, 1:2)))
  expect_error(sentiment_info(data.frame(a = 1:2, b = 3:4)))
  expect_error(sentiment_info(matrix(1:4, 2)))
  expect_error(sentiment_info(factor(c("a", "b"))))
  expect_error(sentiment_info(c("a", "b")))
})

test_that("sentiment_info outputs work", {
  url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
  out <- sentiment_info(url = url, word = "Positive")

  expect_type(out, "list")
  expect_length(out, 2)
  expect_named(out, c("word", "n"))
  expect_s3_class(out, c("grouped_df", "tbl_df", "tbl", "data.frame"))

  expect_type(out$word, "character")

  expect_type(out$n, "integer")

  ###
  out <- sentiment_info(url = url, word = "Negative")

  expect_type(out, "list")
  expect_length(out, 2)
  expect_named(out, c("word", "n"))
  expect_s3_class(out, c("grouped_df", "tbl_df", "tbl", "data.frame"))

  expect_type(out$word, "character")

  expect_type(out$n, "integer")

  ###
  out <- sentiment_info(url = url, word = "Tags")

  expect_type(out, "list")
  expect_length(out, 2)
  expect_named(out, c("tags", "n"))
  expect_s3_class(out, c("grouped_df", "tbl_df", "tbl", "data.frame"))

  expect_type(out$tags, "character")

  expect_type(out$n, "integer")
})
