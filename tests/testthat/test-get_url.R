test_that("get_url inputs work", {
  expect_error(get_url(123))
  expect_error(get_url(list(1:2, 1:2)))
  expect_error(get_url(data.frame(a = 1:2, b = 3:4)))
  expect_error(get_url(matrix(1:4, 2)))
  expect_error(get_url(factor(c("a", "b"))))
  expect_error(get_url(c("a", "b")))
})


test_that("get_url outputs work", {
  name <- "Brakor"
  department <- "Biology"
  university <- "California Berkeley"



  out <- get_url(name = name, university = university)
  expect_type(out, "character")
  expect_length(out, 1)

  out <- get_url(name = name, department = department, university = university)
  expect_type(out, "character")
  expect_length(out, 1)
})
