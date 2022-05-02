test_that("ratings_plot output works", {
  ### Inputs are checked in ratings_summ()

  ### Check output
  url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
  out <- ratings_plot(url = url)

  expect_visible(out)
  expect_type(out, "list")
  expect_s3_class(out, c('gtable','gTree','grob','gDesc'))
})
