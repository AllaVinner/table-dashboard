library(shiny)


importInput <- function(id) {
  tagList(
    fileInput(NS(id,'file_input'), 'Chose file', accept = ".csv"),
    tableOutput(NS(id,'df'))
  )
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
      sample_n(df(), 10)
    })
  }
  shinyApp(ui, server)
}

importApp()


