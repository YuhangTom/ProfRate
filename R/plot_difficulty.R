#' Plot a bar plot for the difficulty of a course for an instructor
#'
#' @param url A character value corresponding to the instructor of interest
#' @import dplyr
#' @import ggplot2
#' @export
#' @examples
#' plot_difficulty("https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2353616")

plot_difficulty <- function(url){

  # Get Ratings
  A = ratings_summ(url)

  # Table summary
  qual <- factor(A$quality, levels = c(1, 2, 3, 4, 5)) %>% table()
  diff <- factor(A$difficulty, levels = c(1, 2, 3, 4, 5)) %>% table()
  dat.plot <- tibble(Ratings = rep(1:5, 2) %>% factor(),
                     Counts = c(qual, diff),
                     Group = c(rep(1, 5), rep(2, 5)) %>% factor(labels = c("Quality", "Difficulty")))

  # Plot
  dat.plot %>% ggplot(aes(x = Ratings, y = Counts, fill = Group)) +
    geom_bar(stat = "identity", position=position_dodge()) +
    labs(title = "Barplot for course quality and difficulty ratings.")
}
