library(shiny)
library(flextable)

# Fonction pour créer un tableau fictif
create_table <- function() {
  data <- matrix(rnorm(8*4), ncol = 8)
  colnames(data) <- paste("Col", 1:8)
  rownames(data) <- paste("Row", 1:4)
  return(data)
}

# UI
ui <- fluidPage(
  downloadButton("download_doc", "Télécharger Document")
)

# Server
server <- function(input, output) {
  output$download_doc <- downloadHandler(
    filename = function() {
      paste("document_", Sys.Date(), ".docx", sep = "")
    },
    content = function(file) {
      # Créer un document Word
      doc <- officer::read_docx()
      
      # Ajouter les titres et les tableaux
      for (i in 1:4) {
        # Ajouter un grand titre
        doc <- doc %>%
          officer::body_add_par(paste("Tableau", i, ": Description de votre choix", sep = " "),
                                style = "heading 1") %>%
          officer::body_add_par("", style = "Normal")
        
        # Créer un tableau fictif
        data <- create_table()
        data <- as.data.frame(data)
        ft <- flextable(data)
        
        # Ajouter le tableau au document
        doc <- doc %>%
          body_add_flextable(ft) %>%
          officer::body_add_par("", style = "Normal")
      }
      
      # Sauvegarder le document
      print(doc, target = file)
    }
  )
}

# Lancer l'application Shiny
shinyApp(ui, server)
