headerFormModal_form_ui <- function(id) {
  
  ns <- NS(id)
  
  out <- tagList( 
    uiOutput(ns("formModal_form"))
  )
  
  return(out)
  
}

headerFormModal_form_server <- function(input,
                             output,
                             session) {
  
  output$formModal_form <- renderUI({
    "Lorem ipsum"
    # tagList(
    #   HTML(
    #     '
    #     <div tabindex="0" id="vueFormHeader">
    #       Sehr geehrte Nutzerin, sehr geehrter Nutzer des Konfliktexplorers,<br />
    #       <div style="height: 8px;"></div>
    #       schön, dass Sie sich die Zeit nehmen wollen, an unserer kleinen Umfrage zur Nutzer(innen)freundlichkeit 
    #       des Konfliktexplorers teilzunehmen. Mit Ihrem Feedback helfen Sie uns wirklich sehr weiter. 
    #       Es dauert nur einen Augenblick.<br />
    #       <div style="height: 8px;"></div>
    #     </div>
    #     <hr style="margin: 0.5rem 0;">
    #     '
    #   ),
    #   # Question 1
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("1. Wie zufrieden sind Sie mit dem Konfliktexplorer insgesamt? *")
    #       ),
    #       headerFormRatingControl(elementId = "Question1")
    #   ),
    #   # Question 2
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("2. Mit welchem Ziel haben Sie den Konfliktexplorer aufgerufen?")
    #       ),
    #       headerFormCheckboxCols(q3 = FALSE)
    #   ),
    #   # Question 3
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("3. Haben Sie mit Hilfe des Konfliktexplorers Erkenntnisse gewonnen?")
    #       ),
    #       headerFormBoxControl(elementId = "Question3",
    #                            valueOne = "Ja",
    #                            valueTwo = "Nein",
    #                            valueThree = "Teilweise",
    #                            q3 = TRUE),
    #       headerFormCheckboxCols(checkboxItems = c("Die Daten/Analysen/Visualisierungen waren nicht verständlich.",
    #                                                "Die Daten/Analysen/Visualisierungen waren nicht auffindbar.",
    #                                                "Die Daten/Analysen/Visualisierungen waren falsch.",
    #                                                "Die Daten/Analysen/Visualisierungen haben nicht geholfen",
    #                                                "Es gab technische Probleme",
    #                                                "Sonstiges"
    #       ), questionId = "Question3")
    #   ),
    #   # Question 4
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("4. Wie zufrieden sind Sie mit der Bedienbarkeit und Übersichtlichkeit des Konfliktexplorers? *")
    #       ),
    #       headerFormRatingControl(elementId = "Question4")
    #   ),
    #   # Question 5
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("5. Wie schätzen Sie die Häufigkeit der Nutzung eines Tools wie dem Konfliktexplorer ein?")
    #       ),
    #       headerFormBoxControl(elementId = "Question5",
    #                            valueOne = "Sehr häufig",
    #                            valueTwo = "Häufig",
    #                            valueThree = "Selten",
    #                            valueFour = "Gar nicht",
    #                            q3 = FALSE)
    #   ),
    #   # Question 6
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("6. Wie hoch sehen Sie den Nutzen des Konfliktexplorers für Ihre Arbeit?")
    #       ),
    #       headerFormBoxControl(elementId = "Question6",
    #                            valueOne = "Sehr hoher Nutzen",
    #                            valueTwo = "Hoher Nutzen",
    #                            valueThree = "Geringer Nutzen",
    #                            valueFour = "Sehr geringer bis kein Nutzen",
    #                            q3 = FALSE)
    #   ),
    #   # Question 7
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("7. Welche anderen Explorationstools nutzen Sie typischerweise für Ihre Arbeit?")
    #       ),
    #       headerFormTextControl(elementId = "Question7",
    #                             valueOne = "Bitte nennen Sie einige von Ihnen genutzte Explorationstools")
    #   ),
    #   # Question 8
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("8. Welche weiteren Informationen und Funktionalitäten wünschen Sie sich?")
    #       ),
    #       headerFormTextControl(elementId = "Question8",
    #                             valueOne = 'Bitte tragen Sie einige zusätzliche Informationen/Funktionalitäten ein.')
    #   ),
    #   # Question 9
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("9. Dies ist die weiterentwickelte Version des Konfliktexplorers. Waren Sie bereits mit der vorherigen Version des Konfliktexplorers vertraut?")
    #       ),
    #       headerFormRadioControl(elementId = "Question9",
    #                              elementId_9a = "Question9a",
    #                              elementId_9b = "Question9b",
    #                              elementId_9c = "Question9c",
    #                              valueOne = "Ja",
    #                              valueTwo = "Nein",
    #                              valueThree = "Viel schlechter",
    #                              valueFour = "Schlechter",
    #                              valueFive = "Gleich",
    #                              valueSix = "Besser",
    #                              valueSeven = "Viel Besser",
    #                              valueEight = "Viel schlechter",
    #                              valueNine = "Schlechter",
    #                              valueTen = "Gleich",
    #                              valueEleven = "Besser",
    #                              valueTwelve = "Viel Besser",
    #                              valueThirteen = "Viel schlechter",
    #                              valueFourteen = "Schlechter",
    #                              valueFifteen = "Gleich",
    #                              valueSixteen = "Besser",
    #                              valueSeventeen = "Viel Besser"
    #       )
    #   ),
    #   
    #   # Question 10
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("10. Welche zusätzlichen Funktionen wünschen Sie sich basierend auf der gegebenen Datenbasis?")
    #       ),
    #       headerFormTextControl(elementId = "Question10",
    #                             valueOne = "Bitte tragen Sie einige zusätzliche Informationen/Funktionalitäten ein.")
    #   ),
    #   # Question 11
    #   div(class="vueFormControl",
    #       div(tabindex="0", class="formHeader",
    #           strong("11. Sie haben weiteres Feedback? Hier ist Platz für Ihr persönliches Feedback:")
    #       ),
    #       headerFormTextControl(elementId = "Question11",
    #                             valueOne = "Bitte tragen Sie hier Ihr Feedback ein.")
    #   ),
    #   # Submit button
    #   div(class="buttonContainer", actionButton(session$ns("actionFilter"), title="Feedback abschicken", label= HTML('<i class="bi bi-save-fill">&nbsp; Feedback abschicken</i>'), class = "form-submit"),
    #       HTML('
    #       <div><button class="vueLoginButton vueLoginOpen" title="Administrationsbereich öffnen"><i class="bi bi-person"></i> Administrationsbereich</button></div>
    #     '))
    #   
    # )
  })
  
  output$downloadUserFormData <- downloadHandler(
    filename = function() {
      paste(Sys.Date(), "_Benutzereingaben.csv", sep="")
    },
    content = function(file) {
      write.csv(data, file, row.names = FALSE)
    }
  )
}
