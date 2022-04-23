#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(wordcloud2)
library(ProfRate)
library(polite)


ui <- fluidPage(
  titlePanel("Professor's Key Words"),
  sidebarLayout(
    sidebarPanel(
      textInput("Url", "Please input the url of your interested professor on https://www.ratemyprofessors.com/: ", "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448"),
      selectInput("WordType", "What types of words you are interested in:", choices = c("Positive", "Negative", "Tags"), selected = "Positive"),
      selectInput("Year", "Show results after year:", choices = c(2011:2021))
    ),
    mainPanel(
      tags$ol(
        tags$li("You can have an idea of what words are most frequently used in comments on ratemyprofessors.com."),
        tags$li("You can choose to see: positive words from comments, negative words from comments, or tags from the website."),
        tags$li("You can choose only to see comments after a specific year.")
      ),
      wordcloud2Output("WC")
    )
  )
)



server <- function(input, output) {
  url <- reactive({
    input$Url
  })
  year <- reactive({
    input$Year
  })
  WT <- reactive({
    input$WordType
  })

  output$WC <- renderWordcloud2({
    comment_info(url(), year(), WT()) %>%
      wordcloud2()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
