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
        box(title = "Name", width = 3, solidHeader = TRUE, status = "primary",
            textInput("Name", strong("Name for a Professor (Better to be Full Name and Accurate):"), "Gilbert Strang")
        ),
        box(title = "Department", width = 2, solidHeader = TRUE, status = "primary",
            textInput("Department", strong("Department for this Professor:"), "Mathematics")
        ),
        box(title = "University", width = 2, solidHeader = TRUE, status = "primary",
            textInput("University", strong("University for this Professor:"), "Massachusetts")
        ),
        # box(title = "Url", width = 4,
        #     textInput("Url", strong("Url for a Professor:"), "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=2036448")
        # ),
        box(title = "Word Type", width = 3, solidHeader = TRUE, status = "primary",
            selectInput("WordType", strong("What Types of Words you are Interested in:"), choices = c("Positive", "Negative", "Tags"), selected = "Positive")
        ),
        box(title = "Year", width = 2, solidHeader = TRUE, status = "primary",
            selectInput("Year", strong("Show Results after Year:"), choices = c(2011:2021), selected = 2020)
        )
      ),
      fluidRow(column = 12, align="right", actionButton("update", "Update!", icon = icon("redo"))),
      fluidRow(column = 12, align="center", wordcloud2Output("WC")),
      br(),
      br(),
      fluidRow(column = 12, align="center", plotOutput("RP"))
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
  url <- eventReactive(input$update, {
    get_url(name = input$Name, department = input$Department, university = input$University)
  })
  year <- eventReactive(input$update, {
    input$Year
  })
  WT <- eventReactive(input$update, {
    input$WordType
  })

  output$WC <- renderWordcloud2({
    sentiment_info(url(), year(), WT()) %>%
      wordcloud2(backgroundColor = "transparent")
  })

  output$RP <- renderPlot({
    ratings_plot(url(), year())
  })

}

# Run the application
shinyApp(ui = ui, server = server)
