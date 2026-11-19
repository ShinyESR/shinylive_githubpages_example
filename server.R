server <- function(input, output, session) {
  
  # Valeurs de l'indicateur choisi
  vals <- reactive(deps[[input$var]])
  
  pal <- reactive({
    colorNumeric("Blues", domain = vals())
  })
  
  # GeoJSON avec style par entité, recalculé quand les inputs changent
  geo_style <- reactive({
    g <- geo
    p <- pal()
    for (i in seq_along(g$features)) {
      v <- deps[[input$var]][i]
      g$features[[i]]$properties$style <- list(
        fillColor   = p(v),
        fillOpacity = input$opacite,
        color       = "white",
        weight      = 1
      )
      g$features[[i]]$properties$popup <- sprintf(
        "<b>%s</b> (%s)<br/>%s : %s",
        deps$nom[i], deps$code[i], input$var, v
      )
    }
    toJSON(g, auto_unbox = TRUE, null = "null")
  })
  
  # Carte de base (créée une seule fois)
  output$carte <- renderLeaflet({
    leaflet() |>
      # addProviderTiles(providers$CartoDB.Positron) |>
      setView(lng = 2.5, lat = 46.6, zoom = 5)
  })
  
  # Mise à jour dynamique de la couche
  observe({
    leafletProxy("carte") |>
      clearGeoJSON() |>
      clearControls() |>
      addGeoJSON(geo_style(), layerId = "deps") |>
      addLegend(position = "bottomright",
                pal = pal(), values = vals(), title = input$var)
  })

  # Clic sur un département
  selection <- reactiveVal(NULL)
  
  observeEvent(input$carte_geojson_click, {
    selection(input$carte_geojson_click$properties$code)
  })
  
  

  

}