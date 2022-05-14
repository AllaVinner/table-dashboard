library(shiny)


histogramApp <- function(){
  ui <- fluidPage(
    uiOutput('plots')
  )
  server <- function (input, output, session) {
    col <- 'height'
    output$plots <- renderUI({
      plotOutput('h')
    })

    output$h <- renderPlot({
      ggplot(data, aes(x=value)) +
        geom_histogram()
    })
  }
}



histogramApp()