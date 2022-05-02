#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(tidyverse)
library(wordcloud2)
library(ProfRate)
library(polite)


sidebar <- dashboardSidebar(
  width = 300,
  sidebarMenu(
    menuItem("Home", tabName = "home", icon = icon("home")),
    menuItem("Wordclouds", tabName = "ratings", icon = icon("stats", lib = "glyphicon"))
  )
)



body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "home",
      includeMarkdown("home.md")
    ),

    tabItem(
      tabName = "ratings",
      fluidRow(
        box(title = "Url", width = 4,
            textInput("Url", strong("Url for a Professor:"), "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448")
        ),
        box(title = "Word Type", width = 4,
            selectInput("WordType", strong("What Types of Words you are Interested in:"), choices = c("Positive", "Negative", "Tags"), selected = "Positive")
        ),
        box(title = "Year", width = 4,
            selectInput("Year", strong("Show Results after Year:"), choices = c(2011:2021))
        )
      ),
      fluidRow(column = 12, align="center", wordcloud2Output("WC"))
    )
  )
)

ui <- dashboardPage(
  ### To kind of match the color of RMP
  skin = "black",
  dashboardHeader(title = "Rate My Professor by 'ProfRate'", titleWidth = 350),
  sidebar,
  body
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
    sentiment_info(url(), year(), WT()) %>%
      wordcloud2(backgroundColor = "transparent")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
