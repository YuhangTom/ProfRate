test_that("general_info inputs work", {
  expect_error(general_info(123))
  expect_error(general_info(list(1:2, 1:2)))
  expect_error(general_info(data.frame(a = 1:2, b = 3:4)))
  expect_error(general_info(matrix(1:4, 2)))
  expect_error(general_info(factor(c("a", "b"))))
  expect_error(general_info(c("a", "b")))
})


test_that("general_info outputs work", {
  url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
  out <- general_info(url = url)

  expect_type(out, "list")
  expect_length(out, 3)
  expect_named(out, c("name", "department", "university"))

  expect_type(out$name, "character")
  expect_type(out$department, "character")
  expect_type(out$university, "character")
})
