library(shiny)
source("./R/importModule.R")


importPanel <- function(id) {
  tagList(
    importUI(NS(id, "import")),
    tableOutput(NS(id,"table"))
  )
}


importPanelServer <- function(id) {
  moduleServer(id, function(input,output, session) {
    df <- importServer("import")
    output$table <- renderTable({
      sample_n(df(), 10)
    })
    df
  })
}


importApp <- function() {
  ui <- fluidPage(
    importPanel('import')
  )
  server <- function(input, output, session) {
    df <- importPanelServer("import")
  }
  shinyApp(ui, server)
}

importApp()






