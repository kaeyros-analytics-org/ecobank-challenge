landingPage_ui <- function(id) {
  
  ns <- NS(id)
  
  out <- tagList(    
    includeMarkdown("./www/htmlComponents/home.html"),
    includeHTML("./www/htmlComponents/dataDropdown.html")
  )
  
  return(out)
  
}