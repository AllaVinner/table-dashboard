library(shiny)


histogramPanel <- function(id) {
  uiOutput(NS(id,'plots'))
}

histogramServer <- function(id, df) {
  moduleServer(id, function (input, output, session) {
    output$plots <- renderUI({
      map(names(df), ~ renderPlot({
          ggplot(df, aes(x=.data[[.x]])) + geom_histogram()})
          )
        })
  })
}


histogramApp <- function(){
  df <- starwars %>% select(mass, height)
  ui <- fluidPage(
    histogramPanel('h')
  )
  
  server <- function(input,output,session){
    histogramServer('h',df )
  }
  shinyApp(ui, server)
}



histogramApp()