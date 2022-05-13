library(tidyverse)
library(shiny)

ll <- starwars %>% discard(is.list)


filterApp <- function() {
  df <- mtcars
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
           sliderInput('int_slider', 'my slider', min = -4, max = 10, value = 3, step = 1, ticks = FALSE),
           combo
      ),
      mainPanel(
        tableOutput('table')
      )
    )
  )
  server <- function(input, output) {
    output$table <- renderTable({
      df
    })
  }
  shinyApp(ui, server)
}

filterApp()



