setwd( "C:/Users/joelw/OneDrive/Documents/R/shiny/table-dashboard")
library(shiny)
source("./R/importModule.R")
source("./R/importPanel.R")
source("./R/filterPanel.R")
source("./R/histogramPanel.R")

ui <- navbarPage("App Title",
              tabPanel("Summary", importPanel('import')),
                 tabPanel("Filter", filterPanel('filter')),
                 tabPanel('histogram', histogramPanel('histogram'))
            )

server <- function(input, output, session) {
  
  df <- importPanelServer("import")
  selected <- filterServer('filter', df())
  histogramServer('histogram', df()[selected$rows(), selected$cols()])
  
  

}

shinyApp(ui, server)





