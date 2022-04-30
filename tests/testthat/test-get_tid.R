test_that("get_tid inputs work", {
  expect_error(get_tid(123))
  expect_error(get_tid(list(1:2, 1:2)))
  expect_error(get_tid(data.frame(a = 1:2, b = 3:4)))
  expect_error(get_tid(matrix(1:4, 2)))
  expect_error(get_tid(factor(c("a", "b"))))
  expect_error(get_tid(c("a", "b")))
})


test_that("get_tid outputs work", {
  name <- "Brakor"
  department <- "Biology"
  university <- "California Berkeley"

  out <- get_tid(name = name)
  expect_type(out, "list")
  expect_length(out, 4)
  expect_named(out, c('tID', 'name', 'department', 'university'))

  expect_s3_class(out, c('tbl_df', 'tbl', 'data.frame'))

  expect_type(out$tID, "double")

  expect_type(out$name, "character")

  expect_type(out$department, "character")

  expect_type(out$university, "character")

  out <- get_tid(name = name, department = department)
  expect_type(out, "list")
  expect_length(out, 4)
  expect_named(out, c('tID', 'name', 'department', 'university'))

  expect_s3_class(out, c('tbl_df', 'tbl', 'data.frame'))

  expect_type(out$tID, "double")

  expect_type(out$name, "character")

  expect_type(out$department, "character")

  expect_type(out$university, "character")

  out <- get_tid(name = name, university = university)
  expect_type(out, "list")
  expect_length(out, 4)
  expect_named(out, c('tID', 'name', 'department', 'university'))

  expect_s3_class(out, c('tbl_df', 'tbl', 'data.frame'))

  expect_type(out$tID, "double")

  expect_type(out$name, "character")

  expect_type(out$department, "character")

  expect_type(out$university, "character")

  out <- get_tid(name = name, department = department, university = university)
  expect_type(out, "list")
  expect_length(out, 4)
  expect_named(out, c('tID', 'name', 'department', 'university'))

  expect_s3_class(out, c('tbl_df', 'tbl', 'data.frame'))

  expect_type(out$tID, "double")

  expect_type(out$name, "character")

  expect_type(out$department, "character")

  expect_type(out$university, "character")
})
