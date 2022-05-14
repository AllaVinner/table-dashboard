library(shiny)
source("./R/importModule.R")
source("./R/importPanel.R")
source("./R/filterPanel.R")

ui <- navbarPage("App Title",
              tabPanel("Summary", importPanel('import')),
                 tabPanel("Filter", filterPanel('filter')),
                 tabPanel('histogram', histogramPanel('histogram'))
            )

server <- function(input, output, session) {
  df <- importPanelServer("import")
  filter <- filterServer('filter', df())

}

shinyApp(ui, server)





