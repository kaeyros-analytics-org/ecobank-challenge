bs4_fourTabsetPanel <- function(id,
                          tabOneId = 'tabOne',
                          tabTwoId = 'tabTwo',
                          tabThreeId = 'tabThree',
                          tabFourId = 'tabFour',
                          tabOneHeading = 'Länderübersicht',
                          tabTwoHeading = 'Ländervergleich',
                          tabThreeHeading = 'Provinzübersicht',
                          tabFourHeading = 'Ereignisübersicht',
                          tabOneContent = 'Content #1',
                          tabTwoContent = 'Content #2',
                          tabThreeContent = 'Content #3',
                          tabFourContent = 'Content #4',
                          filterCard = 'Lorem Ipsum Dolores...') {
  
  ns <- NS(id)
  
  out <- htmlTemplate("www/htmlComponents/fourTabsetPanel.html",
    id = ns("TabsetPanel"),
    tabOneId = ns(tabOneId),
    tabTwoId = ns(tabTwoId),
    tabThreeId = ns(tabThreeId),
    tabFourId = ns(tabFourId),
    tabOneIdHash = paste0("#", ns(tabOneId)),
    tabTwoIdHash = paste0("#", ns(tabTwoId)),
    tabThreeIdHash = paste0("#", ns(tabThreeId)),
    tabFourIdHash = paste0("#", ns(tabFourId)),
    tabOneHeading = tabOneHeading,
    tabTwoHeading = tabTwoHeading,
    tabThreeHeading = tabThreeHeading,
    tabFourHeading = tabFourHeading,
    tabOneContent = tabOneContent,
    tabTwoContent = tabTwoContent,
    tabThreeContent = tabThreeContent,
    tabFourContent = tabFourContent,
    filterCard = filterCard)
  
  return(out)
  
}

bs4_fourTabsetPanel_server <- function(input,
                                   output,
                                   session,
                                   filterStates,
                                   tabOneId,
                                   dataset = "ACLED") {
  
  observeEvent(filterStates$dataNavi$dataset,
    {
      
      if(filterStates$dataNavi$dataset == dataset) {
        session$sendCustomMessage("resetState", filterStates[[paste0(filterStates$dataNavi$dataset, "_tabSetPanel")]]) 
      }
     
    })
  
}