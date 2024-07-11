headerFormCheckboxCols <- function(
  checkboxItems = c(
    "Um Daten/Informationen zu finden",
    "Um Trends zu erkennen",
    "Freie Suche",
    "Ausprobieren",
    "Sonstiges"
  ),
  questionId = "Question2",
  q3         = TRUE
) {
  
  left_col <- tagList()
  
  for (i in 1:ceiling(length(checkboxItems)/2)) {
    left_col <- tagList(
      left_col,
      tags$label(id = as.character(i), 
                 onclick = "checkboxClick()", 
                 class = ifelse(q3, "container-checkbox_q3", "container-checkbox"),
                 span(style="margin-top: 0.5rem;", checkboxItems[i]),
                 tags$input(type="checkbox",id=checkboxItems[i], value=checkboxItems[i]),
                 span(class="checkmark")
      )
    )
  }
  
  right_col <- tagList()
  
  for (j in (ceiling(length(checkboxItems)/2)+1):length(checkboxItems)) {
    right_col <- tagList(
      right_col,
      tags$label(class = ifelse(q3, "container-checkbox_q3", "container-checkbox"),
                 span(style="margin-top: 0.5rem;", checkboxItems[j]),
                 tags$input(type="checkbox",
                            id=ifelse(q3, paste0(checkboxItems[j], "_q3"), checkboxItems[j]),
                            value=checkboxItems[j]),
                 span(class="checkmark")
      )
    )
  }
  
  if(!q3){
  textbox <- tags$textarea(
    id = ifelse(q3, "textarea_q3", "textarea_q2"),
    `disabled` = "disabled",
    style="width: 100%; max-width: 100%; background-color: #cccccc;",
    placeholder="Welche Daten/Analysen/Visualisierungen haben Sie gesucht?",
    rows="3"
  )} else {
      textbox <- tags$textarea(
    id = ifelse(q3, "textarea_q3", "textarea_q2"),
    `disabled` = "disabled",
    style="width: 100%; max-width: 100%; background-color: #cccccc;",
    placeholder="Was waren Gründe, weshalb der Erkenntnisgewinn nicht wie erhofft ausfiel?",
    rows="3")
  }
  
  if(q3){
    textbox2 <- tags$textarea(
      id = "textarea2_q3",    
      style="width: 100%; max-width: 100%; background-color: #fff; display: none;",
      placeholder="Welche Daten/Analysen/Visualisierungen hätten geholfen?",
      rows="3"
    )
    
    out <- htmlTemplate("www/htmlComponents/formCheckboxCols_q3.html",
                        questionId = questionId,
                        checkboxColFour = left_col,
                        checkboxColFive = right_col,
                        textboxOptionThree = textbox,
                        textboxOptionFour = textbox2
    )
  } else {
    out <- htmlTemplate("www/htmlComponents/formCheckboxCols.html",
                        questionId = questionId,
                        checkboxColOne = left_col,
                        checkboxColTwo = right_col,
                        textboxOptionOne = textbox,
                        textboxOptionTwo = span("")
    )
  }
  
  return(out)
  
}