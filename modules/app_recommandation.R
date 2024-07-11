
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
recommender_system <- function(discussion, topic_model_fr, grouped_train_data) {
  # Prétraiter le texte de la discussion
  discussion <- sapply(discussion , preprocess_text)

  # Créer le corpus et la matrice document-fréquence (dfm)
  corp_new <- corpus(discussion, docnames = paste0("new_", seq_along(discussion)))
  dfm_new <- dfm(corp_new)

  # Vérifiez si dfm_new contient des termes
  if (nfeat(dfm_new) == 0) {
    stop("La matrice document-fréquence (dfm) est vide après prétraitement.")
  }

  # Obtenir le sujet dominant de la nouvelle discussion
  new_1 <- posterior(topic_model_fr, newdata = dfm_new)
  dominant_topic <- which.max(new_1$topics)

  # Extraire les topics pour tous les documents existants
  topics <- posterior(topic_model_fr)$topics
  topic_docs <- apply(topics, 1, which.max) == as.integer(dominant_topic)

  # Vérifiez si des documents correspondent au sujet dominant
  if (!any(topic_docs)) {
    stop("Aucun document ne correspond au sujet dominant.")
  }

  dfm_topic <- dfm(grouped_train_data$discussion_text_client[topic_docs], docnames = paste0("doc_", seq_along(topic_docs)))

  # Harmoniser les vocabulaires
  dfm_new <- dfm_match(dfm_new, features = featnames(dfm_topic))

  # Vérifiez si dfm_new et dfm_topic contiennent des termes après harmonisation
  if (nfeat(dfm_new) == 0) {
    stop("La matrice document-fréquence (dfm) harmonisée est vide.")
  }
  if (nfeat(dfm_topic) == 0) {
    stop("La matrice document-fréquence (dfm) du topic est vide.")
  }

  # Convertir les DFMs en matrices denses
  dfm_new_matrix <- as.matrix(dfm_new)
  dfm_topic_matrix <- as.matrix(dfm_topic)

  # Calculer les similarités cosinus
  similarities <- cosine_similarity(dfm_new_matrix, dfm_topic_matrix)

  # Vérifiez si des similarités sont calculées
  if (length(similarities) == 0) {
    stop("Aucune similarité n'a été calculée.")
  }

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

  # Vérifiez si des produits ont été sélectionnés
  if (nrow(selected_products) == 0) {
    stop("Aucun produit sélectionné.")
  }

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

root <- getwd()
path_data <- file.path(root, "data")

# Charger les données d'entraînement et le modèle
grouped_train_ecobank_fr <- readRDS(file.path(path_data, "grouped_train_ecobank_fr.rds"))
topic_model_fr <- readRDS(file.path(path_data, "topic_model_fr.rds"))
topic_service <- readRDS(file.path(path_data, "topic_service.rds"))


############### Génération de la liste des numéro client
opt1 <- list(key = c(unique(grouped_train_ecobank_fr$Call_Number)),
                       text = c(unique(grouped_train_ecobank_fr$Call_Number)))

############# Generation da la liste pour le Dropdown
options <- mapply(function(i, x, y) list(ind = i, key = x, text = y),
                             seq.int(opt1$key), opt1$key, opt1$text,SIMPLIFY = FALSE)

# Interface utilisateur
recommendation_ui <- function(id){
  ns <- NS(id)
  fluentPage(
    div(class="container-fluid",
        div(class="row p-0 m-0", style = "gap: 10px;",
            Text("Choisir l'identifiant d'un client: ", style = "color: #0C71A2;"),
            div(style = "gap: 10px;",
                Dropdown.shinyInput(ns("call_number"), style = "width: 220px;",
                                    value = opt1$key[1],
                                    options = options),
            )
        ),
        div(class="row p-0 m-0",
            div(class="col-lg-6 pr-1 pl-0", id = "text_history",
                h4("Discussion history for this ID::"),
                textOutput(ns("history")),
            ),
            div(class="col-lg-6 pr-1 pl-0", id = "services_recommendation",
                h4("Services"),
                reactableOutput(ns("service"))
            )
        ),
        div(class="row p-0 m-0",
            div(class="col-lg-6 pr-1 pl-0", id = "barchart",
                uiOutput(ns("bar1")),
            ),
            div(class="col-lg-6 pr-1 pl-0", id = "productstabs",
                h4("Products"),
                reactableOutput(ns("recommendations"))
            )
        )
    )

  )
}

# Serveur
recommendation_server <- function(input, output, session) {

  output$bar1 <- renderUI({
    out <- accordionCard(accordionId = "accordionPlotBarplot",
                         headerId = 'plotchart4',
                         targetId = 'collapseCcplotchartBarplot',
                         headerContent = paste0("barplot", sep = ""),
                         bodyContent = echarts4rOutput(session$ns("barplot")),
                         iconId = paste0("_plotchart"),
                         dataset = "dataset")
  })

  # Mettre à jour les choix de selectInput avec les numéros d'appel uniques
  #updateSelectInput(session, "call_number", choices = unique(grouped_train_ecobank_fr$Call_Number))

  observeEvent(input$call_number, {
    req(input$call_number)
    call_number <- input$call_number

    # Filtrer l'historique des échanges pour le numéro d'appel sélectionné
    history <- grouped_train_ecobank_fr %>% filter(Call_Number == call_number) %>% select(discussion_text_client)

    ############# Historique de discution
    output$history <- renderText({
      paste(history)
    })

    # Filtrer l'historique des échanges pour le numéro d'appel sélectionné
    discussion <- grouped_train_ecobank_fr %>% filter(Call_Number == call_number) %>% pull(discussion_text_client)

    ################ Génération des produits à recommender
    recommendations_products <- recommender_system(discussion, topic_model_fr, grouped_train_ecobank_fr)

    output$recommendations <- renderReactable({
      reactable(recommendations_products,
                striped = TRUE,
                highlight = TRUE,
                defaultPageSize = 8,
                bordered = TRUE,
                minRows = 6,
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

    output$service <- renderReactable({
      reactable(topic_service[topic_service$Topic=="Credit & Loan Services",],
                striped = TRUE,
                highlight = TRUE,
                defaultPageSize = 8,
                bordered = TRUE,
                minRows = 6,
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

    # Afficher le graphique des cinq premières recommandations
    output$barplot <- renderEcharts4r({
      top_recommendations <- recommendations_products %>% head(5)
      top_recommendations %>%
        e_charts(Product) %>%
        e_bar(Score) %>%
        e_tooltip(trigger = 'axis') %>%
        e_x_axis(name = "Products") %>%
        e_y_axis(name = "Scores") %>%
        e_legend(type = "scroll",  orient = "vertical", right = "0%", top = "10%") %>%
        e_toolbox_feature() %>%
        e_toolbox_feature(
          feature = "magicType",
          type = list("line", "bar")
        )
    })

    # output$barplot <- renderPlotly({
    #
    #   #Top 5 des produits recommendés
    #   top_5 <- head(recommendations_products, 5)
    #
    #   fig <- plot_ly(top_5, x = ~top_5$Product , y = ~top_5$Score, type = 'bar', color = I("#0C71A2"))
    #   fig <- fig %>% layout(title = "Top 5 des produits recommendés",
    #                         xaxis = list(title = ""),
    #                         yaxis = list(title = ""))
    #
    #   fig
    # })
  })

}
