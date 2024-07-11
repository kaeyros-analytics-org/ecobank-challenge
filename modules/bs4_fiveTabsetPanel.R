bs4_fiveTabsetPanel <- function(id,
                          tabOneId = 'tabOne',
                          tabTwoId = 'tabTwo',
                          tabThreeId = 'tabThree',
                          tabFourId = 'tabFour',
                          tabFiveId = 'tabFive',
                          tabOneHeading = 'Länderübersicht',
                          tabTwoHeading = 'Ländervergleich',
                          tabThreeHeading = 'Provinzübersicht',
                          tabFourHeading = 'Ereignisübersicht',
                          tabFiveHeading = 'Netzwerkanalyse',
                          tabOneContent = 'Content #1',
                          tabTwoContent = 'Content #2',
                          tabThreeContent = 'Content #3',
                          tabFourContent = 'Content #4',
                          tabFiveContent = 'Content #5',
                          filterCard = 'Lorem Ipsum Dolores...') {
  
  ns <- NS(id)
  
  out <- htmlTemplate("www/htmlComponents/fiveTabsetPanel.html",
    id = ns("TabsetPanel"),
    tabOneId = ns(tabOneId),
    tabTwoId = ns(tabTwoId),
    tabThreeId = ns(tabThreeId),
    tabFourId = ns(tabFourId),
    tabFiveId = ns(tabFiveId),
    tabOneIdHash = paste0("#", ns(tabOneId)),
    tabTwoIdHash = paste0("#", ns(tabTwoId)),
    tabThreeIdHash = paste0("#", ns(tabThreeId)),
    tabFourIdHash = paste0("#", ns(tabFourId)),
    tabFiveIdHash = paste0("#", ns(tabFiveId)),
    tabOneHeading = tabOneHeading,
    tabTwoHeading = tabTwoHeading,
    tabThreeHeading = tabThreeHeading,
    tabFourHeading = tabFourHeading,
    tabFiveHeading = tabFiveHeading,
    tabOneContent = tabOneContent,
    tabTwoContent = tabTwoContent,
    tabThreeContent = tabThreeContent,
    tabFourContent = tabFourContent,
    tabFiveContent = tabFiveContent,
    filterCard = filterCard)
  
  return(out)
  
}

bs4_fiveTabsetPanel_server <- function(input,
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