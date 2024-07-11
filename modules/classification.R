############# CARD OVERVIEW
catalog_overview_card <- function(title, text, content) {
  div(class = "overview_card",
      tagList(
        div(class = "overview_card_header",
            Text(class = "overview_card_title", title),
            h2(text)
        ),
        h1(class = "overview_card_content", content)
      )
  )
}

######## UI for dashboard
classification_ui <- function(id){
  ns <- NS(id)
  fluentPage(
    tags$style("
               .fieldGroup-82{border: none;}
               "),
    
    ################### Header CArd
    div( class="container-fluid",
      h3("Analytics Overview"),
      div( class = "cards_overview_list",
           catalog_overview_card("Nombre total de clients", "Value", "35k"),
           catalog_overview_card("Nombre total de discution", "Value", "12k"),
           catalog_overview_card("Nombre de contact", "Value", "58k")
      )
    ),
    
    br(), ######### Make Space
    
    ################ Dashboard Layout 1
    div(class="container-fluid",
        call_sentiments_ui(ns("sentiments"))
        ),
  )
}

########### Server for CPIO
classification_server <- function(input, output, session, filterStates){
  
  # output$sentiment_analysis <- renderUI({
  #   out <- accordionCard(accordionId = "accordionPlotSentiments",
  #                        headerId = 'plotchart1',
  #                        targetId = 'collapseCcplotchartCustomers_age',
  #                        headerContent = paste0("Customers Sentiments Analysis", sep = ""),
  #                        bodyContent = call_sentiments_ui(session$ns("sentiments")),
  #                        iconId = paste0("_plotchart"),
  #                        dataset = "dataset")
  # })
  
  ######################### Output Render
  callModule(call_sentiments_server, id = "sentiments", filterStates)
}