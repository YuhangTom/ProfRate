test_that("plot_QualDiff output works", {
  ### Inputs are checked in ratings_summ()

  ### Check output
  url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
  out <- plot_QualDiff(url = url)

  expect_visible(out)
  expect_type(out, "list")
  expect_s3_class(out, c("gg", "ggplot"))
})
