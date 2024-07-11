headerFormBoxControl <- function(elementId = NULL,
                                 valueOne = NULL,
                                 valueTwo = NULL,
                                 valueThree = NULL,
                                 valueFour = NULL,
                                 q3        = TRUE) {
  
  if(q3){
    out <- htmlTemplate("www/htmlComponents/formBoxControl_q3.html",
                        elementId = elementId,
                        valueOne = valueOne,
                        valueTwo = valueTwo,
                        valueThree = valueThree
                        
    )
  } else {
    out <- htmlTemplate("www/htmlComponents/formBoxControl.html",
                        elementId = elementId,
                        valueOne = valueOne,
                        valueTwo = valueTwo,
                        valueThree = valueThree,
                        valueFour = valueFour
    )
  }

  return(out)
  
}