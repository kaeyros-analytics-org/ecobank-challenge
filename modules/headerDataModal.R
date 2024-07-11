headerDataModal_ui <- function(id) {
  
  ns <- NS(id)
  
  out <- div(tabindex="0",
              `aria-label` = "Datenquellenbeschreibung", 
              class="navbar-icon",
              title="Datenquellenbeschreibung", 
              style="font-size: 1rem; cursor: pointer; margin: 0 10px;",
              HTML('<i class="bi bi-file-earmark-text"></i>')
              )
  
  return(out)
  
}


headerDataModal_server <- function(input,
                             output,
                             session,
                             filterStates) {
  
  observeEvent(req(filterStates$headerIconSelection == "Datenquellen"), {
    showModal(modalXLargeDialog(
        size="xl",
        easyClose = TRUE,
        title = HTML('<p>Informationen zu den Datenquellen</p><img src="./images/preview_logo.svg" height="50" style="position: absolute; top: 0; right: 0; margin: 0 10px;">'),
        footer = modalButton("Close"),                
        includeHTML("./www/htmlComponents/landingTable.html")
    ))
  })
  
}