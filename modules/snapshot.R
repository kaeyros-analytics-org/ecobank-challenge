# function that takes variables to get a unique snapshot button in the UI ----
snapshot <- function(popoverId,
                     saveScreenId       ,
                     accordionIdConcat,
                     saveScreenName,
                     tooltip_scale,
                     tooltip_filter) {
  out <- htmlTemplate("www/htmlComponents/screenshot_template.html",
                      popoverId         = popoverId,
                      saveScreenId      = saveScreenId,
                      accordionIdConcat = accordionIdConcat,
                      saveScreenName    = saveScreenName,
                      tooltip_scale     = tooltip_scale,
                      tooltip_filter    = tooltip_filter,
                      headlineId        = paste0(popoverId, "-extr_title")
                     )
  return(out)
}