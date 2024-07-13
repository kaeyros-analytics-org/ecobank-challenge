# data_clients_final <- readRDS("data/data_clients_final.rds")
ecobank_clients <- readRDS("data/ecobank_clients.rds")
world_shapefile_path <- "data/world-administrative-boundaries/world-administrative-boundaries.shp"  # Remplacez par le chemin vers votre shapefile
world_sf <- st_read(world_shapefile_path)

map_ui <- function(id){
 
  ns <- NS(id)
  fluentPage(
    div( id = "map",
      h4("Map Overview"),
      leafletOutput(ns("map_plot"), width = "100%", height = 590)
    )
  )
}


map_server <- function(input, output, session, filterStates){
  
  data_clients_filter <- reactive({ ecobank_clients %>%
      filter(Start_time_discusion >= ymd(filterStates$date_start) &
               Start_time_discusion <= ymd(filterStates$date_end)) %>% 
      filter(if (filterStates$countrySelected != "All") pays == filterStates$countrySelected else TRUE)
  })
  
  data_map <- reactive({
    data_clients_filter() %>% 
      group_by(pays, ville, longitude, latitude) %>%
      summarize(count = n(), .groups = 'drop') # Utilisation de .groups = 'drop' pour éviter les avertissements sur le regroupement
  })
  
  output$map_plot <- renderLeaflet({
    polygon_popup <- paste0("<strong>",data_map()$pays,"</strong>", "<br>",
                            "<strong>Town: </strong>", data_map()$ville,"<br>",
                            "<strong>Number of claims : </strong>", prettyNum(data_map()$count, big.mark = ",")) %>% 
      lapply(htmltools::HTML)
    
    
    
    choosen_countries <- filterStates$countrySelected
    
    target_map <- if (choosen_countries == "All") {
      world_sf %>% filter(name %in% unique(ecobank_clients$pays))  # Assurez-vous que la colonne NAME correspond à vos pays
    } else {
      world_sf %>% filter(name %in% choosen_countries)
    }
    
    
    fig_map <- leaflet(data = target_map) %>%
      addTiles() %>%
      addPolygons(weight = 1) %>%
      leaflet::addAwesomeMarkers(
        data = data_map(),
        lng = ~longitude, lat = ~latitude,
        popup = polygon_popup, label = polygon_popup
      ) %>%
      setView(11, 3, zoom = 4)
    
    fig_map
    
    
  }) # end output$map_plot
}