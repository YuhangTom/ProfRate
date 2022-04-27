test_that("comment_info inputs work", {
  expect_error(comment_info(123))
  expect_error(comment_info(list(1:2, 1:2)))
  expect_error(comment_info(data.frame(a = 1:2, b = 3:4)))
  expect_error(comment_info(matrix(1:4, 2)))
  expect_error(comment_info(factor(c("a", "b"))))
  expect_error(comment_info(c("a", "b")))
})

# test_that("comment_info outputs work", {
#   url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#   out <- comment_info(url = url)
#
#   expect_type(out, "list")
#   expect_length(out, 2)
#   expect_named(out, c("word", "n"))
#   expect_s3_class(out, c("grouped_df", "tbl_df", "tbl", "data.frame"))
#
#   expect_type(out$word, "character")
#
#   expect_type(out$n, "integer")
# })
