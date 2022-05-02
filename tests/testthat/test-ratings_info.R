test_that("ratings_info inputs work", {
  expect_error(ratings_info(123))
  expect_error(ratings_info(list(1:2, 1:2)))
  expect_error(ratings_info(data.frame(a = 1:2, b = 3:4)))
  expect_error(ratings_info(matrix(1:4, 2)))
  expect_error(ratings_info(factor(c("a", "b"))))
  expect_error(ratings_info(c("a", "b")))
})


test_that("ratings_info outputs work", {
  url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
  out <- ratings_info(url = url)
  expect_type(out, "list")
  expect_length(out, 3)
  expect_named(out, c("n", "ratings", "summary"))

  expect_s3_class(out$ratings, c("data.frame"))
  expect_s3_class(out$summary, c("data.frame"))

})
