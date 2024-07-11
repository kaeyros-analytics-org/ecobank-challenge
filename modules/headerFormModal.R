headerFormModal_ui <- function(id) {
  
  ns <- NS(id)
  
  out <- tagList(
          div(tabindex="0",
              `aria-label` = "A propos de l'application", 
              class="navbar-icon",
              title="A propos de l'application", 
              style="font-size: 1rem; cursor: pointer; margin: 0 10px;",
              HTML('<i class="bi bi-clipboard"></i>')
              ),
    uiOutput(ns("formModal"))
  )
  
  return(out)
  
}

headerFormModal_server <- function(input,
                             output,
                             session, iconSelection) {
  
  output$formModal <- renderUI({
    req(iconSelection == "A propos de l'application")
    
    div(showModal(
      modalXLargeDialog(
        size="xl",
        easyClose = TRUE,
        title = HTML('<p>A propos de lapplication</p><img src="./images/logo_preview.png" height="50" style="position: absolute; top: 0; right: 0; margin: 0 10px;" class="d-none d-sm-block">'),
        footer = modalButton(HTML('<i class="bi bi-x-circle"></i> Close')),
        headerFormModal_form_ui(session$ns("formModal_form"))
      )
    ), class = "form")
  })
  
  callModule(headerFormModal_form_server, id = "formModal_form")
  
}
