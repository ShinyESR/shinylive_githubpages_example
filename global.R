library(shiny)
library(leaflet)
library(jsonlite)



# Contours des départements (GeoJSON simplifié, CORS activé sur raw.githubusercontent.com)
url_geo <- "https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/departements-version-simplifiee.geojson"

geo <- fromJSON(url_geo, simplifyVector = FALSE)

# Table des départements + valeurs fictives (à remplacer par tes données)
deps <- data.frame(
  code = vapply(geo$features, function(f) f$properties$code, ""),
  nom  = vapply(geo$features, function(f) f$properties$nom, ""),
  stringsAsFactors = FALSE
)
set.seed(42)
deps$indicateur_a <- round(runif(nrow(deps), 0, 100), 1)
deps$indicateur_b <- round(rnorm(nrow(deps), 50, 15), 1)