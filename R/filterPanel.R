library(tidyverse)
library(shiny)

ll <- starwars %>% discard(~!is.list(.x)) %>% names()

numericalFilterComponent <- function(name, label, atomic) {
  min_val <- min(atomic)
  max_val <- max(atomic)
  sliderInput(name, label, min = min_val, max = max_val, value = c(min_val, max_val), ticks = FALSE)
}


filterApp <- function() {
  df <- mtcars
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
           sliderInput('int_slider', 'my slider', min = -4, max = 10, value = 3, step = 1, ticks = FALSE),
           uiOutput('filter'),
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
    filterables <- reactive({
      f <- df %>% discard(~!is.atomic(.x)) %>% names()
      f
    })
    output$filter <- renderUI({
      numericalFilterComponent('mpg', 'MPG', df$mpg )
    })
    
  }
  shinyApp(ui, server)
}

filterApp()



