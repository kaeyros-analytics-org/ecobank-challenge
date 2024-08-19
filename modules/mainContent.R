
################ function to manage pivot item by id 
setClickedId <- function(inputId) {
  shiny.fluent::JS(glue::glue("item => Shiny.setInputValue('{inputId}', item.props.id)"))
}

mainContentRouter_ui <- function(id) {
  
  ns <- NS(id)
  fluentPage(
    withSpinner(uiOutput(ns("mainContent")),
                         type = 8,
                         color = 'grey', size = 0.7))
}

mainContentRouter_server <- function(input, output, session, filterStates) {
  
  observeEvent(filterStates$dataNavi$dataset, 
               { print(paste("mon dataset: ", filterStates$dataNavi$dataset))
                 # generate Ressources content ####
                 if(filterStates$dataNavi$dataset == "Map") {
                   output$mainContent <- renderUI({
                     div( id = "navtabs",
                          ui_map
                     )
                   })
                   # generate Réemploies content ####
                 } else if(filterStates$dataNavi$dataset == "Customer Service") {
                   output$mainContent <- renderUI({
                     ui_customer_service
                   })
                   # generate recommendation content ####
                 } else if(filterStates$dataNavi$dataset == "Recommendation") {
                   output$mainContent <- renderUI({
                     ui_recommendation
                   })
                   # generate recommendation content ####
                 } else if(filterStates$dataNavi$dataset == "Claims Analytics") {
                   output$mainContent <- renderUI({
                     ui_classification
                   })
                   # generate recommendation content ####
                 } else { # Home
                   output$mainContent <- renderUI({
                     tagList(
                       includeMarkdown("./www/htmlComponents/home.html"),
                     )
                   })
                 }
                 
               })
  ############# This UI is for map Layout Page
  ui_map = map_ui(session$ns("map"))
  ############# This UI is for dashboard Layout Page
  ui_recommendation = recommendation_ui(session$ns("recommendation"))
  ui_classification = classification_ui(session$ns("classification"))
  ui_customer_service = customer_interaction_ui(session$ns("customer_interaction"))

  observeEvent(input$ressources_tabs, {
    print("ok")
    cat(" dans ressources Vous avez cliqué sur le tabPanel avec l'ID :", input$ressources_tabs, "\n")
  })
  
  callModule(map_server, id = "map", filterStates)
  callModule(recommendation_server, id = "recommendation", filterStates)
  callModule(classification_server, id = "classification", filterStates)
  callModule(customer_interaction_server, id = "customer_interaction", filterStates)
  
}










