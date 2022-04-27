test_that("ratings_summ inputs work", {
  expect_error(ratings_summ(123))
  expect_error(ratings_summ(list(1:2, 1:2)))
  expect_error(ratings_summ(data.frame(a = 1:2, b = 3:4)))
  expect_error(ratings_summ(matrix(1:4, 2)))
  expect_error(ratings_summ(factor(c("a", "b"))))
  expect_error(ratings_summ(c("a", "b")))
})


test_that("ratings_summ outputs work", {
  url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
  out <- ratings_summ(url = url)
  expect_type(out, "list")
  expect_length(out, 9)
  expect_named(out, c("n_ratings", "percent_take_again", "quality", "difficulty", "take_again_logic", "for_credit_logic", "textbooks_logic", "attendance_logic", "grade_key"))

  expect_length(out$n_ratings, 1)
  expect_type(out$n_ratings, "integer")
  expect_gte(out$n_ratings, 0)

  expect_length(out$percent_take_again, 1)
  expect_type(out$percent_take_again, "double")
  expect_gte(out$percent_take_again, 0)
  expect_lte(out$percent_take_again, 1)

  expect_type(out$quality, "double")
  expect_vector(out$quality, size = out$n_ratings)

  expect_type(out$difficulty, "double")
  expect_vector(out$difficulty, size = out$n_ratings)

  expect_type(out$take_again_logic, "logical")
  expect_vector(out$take_again_logic, size = out$n_ratings)

  expect_type(out$for_credit_logic, "logical")
  expect_vector(out$for_credit_logic, size = out$n_ratings)

  expect_type(out$textbooks_logic, "logical")
  expect_vector(out$textbooks_logic, size = out$n_ratings)

  expect_type(out$attendance_logic, "logical")
  expect_vector(out$attendance_logic, size = out$n_ratings)

  expect_type(out$grade_key, "character")
  expect_vector(out$grade_key, size = out$n_ratings)
})
