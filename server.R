# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    p <- ggplot(mtcars, aes(.data[[input$var1]], .data[[input$var2]]))
    p + geom_point()
  })
}