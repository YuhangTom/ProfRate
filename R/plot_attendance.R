#' Creates a bar plot for the attendance type for an instructor
#'
#' @param url A character value corresponding to the instructor of interest
#' @import dplyr
#' @import ggplot2
#' @export
#' @examples
#' url <- 'https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448'
#' plot_attendance(url = url)

plot_attendance <- function(url) {

  # Get Ratings
  A <- ratings_summ(url)

  # Plot
  atte <- factor(A$attendance_logic, labels = c("Not Mandatory", "Mandatory")) %>% table()

  tibble(
    Attendance = 1:2 %>% factor(labels = c("Not Mandatory", "Mandatory")),
    Counts = c(atte)
  ) %>%
    ggplot(aes(x = Attendance, y = Counts)) +
    geom_bar(stat = "identity", , fill = "skyblue") +
    labs(title = "Barplot for attendance type for an instructor.")
}


