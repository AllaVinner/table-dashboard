library(shiny)
library(tidyverse)

importUI <- function(id) {
    fileInput(NS(id,'file_input'), 'Chose file', accept = ".csv")
  }

importServer <- function(id) {
  moduleServer(id, function(input,output, session) {
    reactive({
      req(input$file_input)
      read.csv(input$file_input$datapath)
    })
  })
}


importApp <- function() {
  ui <- fluidPage(
    importUI("import"),
    tableOutput("table")
  )
  server <- function(input, output, session) {
    df <- importServer("import")
    output$table <- renderTable({
      print(class(df()))
      df()
    })
    df
  }
  shinyApp(ui, server)
}

importApp()


