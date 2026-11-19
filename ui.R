ui <- fluidPage(
  titlePanel("Carte dynamique de la France"),
  sidebarLayout(
    sidebarPanel(
      selectInput("var", "Indicateur",
                  choices = c("Indicateur A" = "indicateur_a",
                              "Indicateur B" = "indicateur_b")),
      sliderInput("opacite", "Opacité", min = 0.1, max = 1, value = 0.7, step = 0.1),
      hr()
    ),
    mainPanel(
      leafletOutput("carte", height = "650px")
    )
  )
)