
ecobank_clients <- readRDS("data/ecobank_clients.rds")

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
      div( class = "cards_overview_list", id = "cardview",
           catalog_overview_card("Total Clients", "", textOutput(ns("clients"))),
           catalog_overview_card("Total Claims", "", textOutput(ns("reclamations"))),
           catalog_overview_card("Active Users", "",  textOutput(ns("contacts")))
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
  
  Ecobank_client_filter <- reactive({ ecobank_clients %>%
      filter(Start_time_discusion >= ymd(filterStates$date_start) &
               Start_time_discusion <= ymd(filterStates$date_end)) %>% 
      filter(if (filterStates$citySelected != "All") city == filterStates$citySelected else TRUE)
  })
  
  output$clients <- renderText({
    paste0(nrow(Ecobank_client_filter() %>% filter(key=="client")))
  })
  
  output$reclamations <- renderText({
    paste0(length(unique(Ecobank_client_filter()$id)))
  })
  
  output$contacts <- renderText({
    paste0(length(unique(Ecobank_client_filter()$Call_Number)))
  })
  
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