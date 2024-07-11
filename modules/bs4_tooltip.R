backendTooltip <- function(tooltipContent,
                           cssClass = "tooltipIcon") {
  
  out <- htmlTemplate("www/htmlComponents/tooltip.html",
      cssClass = cssClass,
      tooltipContent = tooltipContent
    )
  
  return(out)
  
}