#' Plot a bar plot for the difficulty of a course for an instructor
#'
#' @param url A character value corresponding to the instructor of interest
#' @import dplyr
#' @export
#' @examples
#' plot_difficulty("https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2353616")

plot_difficulty <- function(url){

  # Get Ratings
  A = ratings_summ(url)

  # Plot
  factor(A$difficulty, levels = c(1, 2, 3, 4, 5)) %>%
    table() %>%
    barplot(col='green',
            density=15,
            angle=45,
            width=5,
            main = 'Course Difficulty')

}
