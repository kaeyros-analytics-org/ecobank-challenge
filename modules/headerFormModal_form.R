headerFormModal_form_ui <- function(id) {
  
  ns <- NS(id)
  
  out <- tagList( 
    uiOutput(ns("formModal_form"))
  )
  
  return(out)
  
}

headerFormModal_form_server <- function(input,
                             output,
                             session) {
  
  output$formModal_form <- renderUI({
    "Lorem ipsum"
  })
  
  output$downloadUserFormData <- downloadHandler(
    filename = function() {
      paste(Sys.Date(), "_Benutzereingaben.csv", sep="")
    },
    content = function(file) {
      write.csv(data, file, row.names = FALSE)
    }
  )
}
