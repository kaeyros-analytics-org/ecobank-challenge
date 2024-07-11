headerFeedbackModal_ui <- function(id) {
  
  ns <- NS(id)
  
  out <- div(
              tabindex="0",
              `aria-label` = "Feedback", 
              class="navbar-icon",
              title="Disclaimer / Feedback", 
              style="font-size: 1rem; cursor: pointer; margin: 0 10px;",
              HTML('<i class="bi bi-chat-left-text"  style="color:;"></i>')
              )
  
  return(out)
  
}


headerFeedbackModal_server <- function(input,
                             output,
                             session,
                             iconSelection) {
  
  observeEvent(req(iconSelection == "Feedback / Disclaimer"), {
    showModal(modalDialog(
      easyClose = TRUE,
      title = HTML('<p>Feedback</p><img src="./images/logo_preview.png" height="50" style="position: absolute; top: 0; right: 0; margin: 0 10px;">'),
      footer = modalButton(HTML('<i class="bi bi-x-circle"></i> Close')),
      size = "l",
      includeMarkdown("./www/markdown/feedback.md")
    ))
  })
  
}
