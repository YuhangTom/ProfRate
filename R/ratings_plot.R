#' Ratings Plot
#'
#' A boxplot of all ratings and 3 barplots of average ratings by course, grade, and year.
#'
#' @param url A character value indicating the URL of the webpage corresponding to an instructor.
#' @param y A number indicating the user are interested in ratings after that year.
#' @import dplyr
#' @import tidyr
#' @import ggplot2
#' @importFrom gridExtra grid.arrange
#' @export
#' @return A plot including 4 subplots

#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' ratings_plot(url = url)



ratings_plot <- function(url, y = 2018) {
  Overall <- NULL
  Quality <- NULL
  Difficulty <- NULL
  Criterion <- NULL
  Rating <- NULL
  Course <- NULL
  Avg <- NULL
  Grade <- NULL
  Year <- NULL

  th <- theme(
    panel.background = element_rect(fill = "transparent"),
    plot.background = element_rect(fill = "transparent", color = NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.background = element_blank(),
    legend.key = element_rect(fill = NA)
  )

  o <- ratings_info(url = url, y = y)

  # boxplot of all ratings
  p1 <- o$ratings %>%
    gather(key = "Criterion", value = "Rating", Overall, Quality, Difficulty) %>%
    mutate(Criterion = factor(Criterion, levels = c("Overall", "Quality", "Difficulty"))) %>%
    ggplot(aes(x = Criterion, y = Rating, fill = Criterion)) +
    geom_boxplot() +
    scale_fill_hue(c = 40) +
    xlab("") +
    ylab("") +
    ggtitle("Overall ratings") +
    labs(fill = "") +
    th

  # barplot of avg ratings by course
  p2 <- o$ratings %>%
    gather(key = "Criterion", value = "Rating", Overall, Quality, Difficulty, -Course) %>%
    mutate(Criterion = factor(Criterion, levels = c("Overall", "Quality", "Difficulty"))) %>%
    group_by(Course, Criterion) %>%
    summarise(Avg = mean(Rating)) %>%
    ggplot(aes(x = Course, y = Avg, fill = Criterion)) +
    geom_bar(position = "dodge", stat = "identity") +
    scale_fill_hue(c = 40) +
    xlab("") +
    ylab("") +
    ggtitle("Average Ratings by Course") +
    labs(fill = "") +
    th

  # barplot of avg ratings by grade
  p3 <- o$ratings %>%
    gather(key = "Criterion", value = "Rating", Overall, Quality, Difficulty, -Grade) %>%
    mutate(Criterion = factor(Criterion, levels = c("Overall", "Quality", "Difficulty"))) %>%
    mutate(Grade = factor(Grade, levels = c("A+", "A", "B+", "B", "C+", "C", "D+", "D", "NA"))) %>%
    group_by(Grade, Criterion) %>%
    summarise(Avg = mean(Rating)) %>%
    ggplot(aes(x = Grade, y = Avg, fill = Criterion)) +
    geom_bar(position = "dodge", stat = "identity") +
    scale_fill_hue(c = 40) +
    xlab("") +
    ylab("") +
    ggtitle("Average Ratings by Grade") +
    labs(fill = "") +
    th

  p4 <- o$ratings %>%
    gather(key = "Criterion", value = "Rating", Overall, Quality, Difficulty, -Year) %>%
    mutate(Criterion = factor(Criterion, levels = c("Overall", "Quality", "Difficulty"))) %>%
    group_by(Year, Criterion) %>%
    summarise(Avg = mean(Rating)) %>%
    ggplot(aes(x = Year, y = Avg, fill = Criterion)) +
    geom_bar(position = "dodge", stat = "identity") +
    scale_fill_hue(c = 40) +
    xlab("") +
    ylab("") +
    ggtitle("Average Ratings by Year") +
    labs(fill = "") +
    th

  grid.arrange(p1, p2, p3, p4, ncol = 2)
}


