
map_ui <- function(id){
 
  ns <- NS(id)
  fluentPage(
    h4("Map Overview"),
    leafletOutput(ns("map_plot"), width = "100%", height = 590)
  )
}


map_server <- function(input, output, session, filterStates){
  
  output$map_plot <- renderLeaflet({
    map <- leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%  # Ajouter des tuiles CartoDB Positron
      setView(lng = 12.3547, lat = 7.3697, zoom = 6) %>%  # Centrer la carte sur le Cameroun
      
      # Ajouter des marqueurs et des cercles pour exemple (optionnel)
      addMarkers(lng = 11.5178, lat = 3.8480, popup = "Yaoundé") %>%
      addCircles(lng = 11.5178, lat = 3.8480, radius = 50000, color = "blue", popup = "Cercle à Yaoundé")
    
    # Afficher la carte
    map
  }) # end output$map_plot
}