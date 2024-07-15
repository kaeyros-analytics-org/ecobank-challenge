# model pour identifier la langue du texte
file_pretrained = system.file("language_identification/lid.176.ftz", package = "fastText")

# Définir la liste des stopwords et mots à ajouter
stopwords_list <- stopwords::stopwords('fr', source='stopwords-iso')
mots_a_ajouter <- c("fichier", "jpg","hello", "ok", "okay", "pdf", "bonjour", "bsr","bjr", "banque", "bonsoir",
                    "allô", "toc", "svp", "bank", "ecobank", "frs", "fr", "fcfa", "cfa", "svp", "bonsoir", "weeeehhh",
                    "hi", "tssssuip", "bonsoi", "aló", "héllo", "first", "afrilandfirstbank", "firstbank","okkk","xaf")
stopwords_list <- c(stopwords_list, mots_a_ajouter)

# Calcul de la similarité cosinus
cosine_similarity <- function(A, B) {
  # Calcul des produits scalaires
  AB <- A %*% t(B)
  
  # Calcul des normes
  A_norm <- sqrt(rowSums(A^2))
  B_norm <- sqrt(rowSums(B^2))
  
  # Normalisation pour obtenir la similarité cosinus
  similarity <- AB / (A_norm %*% t(B_norm))
  return(similarity)
}

# Fonction de prétraitement pour une chaîne de caractères
preprocess_text <- function(text) {
  # Convertir le texte en minuscules
  text <- tolower(text)

  # Remplacer la ponctuation par des espaces
  text <- gsub("[[:punct:]]", " ", text)

  # Retirer les chiffres
  text <- gsub("\\d+", "", text)

  # Tokenisation et suppression des mots vides
  tokens <- unlist(strsplit(text, "\\s+"))
  tokens <- tokens[!tokens %in% stopwords_list]

  # Appliquer la lemmatisation (vous devez avoir une fonction de lemmatisation)
  tokens <- lemmatize_words(tokens)

  # Recombiner les tokens en une seule chaîne de caractères
  text <- paste(tokens, collapse = " ")

  return(text)
}

# Fonction de recommandation des produits
recommender_product <- function(langue, discussion, topic_model_fr, topic_model_en, grouped_train_ecobank_fr, grouped_train_ecobank_en) {
  # Prétraiter le texte de la discussion
  discussion <- sapply(discussion , preprocess_text)
  
  if(langue == "fr"){
    topic_model <- topic_model_fr
    grouped_train_data <- grouped_train_ecobank_fr
  } else {
    topic_model <- topic_model_en
    grouped_train_data <- grouped_train_ecobank_en
  }
  
  # Créer le corpus et la matrice document-fréquence (dfm)
  corp_new <- corpus(discussion, docnames = paste0("new_", seq_along(discussion)))
  dfm_new <- dfm(corp_new)


  # Obtenir le sujet dominant de la nouvelle discussion
  new_1 <- posterior(topic_model, newdata = dfm_new)
  dominant_topic <- which.max(new_1$topics)
  
  # Extraire les topics pour tous les documents existants
  topics <- posterior(topic_model)$topics
  topic_docs <- apply(topics, 1, which.max) == as.integer(dominant_topic)



  dfm_topic <- dfm(grouped_train_data$discussion_text_client[topic_docs], docnames = paste0("doc_", seq_along(topic_docs)))

  # Harmoniser les vocabulaires
  dfm_new <- dfm_match(dfm_new, features = featnames(dfm_topic))

  
  # Convertir les DFMs en matrices denses
  dfm_new_matrix <- as.matrix(dfm_new)
  dfm_topic_matrix <- as.matrix(dfm_topic)

  # Calculer les similarités cosinus
  similarities <- cosine_similarity(dfm_new_matrix, dfm_topic_matrix)

 
  # Identifier les outliers supérieurs au troisième quartile
  Q3_outliers <- similarities > quantile(similarities, probs = 0.75, na.rm = TRUE)

  # Compter le nombre d'outliers supérieurs au troisième quartile
  num_outliers <- sum(Q3_outliers, na.rm = TRUE)

  # Sélectionner les indices des documents les plus similaires
  k <- num_outliers

  # Trouver les k documents les plus similaires
  knn_indices <- order(similarities, decreasing = TRUE)[1:k]
  closest_docs <- colnames(similarities)[knn_indices]

  # Extraire les numéros des documents
  closest_docs_numbers <- gsub("text", "", closest_docs)

  # Sélectionner les produits associés aux documents les plus similaires
  selected_products <- grouped_train_data[closest_docs_numbers, "products"]


  # Extraire les valeurs de similarité correspondantes
  similarity_values <- similarities[1, knn_indices]

  # Créer un dataframe pondéré de tous les produits
  weighted_products <- data.frame(products = character(), similarity = numeric(), stringsAsFactors = FALSE)
  for (i in 1:length(selected_products$products)) {
    products <- selected_products$products[[i]]
    similarity <- rep(similarity_values[i], length(products))
    weighted_products <- rbind(weighted_products, data.frame(products = products, similarity = similarity))
  }

  # Compter les occurrences pondérées de chaque produit
  product_counts <- aggregate(similarity ~ products, data = weighted_products, sum)

  # Calculer les scores de recommandation pour chaque produit
  product_counts$score <- round(product_counts$similarity / sum(product_counts$similarity) * 100, 2)

  # Trier le dataframe en fonction des scores décroissants
  score_df <- product_counts[order(-product_counts$score), c("products", "score")]
  names(score_df) <- c("Product", "Score")
  row.names(score_df) <- NULL

  return(score_df)
} ###############  END FUNCTION RECOMMENDATION

