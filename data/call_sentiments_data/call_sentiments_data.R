library(lubridate)
library(dplyr)
library(jsonlite)
library(tidyr)
require(quanteda)
require(quanteda.sentiment)
library(syuzhet)
library(tm)
library(SnowballC)
library(textstem)
library(stringr)
library(writexl)
library(readxl)
library(purrr)
library(cld3)
library(textcat)
library(fastText)
library(topicmodels)
library(tidytext)
library(LDAvis)
library(Rmpfr)



####################### Data to display scenarios ############################

############## Scenario en anglais
path_data_en_AFB23 <- file.path(path_data,"en_info_data_AFB2023.json")
# read data2
info_data_en_AFB2023 <- fromJSON(path_data_en_AFB23)

data_en <- info_data_en_AFB2023

# Nettoyage des données en supprimant les valeurs manquantes
data_clean <- data_en$Scenario_Chatbot[!is.na(data_en$Scenario_Chatbot)]

# Compter les occurrences de chaque scénario
data_scenario_counts <- as.data.frame(table(unlist(data_clean)))
scenario_counts <- table(unlist(data_clean))
# Créer un dataframe à partir des résultats
scenario_df <- data.frame(Scenario = names(scenario_counts), Count = as.numeric(scenario_counts))

# Filtrer les scénarios qui commencent par un chiffre suivi de deux points
scenario_df <- scenario_df[grep("^\\d{1,}: ", scenario_df$Scenario), ]

# Réinitialiser les index du dataframe
rownames(scenario_df) <- NULL


# Retirer les chiffres, les deux points et le mot "pour" au début de chaque scénario
scenario_df$Scenario <- gsub("^(\\d{1,}: |for )", "", scenario_df$Scenario)



# Trouver les indices des scénarios contenant le terme "Tapez"
indices <- grep("Press", scenario_df$Scenario)

# Supprimer les scénarios correspondants du dataframe
scenario_df <- scenario_df[-indices, ]

# Réinitialiser les index du dataframe
rownames(scenario_df) <- NULL

# Convertir le dataframe en JSON
scenario_data <- toJSON(scenario_df)
# Spécifier le chemin et le nom de fichier pour l'exportation
output_file <- file.path(path_data,"call_sentiments_data","scenario_data.json")
# Exporter le JSON
writeLines(scenario_data, output_file)



############################ to display opinion mining #########
wordcloud_data_file <- file.path(path_data,"customer_interaction_data","wordcloud_data.json")
sentiment_data <- fromJSON(wordcloud_data_file)

# Obtention des sentiments
sentiment_scores <- get_nrc_sentiment(sentiment_data$value, lang="english")
sentiment_data <- cbind(sentiment_data, sentiment_scores)
sentiment_data$neutral <- if_else(sentiment_data$negative==0 & sentiment_data$positive==0, 1, 0)

# Convertir le dataframe en JSON
sentiment_data <- toJSON(sentiment_data)
# Spécifier le chemin et le nom de fichier pour l'exportation
output_file <- file.path(path_data,"call_sentiments_data","sentiment_data.json")
# Exporter le JSON
writeLines(sentiment_data, output_file)




# emotions <- colSums(prop.table(sentiment_data[,3:10]))
# pourcentage_positive  <- colSums(prop.table(sentiment_data[,11:12]))
# 
# df_emotions <- as.data.frame(emotions)
# df_emotions$label <- rownames(df_emotions)
# 
# 
# 
# # Création du graphique avec echart4r
# emotions_data <- data.frame(
#   labels = names(emotions),
#   values = emotions
# )
# 
# 
# 
# # Ajout de la colonne "neutral"
# pourcentage_positive  <- colSums(prop.table(sentiment_data[,11:13]))
# 
# # Calcul des totaux pour chaque sentiment
# total_negative <- sum(sentiment_data$negative)
# total_positive <- sum(sentiment_data$positive)
# total_neutral <- sum(sentiment_data$neutral)
# 
# # Préparation des données pour echarts4r
# data <- data.frame(
#   sentiment = c("Negative", "Positive", "Neutral"),
#   count = c(total_negative, total_positive, total_neutral),
#   color = colorRampPalette(c("red", "gray20", "gray80"))(3)
# )
# 
# # Création du diagramme en anneau
# pie_chart_sentiments <- data %>%
#   e_charts(sentiment) %>%
#   e_pie(
#     count,
#     radius = c("40%", "70%"),
#     itemStyle = list(
#       borderRadius = 20,
#       borderColor = '#fff',
#       borderWidth = 2
#     )
#   ) %>%
#   e_tooltip(formatter = htmlwidgets::JS("function(params) { return params.name + ': ' + (params.percent + '%'); }")) %>%
#   e_labels(
#     show = TRUE,
#     formatter = "{d}%",
#     position = "top",
#     fontSize = 15
#   )  %>%
#   e_legend(
#     right = 0,
#     orient = "vertical"
#   ) %>%  
#   e_add_nested("itemStyle", color)
# pie_chart_sentiments
# 
# df_emotions$color <- colorRampPalette(c("red", "gray20", "gray80"))(8)
# # Création du graphique en secteurs (pie chart)
# pie_chart <- df_emotions %>%
#   e_charts(label) %>%
#   e_pie(
#     emotions,
#     radius = c("40%", "70%"),
#     itemStyle = list(
#       borderRadius = 20,
#       borderColor = '#fff',
#       borderWidth = 2
#     )
#   ) %>%
#   e_tooltip(formatter = htmlwidgets::JS("function(params) { return params.name + ': ' + (params.percent + '%'); }")) %>%
#   e_labels(
#     show = TRUE,
#     formatter = "{d}%",
#     position = "top",
#     fontSize = 15
#   )  %>%
#   e_legend(
#     right = 0,
#     orient = "vertical"
#   ) %>%  
#   e_add_nested("itemStyle", color)
# 
# # Affichage du graphique
# pie_chart
# 
# pie_chart_emotions <- pie_chart
# e_arrange(pie_chart_emotions, pie_chart_sentiments, cols = 2, rows = 1)


