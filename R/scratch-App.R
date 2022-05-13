library(shiny)
source("./R/importModule.R")
source("./R/importPanel.R")

ui <- navbarPage("App Title",
             tabPanel("Summary", importPanel('import')),
                tabPanel("Table", )
            )

server <- function(input, output, session) {
  df <- importPanelServer("import")
}

shinyApp(ui, server)





