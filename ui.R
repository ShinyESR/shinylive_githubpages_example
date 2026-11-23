# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Test de mon appli en shinylive"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("var1", label = "Variable 1", choices = colvars),
      selectInput("var2", label = "Variable 2", choices = colvars)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)