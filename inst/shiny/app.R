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
  width = 150,
  sidebarMenu(
    menuItem("Home", tabName = "home", icon = icon("home")),
    menuItem("Wordcloud", tabName = "wordcloud", icon = icon("cloud", lib = "glyphicon")),
    menuItem("Ratings", tabName = "ratings", icon = icon("stats", lib = "glyphicon"))
  )
)



body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "home",
      includeMarkdown("home.md")
    ),
    tabItem(
      tabName = "wordcloud",
      fluidRow(
        box(
          width = 3, solidHeader = TRUE, color = "black",
          textInput("Name1", strong("Name of a Professor (Better to be Full Name and Accurate):"), "Gilbert Strang"),
          textInput("Department1", strong("Department of this Professor:"), "Mathematics"),
          textInput("University1", strong("University of this Professor:"), "Massachusetts"),
          selectInput("WordType1", strong("What Types of Words you are Interested in:"), choices = c("Positive", "Negative", "Tags"), selected = "Positive"),
          selectInput("Year1", strong("Show Results after Year:"), choices = c(2011:2021), selected = 2020),
          div(style = "display:inline-block", actionButton("updateWC", "Refresh", icon("refresh", lib = "glyphicon"))),
          height = "35em"
        ),
        box(solidHeader = TRUE, color = "black", width = 9, wordcloud2Output("WC"), height = "35em")
      ),
      br(),
      br()
    ),
    tabItem(
      tabName = "ratings",
      fluidRow(
        box(
          width = 3, solidHeader = TRUE, color = "black",
          textInput("Name2", strong("Name of a Professor (Better to be Full Name and Accurate):")),
          textInput("Department2", strong("Department of this Professor:")),
          textInput("University2", strong("University of this Professor:")),
          selectInput("Year2", strong("Show Results after Year:"), choices = c(2011:2021)),
          div(style = "display:inline-block", actionButton("updateRP", "Refresh", icon("refresh", lib = "glyphicon"))),
          height = "30em"
        ),
        box(solidHeader = TRUE, color = "black", width = 9, plotOutput("RP"), height = "30em")
      ),
      br(),
      br(),
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

server <- function(input, output, session) {
  observe({
    updateSelectInput(session, "Name2", selected = input$Name1)
    updateSelectInput(session, "Department2", selected = input$Department1)
    updateSelectInput(session, "University2", selected = input$University1)
    updateSelectInput(session, "Year2", selected = input$Year1)
  })

  url1 <- eventReactive(input$updateWC, {
    get_url(name = input$Name1, department = input$Department1, university = input$University1)
  })

  year1 <- eventReactive(input$updateWC, {
    input$Year1
  })

  url2 <- eventReactive(input$updateRP, {
    get_url(name = input$Name2, department = input$Department2, university = input$University2)
  })

  year2 <- eventReactive(input$updateRP, {
    input$Year2
  })

  WT <- eventReactive(input$updateWC, {
    input$WordType1
  })

  output$WC <- renderWordcloud2({
    sentiment_plot(url1(), year1(), WT())
  })

  output$RP <- renderPlot({
    ratings_plot(url2(), year2())
  })
}

# Run the application
shinyApp(ui = ui, server = server)
