test_that("get_all_schools input work", {
  expect_error(get_all_schools(123))
  expect_error(get_all_schools(list(1:2, 1:2)))
  expect_error(get_all_schools(data.frame(a = 1:2, b = 3:4)))
  expect_error(get_all_schools(matrix(1:4, 2)))
  expect_error(get_all_schools(factor(c("a", "b"))))
  expect_error(get_all_schools(c("a", "b")))
})

test_that("get_all_schools input work", {
  out <- get_all_schools('Iowa State University')

  expect_type(out, "character")
  expect_length(out, 1)
})
