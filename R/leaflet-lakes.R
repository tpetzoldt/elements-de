library("leaflet")

lakepos <- read.csv("../data/kenndaten-seen-gps.csv")

leaflet(options = leafletOptions(zoomControl = TRUE)) |>
  addTiles() |>
  setView(lng = 10.447, lat = 51.16, zoom = 7) |>
  addMarkers(lng = lakepos$lon, lat = lakepos$lat,
             popup = lakepos$name,
             options = markerOptions(title=lakepos$name, closeButton = FALSE))
