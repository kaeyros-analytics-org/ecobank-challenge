
# Define server logic ----
server <- function(input, output, session) {
  
  ################### This code change the Tab Head Layout
  Sys.sleep(1.5)
  observeEvent(input$datasetNav,
               {
                 filterStates$allDataset <- input$allNav
                 filterStates$dataNavi$dataset <- input$datasetNav
               })
  
  ######### Set the first active page Layout
  callModule(mainContentRouter_server, id = "mainContentRouter", filterStates = filterStates)
  
  ########## Call filter server module
  callModule(filterStatesRouter_server, id = "filterStates", filterStates = filterStates)
  
  ####### Call server module for start tour.
  callModule(headerWalkthrough_server, id = "walkthrough", filterStates = filterStates)
  
  ############## Icon selection for display modal form
  observeEvent(input$iconSelection, {
    callModule(headerFormModal_server, id = "formModal", iconSelection = input$iconSelection)
    callModule(headerFeedbackModal_server, id = "feedbackModal", iconSelection = input$iconSelection)
  })

  ################ Apply filter woth sidebar DATA
  observeEvent(input$filter_data, {
    print("Apply the filter")
    filterStates$countrySelected <- input$countryInput
    filterStates$date_start <- input$dateRangeInput[1]
    filterStates$date_end <- input$dateRangeInput[2]
    filterStates$filterButton <- TRUE
  })
  
  ################ Reset filter on sidebar DATA
  observeEvent(input$reset_filter, {
    print("Reset the filter")
    #filterStates$countrySelected <- NULL
    filterStates$citySelected <- ""
    filterStates$statusSelected <- "All"
    filterStates$date_start <- "2024-01-01"
    filterStates$date_end <- Sys.Date()
    filterStates$filterButton <- FALSE
  })

}