library(ggplot2)
library(shiny)
library(dplyr)

df <- tibble(read.csv("./data/pokemon.csv"))

ui <- fluidPage(
  titlePanel("Pokemon Analysis"),
  selectInput(
    "selected_cols",
    label = "Select columns",
    choices = names(df),
    multiple = TRUE
  ),
  tabsetPanel(
    tabPanel("Table", tableOutput("select_cols")),
    tabPanel("Plot",
             plotOutput("plot", brush = "plot_brush"),
             tableOutput("plot_data")) 
  )
)

server <- function(input, output, session) {
  output$select_cols <- renderTable({
    print(input$selected_cols)
    if (is.null(input$selected_cols)) {
      return(df)
    }
    df %>% 
      select(input$selected_cols)
  })
  

  output$plot <- renderPlot({
    ggplot(df, aes(hp, speed)) + geom_point()
  }, res = 96)
  
  output$plot_data <- renderTable({
    req(input$plot_brush)
    brushedPoints(df, input$plot_brush)
  })
}
  
  
shinyApp(ui, server)


