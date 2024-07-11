headerFormRatingControl <- function(elementId = "Question1",
                                    valueOne = "sehr unzufrieden",
                                    valueTwo = "unzufrieden",
                                    valueThree = "neutral",
                                    valueFour = "zufrieden",
                                    valueFive = "sehr zufrieden") {
  
  out <- htmlTemplate("www/htmlComponents/formRatingControl.html",
                      elementId = elementId,
                      valueOne = valueOne,
                      valueTwo = valueTwo,
                      valueThree = valueThree,
                      valueFour = valueFour,
                      valueFive = valueFive
  )
  
  return(out)
  
}