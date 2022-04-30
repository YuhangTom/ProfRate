test_that("comment_info inputs work", {
  expect_error(comment_info(123))
  expect_error(comment_info(list(1:2, 1:2)))
  expect_error(comment_info(data.frame(a = 1:2, b = 3:4)))
  expect_error(comment_info(matrix(1:4, 2)))
  expect_error(comment_info(factor(c("a", "b"))))
  expect_error(comment_info(c("a", "b")))
})

test_that("comment_info outputs work", {
  url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
  out <- comment_info(url = url)

  expect_type(out, "list")
  expect_length(out, 5)
  expect_named(out, c("course", "year", "comments", "thumbsup", "thumbsdown"))
  expect_s3_class(out, c("data.frame"))

  expect_type(out$course, "character")

  expect_type(out$year, "double")

  expect_type(out$comments, "character")

  expect_type(out$thumbsup, "character")

  expect_type(out$thumbsdown, "character")
})
