library(shiny)
source("importModule.R")


ui <- fluidPage(
  importInput("import"),
  tableOutput('df')
)

server <- function(input, output, session) {
  df <- importServer("import")
  
  output$df <- renderTable({
    req(df)
    sample_n(df(), 10)
    })
}

shinyApp(ui, server)





