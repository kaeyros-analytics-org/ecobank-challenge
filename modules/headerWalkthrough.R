headerWalkthrough_ui <- function(id) {
  
  ns <- NS(id)
  
  out <- actionButton(ns("startTour"), label = HTML('<i class="bi bi-geo"></i>'))
  
  return(out)
  
}


headerWalkthrough_server <- function(input,
                             output,
                             session,
                             filterStates) {
  
  observeEvent(input$startTour, {
    print("Start Tour")
    
    if (filterStates$dataNavi$dataset != "Home") {
      
      dataset <- filterStates$dataNavi$dataset
      
      print(dataset)
      
      if (dataset == "Dashboard") tabset = "dashboard"
      if (dataset == "Map") tabset = ""
      
      if (tabset == "dashboard") {
        df <- helpText %>% 
          filter(tabpanel == "dashboard")
        print(df)
        rintrojs::introjs(
          session,
          options = list(
            "nextLabel" = "Suivant",
            "prevLabel" = "Précédent",
            "skipLabel" = "Passer",
            "doneLabel" = "Ok",
            steps = data.frame(
              element = as.vector(df$container),
              intro = as.vector(df$text)
            )
          )
        )
      } else if (tabset == "map") {
        df <- helpText %>% 
          filter(tabpanel == "map")
        rintrojs::introjs(
          session,
          options = list(
            "nextLabel" = "Suivant",
            "prevLabel" = "Précédent",
            "skipLabel" = "Passer",
            "doneLabel" = "Ok",
            steps = data.frame(
              element = as.vector(df$container),
              intro = as.vector(df$text)
            )
          )
        )
      }
    } else if (filterStates$dataNavi$dataset == "Home") {
      df <- helpText %>% 
        filter(navtab == "allgemein") 
      rintrojs::introjs(
        session,
        options = list(
          "nextLabel" = "Suivant",
          "prevLabel" = "Précédent",
          "skipLabel" = "Passer",
          "doneLabel" = "Ok",
          steps = data.frame(
            element = as.vector(df$container),
            intro = as.vector(df$text)
          )
        )
      )
    }
    
    
  })
}
