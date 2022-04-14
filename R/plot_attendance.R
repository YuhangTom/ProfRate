#' Plot a bar plot for the attendance type for an instructor
#'
#' @param url A character value corresponding to the instructor of interest
#' @import dplyr
#' @export
#' @examples
#' plot_attendance("https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2353616")

plot_attendance <- function(url){

  # Get Ratings
  A = ratings_summ(url)

  # Plot
  factor(A$attendance_logic, labels = c('Not Mandatory', 'Mandatory')) %>%
    table() %>%
    barplot(col='orange',
            density=15,
            angle=45,
            width=5,
            main = 'Attendance')

}


