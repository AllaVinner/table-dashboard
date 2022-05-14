library(tidyverse)
library(shiny)


filterPanel <-  function(id) {
  sidebarLayout(
    sidebarPanel(
      uiOutput(NS(id,'filter'))
    ),
    mainPanel(
      uiOutput(NS(id, 'select_ui')),
      tableOutput(NS(id, 'table'))
    )
  )
}

filterServer <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    columns <- reactive(names(df))
    displayable_columns <- reactive(df %>% discard(is.list) %>% names())
    filterable_columns <- reactive(df %>% discard(~ ! (is.numeric(.x) | is.factor(.x) | is.character(.x))) %>% names())
    output$filter <- renderUI({
      map(filterable_columns(), ~make_filter_component(df[[.x]], .x, id))

    })
    selected_rows <- reactive({
      each_var <- map(filterable_columns(), ~ filter_var(df[[.x]], input[[.x]]))
      reduce(each_var, `&`)
    })
    selected_columns <- reactive({
      if (is.null(input$select)) {
        displayable_columns()
      } else {
        input$select
      }
    })

    output$select_ui <- renderUI({
      checkboxGroupInput(NS(id, 'select'), 'Select Column', choices = displayable_columns(), selected = NULL, inline = TRUE )
    })
    output$table <- renderTable({

      df[selected_rows(), selected_columns()]
    })

    list(rows = selected_rows, cols = selected_columns)
  })
}




make_filter_component <- function(x, var, id = NULL) {
  if (is.numeric(x)) {
    rng <- range(x, na.rm = TRUE)
    sliderInput(NS(id,var),var, min = rng[1], max = rng[2], value = rng)
  } else if (is.factor(x)) {
    levs <- levels(x)
    selectInput(NS(id,var), var, choices = levs, selected = levs, multiple = TRUE)
  } else if (is.character(x)){
    categories <- unique(x)
    if (length(categories) <= 20){
      selectInput(NS(id, var), var, choices = categories, selected = NULL, multiple = TRUE)
    } else {
      NULL
    }
  } else {
    NULL
  }
}


filter_var <- function(x, val) {
  if (is.null(val)) {
    TRUE
  } else {
    if (is.numeric(x)) {
      !is.na(x) & x >= val[1] & x <= val[2]
    } else if (is.factor(x)) {
      x %in% val
    } else if (is.character(x)) {
      x %in% val
    } else {
      TRUE
    }
  }
}


filterApp <- function() {
  df <- starwars
  ui <- fluidPage(
    filterPanel('filter')
  )

  server <- function(input,output,session){
    filterServer('filter', df)
  }
  shinyApp(ui, server)
}

filterApp()



