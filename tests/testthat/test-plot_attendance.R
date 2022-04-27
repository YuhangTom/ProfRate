test_that("multiplication works", {
  ### Inputs are checked in ratings_summ()

  ### Check output
  url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
  expect_visible(plot_attendance(url = url))
})