# Fonction de categorization de reclamation
recommender_reclamation <- function(langue, discussion, topic_model_reclamation_fr, topic_model_reclamation_en) {
  # Prétraiter le texte de la discussion
  discussion <- sapply(discussion , preprocess_text)
  
  # Créer le corpus et la matrice document-fréquence (dfm)
  corp_new <- corpus(discussion, docnames = paste0("new_", seq_along(discussion)))
  dfm_new <- dfm(corp_new)
  
  
  if(langue == "fr"){
    topic_model <- topic_model_fr
  } else {
    topic_model <- topic_model_en
  }
  
  # Obtenir le sujet dominant de la reclamation 
  new_1 <- posterior(topic_model, newdata = dfm_new)
  dominant_topic <- which.max(new_1$topics)
  # Filtrer le topic_service en fonction de la valeur de dominant_topic
  filtered_topic_service <- topic_service %>% filter(Number == dominant_topic) %>%  select(Topic, Service, `Head Of Department`, `Call Number`)
  
  return(filtered_topic_service)
} ###############  END FUNCTION RECLAMATION



root <- getwd()
path_data <- file.path(root, "data")

# Charger les données d'entraînement et le modèle
grouped_train_ecobank_fr <- readRDS(file.path(path_data, "grouped_train_ecobank_fr.rds"))
grouped_train_ecobank_en <- readRDS(file.path(path_data, "grouped_train_ecobank_en.rds"))

topic_model_fr <- readRDS(file.path(path_data, "topic_model_fr.rds"))
topic_model_en <- readRDS(file.path(path_data, "topic_model_en.rds"))

topic_service <- readRDS(file.path(path_data, "topic_service.rds"))
data_clients <- readRDS(file.path(path_data, "data_clients.rds"))

topic_model_reclamation_fr <- readRDS(file.path(path_data, "topic_model_reclamation_fr.rds"))
topic_model_reclamation_en <- readRDS(file.path(path_data, "topic_model_reclamation_en.rds"))


# Interface utilisateur
recommendation_ui <- function(id){
  ns <- NS(id)
  fluentPage(
    div(class="container-fluid",
        div(class="row p-0 m-0", style = "gap: 10px;",
            Text("Select a customer identifier: ", style = "color: #23557f; font-size: 20px;"),
            uiOutput(ns("dropdown"))
        ),
        br(),
        div(class="row p-0 m-0",
            div(class="col-lg-6 pr-1 pl-0", id = "text_history",
                h5("Discussion history for this ID:"),
                reactableOutput(ns("history")),
            ),
            div(class="col-lg-6 pr-1 pl-0", id = "services_recommendation",
                h5("Recommended services:"),
                reactableOutput(ns("service"))
            )
        ),
        br(),
        div(class="row p-0 m-0",
            div(class="col-lg-6 pr-1 pl-0", id = "barchart",
                uiOutput(ns("bar1")),
            ),
            div(class="col-lg-6 pr-1 pl-0", id = "productstabs",
                reactableOutput(ns("recommendations"))
            )
        )
    )
    
  )
}

