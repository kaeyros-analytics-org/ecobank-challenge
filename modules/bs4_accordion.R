accordionCard <- function(accordionId = "accordionOne", 
                          headerId = 'headerOne',
                          targetId = 'collapseOne',
                          headerContent = 'headerContent #1',
                          bodyContent = '',
                          iconId = 'icon',
                          dataset = 'ACLED',
                          optionalTooltip = span("")) {
  
  out <- htmlTemplate("www/htmlComponents/accordionTemplate.html",
    headerId = paste0(dataset, "_", headerId),
    accordionId = paste0(dataset, "_", accordionId),
    accordionIdConcat = paste0("#", paste0(dataset, "_", accordionId)),
    targetId = paste0(dataset, "_", targetId),
    targetIdConcat = paste0("#", paste0(dataset, "_", targetId)),
    headerContent = headerContent,
    bodyContent = bodyContent,
    fullScreenId = paste0(iconId, "-fullscreen"),
    download_button = downloadbtn_ui(id = "downloadbtn_server", 
                                     popoverId2 = paste0(iconId, "-popover2"), 
                                     downloadId = paste0(iconId, "-datadownload")),
    snapshot_button = snapshot(
      saveScreenId = paste0(iconId, "-savescreen"),
      popoverId = paste0(iconId, "-popover"),
      accordionIdConcat = paste0("#", paste0(dataset, "_", accordionId)),
      saveScreenName = paste0(accordionId),
      tooltip_scale = div(class = "", style = "display: inline", 
                    backendTooltip(span(`data-toggle`="tooltip", 
                      `data-placement`="right", 
                      `data-html` = "true",
                      title = "Werte kleiner als 1 verringern die Bildschirmauflösung, Werte größer als 1 erhöhen die Bildschirmauflösung.", 
                      HTML('<i class="bi bi-question-circle"></i>')))),
      tooltip_filter = div(class = "", style = "display: inline; float: right;", 
                           backendTooltip(span(`data-toggle`="tooltip", 
                                               `data-placement`="right", 
                                               `data-html` = "true",
                                               title = "Werte kleiner als 1 verringern die Bildschirmauflösung, Werte größer als 1 erhöhen die Bildschirmauflösung.", 
                                               HTML('<i class="bi bi-question-circle"></i>'))))),
      optionalTooltip = optionalTooltip
  )

  return(out)
  
}