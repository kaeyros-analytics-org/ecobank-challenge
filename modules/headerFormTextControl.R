headerFormTextControl <- function(elementId = NULL,
                                  valueOne = NULL) {
  
  out <- htmlTemplate("www/htmlComponents/formTextControl.html",
                      elementId = elementId,
                      valueOne = valueOne
  )
  
  return(out)
  
}