headerMethodsModal_ui <- function(id) {
  
  ns <- NS(id)
  
  out <- div(tabindex="0",
             `aria-label` = "Methodische Hinweise", 
              class="navbar-icon",
              title="Methodische Hinweise", 
              style="font-size: 1rem; cursor: pointer; margin: 0 10px;",
              HTML('<i class="bi bi-info-circle"  style="color: white;"></i>')
  )
  
  return(out)
  
}


headerMethodsModal_server <- function(input,
                                      output,
                                      session,
                                      filterStates) {
  
  observeEvent(req(filterStates$headerIconSelection == "Methodische Hinweise"), {
    showModal(modalDialog(
      easyClose = TRUE,
      title = HTML('<p>Methodische Hinweise</p><img src="./images/preview_logo.svg" height="50" style="position: absolute; top: 0; right: 0; margin: 0 10px;">'),
      footer = modalButton("Close"),
      size = "l",
      includeMarkdown("./www/markdown/disclaimer.md")
    ))
  })
  
}

