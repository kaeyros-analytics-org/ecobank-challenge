# Chargement des données nécessaires
ecobank_clients <- readRDS("data/ecobank_clients.rds")
cameroun_shapefile_path <- "data/cmr_admbnda_inc_20180104_SHP/cmr_admbnda_adm2_inc_20180104.shp"
cameroun_sf <- st_read(cameroun_shapefile_path)

# Fonction UI pour l'affichage de la carte
map_ui <- function(id) {
  ns <- NS(id)
  fluentPage(
    div(id = "map",
        h4("Map Overview"),
        leafletOutput(ns("map_plot"), width = "100%", height = 590)
    )
  )
}

# Fonction serveur pour la gestion de la carte
map_server <- function(input, output, session, filterStates) {
  
  # Filtrage des données des clients en fonction de la période et de la ville sélectionnée
  data_clients_filter <- reactive({
    ecobank_clients %>%
      filter(Start_time_discusion >= ymd(filterStates$date_start) &
               Start_time_discusion <= ymd(filterStates$date_end)) %>%
      filter(if (filterStates$citySelected != "All") city == filterStates$citySelected else TRUE)
  })
  
  # Agrégation des données pour la carte avec types et montants des réclamations
  data_map <- reactive({
    data_clients_filter() %>%
      group_by(city, longitude, latitude) %>%
      summarize(
        count = n(),
        avg_claim_amount = mean(Claim_Amount, na.rm = TRUE),
        claim_type = toString(unique(Claim_Type)),
        .groups = 'drop'
      )
  })
  
  # Rendu de la carte
  output$map_plot <- renderLeaflet({
    polygon_popup <- paste0(
      "<strong>City: </strong>", data_map()$city, "<br>",
      "<strong>Number of claims: </strong>", prettyNum(data_map()$count, big.mark = ","), "<br>",
      "<strong>Average Claim Amount: </strong>", prettyNum(data_map()$avg_claim_amount, big.mark = ","), " FCFA<br>",
      "<strong>Claim Types: </strong>", data_map()$claim_type
    ) %>% lapply(htmltools::HTML)
    
    choosen_cities <- filterStates$citySelected
    
    # Filtrage des départements pour les villes sélectionnées ou tous les départements
    highlighted_depts <- if (choosen_cities == "All") {
      unique(ecobank_clients$ADM2_FR)
    } else {
      ecobank_clients %>%
        filter(city %in% choosen_cities) %>%
        pull(ADM2_FR) %>%
        unique()
    }
    
    # Création de la carte en surlignant les départements sélectionnés
    fig_map <- leaflet(data = cameroun_sf) %>%
      addTiles() %>%
      addPolygons(
        color = ~ifelse(ADM2_FR %in% highlighted_depts, "red", "blue"),
        weight = 2,
        opacity = 1,
        fillOpacity = 0.4
      ) %>%
      addAwesomeMarkers(
        data = data_map(),
        lng = ~longitude, lat = ~latitude,
        popup = polygon_popup, label = polygon_popup
      ) %>%
      setView(13, 7, zoom = 6)
    
    fig_map
  })
}