# Serveur
recommendation_server <- function(input, output, session, filterStates) {
  
  output$bar1 <- renderUI({
    out <- accordionCard(accordionId = "accordionPlot4",
                         headerId = 'plotchart4',
                         targetId = 'collapseCcplotchart4',
                         headerContent = paste0("Top 5 recommended products", sep = ""),
                         bodyContent = echarts4rOutput(session$ns("barplot")),
                         iconId = paste0("_plotchart"),
                         dataset = "dataset")
  })
  

  data_clients_filter <- reactive({ data_clients %>%
      filter(Start_time_discusion >= ymd(filterStates$date_start) &
               Start_time_discusion <= ymd(filterStates$date_end)) %>% 
      filter(if (filterStates$countrySelected != "All") pays == filterStates$countrySelected else TRUE)
  })
  
  ############### Génération de la liste des numéro client
  
  
  opt1 <- reactive({
    list(key = c(unique(data_clients_filter()$id)),
         text = c(unique(data_clients_filter()$id)))
  })
  
  ############# Generation da la liste pour le Dropdown
  options <- reactive({
    mapply(function(i, x, y) list(ind = i, key = x, text = y),
           seq.int(opt1()$key), opt1()$key, opt1()$text,SIMPLIFY = FALSE)
  })
  
  output$dropdown <- renderUI({
    div(style = "gap: 10px;",
        Dropdown.shinyInput(session$ns("id"), style = "width: 220px;",
                            value = opt1()$key[1],
                            options = options()),
    )
  })
  
  # Mettre à jour les choix de selectInput avec les numéros d'appel uniques
  #updateSelectInput(session, "id", choices = unique(grouped_train_ecobank_fr$id))

  observeEvent(input$id, {
    req(input$id)
    selected_id  <- input$id

    # Filtrer l'historique des échanges pour le numéro d'appel sélectionné
    history <- data_clients %>% filter(id == selected_id & key=="client") %>% select(Date,Claims) 

    ############# Historique de discution
    output$history <- renderReactable({
      reactable( history ,
                striped = TRUE,
                highlight = TRUE,
                defaultPageSize = 8,
                bordered = TRUE,
                #minRows = 6,
                theme = reactableTheme(
                  borderColor = "#B5E4FB",
                  stripedColor = "#f6f8fa",
                  highlightColor = "#91A5FE",
                  cellPadding = "8px 12px",
                  style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                               fontSize = "1.10rem"),
                  searchInputStyle = list(width = "100%")
                )
      )
    })

    # Filtrer l'historique des échanges pour le numéro d'appel sélectionné
    discussion <- paste(data_clients %>% filter(id == selected_id & key=="client") %>% pull(Claims), collapse = " ")
  
    dtbl_out <- language_identification(discussion, file_pretrained)
    langue_count <- table(dtbl_out$iso_lang_1)
    langue <- names(which.max(langue_count))
    
    ################ Génération des produits à recommender
    recommendations_products <- recommender_product(langue,  discussion, topic_model_fr, topic_model_en, grouped_train_ecobank_fr, grouped_train_ecobank_en)
    
    output$recommendations <- renderReactable({
      reactable(recommendations_products,
                striped = TRUE,
                highlight = TRUE,
                defaultPageSize = 8,
                bordered = TRUE,
                theme = reactableTheme(
                  borderColor = "#B5E4FB",
                  stripedColor = "#f6f8fa",
                  highlightColor = "#91A5FE",
                  cellPadding = "8px 12px",
                  style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                               fontSize = "1.10rem"),
                  searchInputStyle = list(width = "100%")
                )
      )
    })
    
    
    ###### catégorisation des services 
    categorization <- recommender_reclamation (langue, discussion, topic_model_reclamation_fr, topic_model_reclamation_en)
    output$service <- renderReactable({
      reactable(
        categorization,
        striped = TRUE,
        highlight = TRUE,
        defaultPageSize = 8,
        bordered = TRUE,
        columns = list(
          Topic = colDef(
            style = JS("function(rowInfo, colInfo, state) {
        var firstSorted = state.sorted[0]
        // Fusionner les cellules si non triées ou triées par Topic
        if (!firstSorted || firstSorted.id === 'Topic') {
          var prevRow = state.pageRows[rowInfo.viewIndex - 1]
          if (prevRow && rowInfo.row['Topic'] === prevRow['Topic']) {
            return { visibility: 'hidden' }
          }
        }
      }")
          )
        ),
        theme = reactableTheme(
          borderColor = "#B5E4FB",
          stripedColor = "#f6f8fa",
          highlightColor = "#91A5FE",
          cellPadding = "8px 12px",
          style = list(
            fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
            fontSize = "1.10rem"
          ),
          searchInputStyle = list(width = "100%")
        )
      )
    })
    
    output$barplot <- renderEcharts4r({
      top_recommendations <- recommendations_products %>% head(5)
      top_recommendations %>%
        e_charts(Product) %>%
        e_bar(Score, itemStyle = list(color = "#23557f"), barWidth = '40%') %>%  # Ajuster la largeur des barres
        e_tooltip(trigger = 'axis') %>%
        e_x_axis(name = "Products") %>%
        e_y_axis(name = "Scores") %>%
        e_legend(type = "scroll", orient = "vertical", right = "0%", top = "10%") %>%
        e_toolbox_feature() %>%
        e_toolbox_feature(
          feature = "magicType",
          type = list("line", "bar")
        )
    })
  })
  
  # output$test <- renderPlotly({
  #   fig <- plot_ly(
  #     x = c("giraffes", "orangutans", "monkeys"),
  #     y = c(20, 14, 23),
  #     name = "SF Zoo",
  #     type = "bar"
  #   )
  #   
  #   fig
  # })
  
}
