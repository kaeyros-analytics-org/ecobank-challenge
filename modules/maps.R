# data_clients_final <- readRDS("data/data_clients_final.rds")
ecobank_clients <- readRDS("data/ecobank_clients.rds")

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
                            "<strong>Number of reclamations : </strong>", prettyNum(data_map()$count, big.mark = ",")) %>% 
      lapply(htmltools::HTML)
    # generate the wordl map
    world <- maps::map("world", fill=TRUE, plot=FALSE)
    world_map <- maptools::map2SpatialPolygons(world, sub(":.*$", "", world$names))
    world_map <- sp::SpatialPolygonsDataFrame(world_map,
                                              data.frame(country=names(world_map),
                                                         stringsAsFactors=FALSE),
                                              FALSE)
    
    choosen_countries <- filterStates$countrySelected
    
    # Filtrer les pays choisis
    target_map <- if (choosen_countries == "All") {
      subset(world_map, country %in% unique(ecobank_clients$pays))
    } else {
      subset(world_map, country %in% choosen_countries)
    }
    
    fig_map <- leaflet(data = target_map) %>%
      addTiles() %>%
      addPolygons(weight=1) %>%
      leaflet::addTiles() %>%
      leaflet::addAwesomeMarkers(
        data = data_map(),
        lng = ~longitude, lat = ~latitude,
        popup = polygon_popup, label = polygon_popup)
    fig_map %>% setView(11, 3,  zoom = 4)
    
  }) # end output$map_plot
}