filterStatesRouter_ui <- function(id) {
  
  ns <- NS(id)
  fluentPage(
    shinyjs::useShinyjs(),
    div(id = "filterBox",
        uiOutput(ns("country")),
        uiOutput(ns("dateRange")),
        #uiOutput(ns("city")),
        #uiOutput(ns("status")),
        # uiOutput(ns("eventTypeSelection")),
        ################### This button apply a filter
        uiOutput(ns("filter_button")),
        tags$br(),
        uiOutput(ns("reset_filter"))
    )
  )
  
}

filterStatesRouter_server <- function(input, output, session, filterStates) {
  #ns <- session$ns
  observeEvent(filterStates$dataNavi$dataset, {
    if(filterStates$dataNavi$dataset == "Home"){ ########## We don't need to display filter when we are at home page.
      
      output$dateRange <- renderUI({
        "Quit home to see filter."
      })
      output$country <- renderUI({
      ""
      })
      output$city <- renderUI({
        ""
      })
      output$status <- renderUI({
        ""
      })
      output$filter_button <- renderUI({
        ""
      })
      
      output$reset_filter <- renderUI({
        ""
      })
      
      output$eventTypeSelection <- renderUI({ 
        ""  
      })
      output$countryselect <- renderUI({
        ""
      })
    }else{
      ################## Date filter
      output$dateRange <- renderUI({
        tagList(
          div(class="sidebar-header", tags$a("Choisir l'écart de date: ")),
          backendTooltip(span(`data-toggle`="tooltip",
                              `data-placement`="right",
                              `data-html` = "true",
                              title = "Choississez l'écart de de date. Il doit être d'une semaine max.<br/>
                           <b>Comment ça fonctionne:</b>
                           Crée une paire d'entrées de texte qui, lorsqu'elles sont cliquées,
                          font apparaître des calendriers sur lesquels l'utilisateur peut cliquer pour sélectionner des dates.", 
                              HTML('<i class="bi bi-question-circle"></i>'))),
          dateRangeInput("dateRangeInput", label = NULL,
                         start = as.Date(filterStates$date_start), end = as.Date(filterStates$date_end),
                         min = "2024-01-01", max = Sys.Date()),
          tags$script(src = "./js/tooltip.js")
        )
      })
      
      ################## Country selection filter
      output$country <- renderUI({
        selection <- filterStates$countrySelected
        choices = c("Cameroun", "Congo", "Guinnée", "Tchad")
        tagList(
          div(class="sidebar-header", tags$a("Sélection du pays: ")),
          backendTooltip(span(`data-toggle`="tooltip",
                              `data-placement`="right", 
                              `data-html` = "true",
                              title = "Vous pouvez choisir le pays. 
                            Cette sélection a un impact sur les données affichés", 
                              HTML('<i class="bi bi-question-circle"></i>'))),
          selectInput("countryInput", label = NULL,
                      choices = choices, selected = selection)
        )
      })
      
      ################## city selection filter
      output$city <- renderUI({
        selection <- filterStates$citySelected
        choices = c("Yaounde", "Douala", "Bafoussam", "Bertoua", "etc...")
        tagList(
          div(class="sidebar-header", tags$a("Sélection de la ville: ")),
          backendTooltip(span(`data-toggle`="tooltip",
                              `data-placement`="right", 
                              `data-html` = "true",
                              title = "Vous pouvez choisir la ville 
                            Cette sélection a un impact sur les données affichés", 
                              HTML('<i class="bi bi-question-circle"></i>'))),
          selectInput("cityInput", label = NULL,
                      choices = choices, selected = selection)
        )
      })
      
      ################## agence selection filter
      output$status <- renderUI({
        selection <- filterStates$agencySelected
        choices = c("all", "old", "new")
        tagList(
          div(class="sidebar-header", tags$a("Choisir le Status: ")),
          backendTooltip(span(`data-toggle`="tooltip",
                              `data-placement`="right", 
                              `data-html` = "true",
                              title = "Vous pouvez choisir le status client. 
                            Cette sélection a un impact sur les données affichés", 
                              HTML('<i class="bi bi-question-circle"></i>'))),
          selectInput("statusInput", label = NULL,
                      choices = choices, selected = selection)
        )
      })
      
      output$filter_button <- renderUI({
        DefaultButton.shinyInput("filter_data", class = "btn-filter",
                                 text = "Apply filter",
                                 iconProps = list(iconName = "Add"),
                                 style = "background-color: #0093FF; color: #fff;"
        )
      })
      
      output$eventTypeSelection <- renderUI({
        
        states <- c("Situation Globale", "Situation Par réseau", "Entrées en relation", "CPIO")
        choices <- c(paste0("Ressouces", " - ", states), "Réemploies", "Recouvrement", "Production")
        
          tagList(
            div(tabindex="0", `aria-label` = "Ereignistyp", class="sidebar-header", tags$a("Quel élément doit être générer? ")),
            backendTooltip(span(`data-toggle`="tooltip", 
                                `data-placement`="right", 
                                `data-html` = "true",
                                title = "Choississez les éléments qui vont être generer dans le document word.", 
                                HTML('<i class="bi bi-question-circle"></i>'))),
            pickerInput("eventTypePicker",
                        label = NULL,
                        choices = choices,
                        multiple = T,
                        width = "100%",
                        options = pickerOptions(
                          actionsBox = TRUE,
                          title = "Veuillez selectionner",
                          selectAllText = '<span style="font-size: 0.8em;">Tous</span>',
                          deselectAllText = '<span style="font-size: 0.8em;">Reset</span>'
                        ),
                        selected = filterStates$whoAsPrint,
                        inline = F)
          )
        
      })
      
      ############# Button to Reset a filter
      output$reset_filter <- renderUI({
        DefaultButton.shinyInput("reset_filter", class = "btn-filter",
                                 text = "Reset Filter",
                                 iconProps = list(iconName = "Refresh"),
                                 style = "background-color: #fff; color: #000;"
        )
      })
      
      output$countryselect <- renderUI({
        paste("Pays sélectionner: ",  filterStates$countrySelected, sep = "")
      })
      
      ########## End
    }
  })

}