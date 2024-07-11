

scenario_data_file <- file.path(path_data,"call_sentiments_data","scenario_data.json")
scenario_data <- fromJSON(scenario_data_file)

# Trier les données par nombre d'occurrences
scenario_data <- scenario_data[order(scenario_data$Count, decreasing = TRUE), ]
# Sélectionner les 30 premières lignes du dataframe trié
top_30 <- head(scenario_data, 30)

##################### Data to display sentiment analyst ############################
sentiment_data_file <- file.path(path_data,"call_sentiments_data","sentiment_data.json")
sentiment_data <- fromJSON(sentiment_data_file)
sentiment_data$Start_time_discusion <- as.Date(sentiment_data$Start_time_discusion)


######## UI for Sentiment
call_sentiments_ui <- function(id){
  ns <- NS(id)
  fluentPage(
    div(class="container-fluid",
        div(class="row p-0 m-0", 
            div(class="col-lg-6 pr-1 pl-0",id = "sentiment1",
                uiOutput(ns("call_sentiment1"))
            ),
            div(class="col-lg-6 pl-1 pr-0", id = "sentiment2",
                uiOutput(ns("call_sentiment2"))
            )
        )
    )
  )
  
}



########### Server for Sentiment
call_sentiments_server <- function(input, output, session, filterStates){
  
  output$call_sentiment1 <- renderUI({
    out <- accordionCard(accordionId = "accordionPlotSentiments1",
                         headerId = 'plotchart1',
                         targetId = 'collapseCcplotchartSentiments1',
                         headerContent = paste0("Reclamation Sentiments", sep = ""),
                         bodyContent = echarts4rOutput(session$ns("call_sentiment1_plot")),
                         iconId = paste0("_plotchart"),
                         dataset = "dataset")
  })
  
  output$call_sentiment2 <- renderUI({
    out <- accordionCard(accordionId = "accordionPlotSentiments2",
                         headerId = 'plotchart2',
                         targetId = 'collapseCcplotchartSentiments2',
                         headerContent = paste0("Reclamation Emotions", sep = ""),
                         bodyContent = echarts4rOutput(session$ns("call_sentiment2_plot")),
                         iconId = paste0("_plotchart"),
                         dataset = "dataset")
  })
  
  # data_en_filter <- reactive({ sentiment_data %>%
  #     filter(Start_time_discusion >= ymd(filterStates$date_start) &
  #              Start_time_discusion <= ymd(filterStates$date_end)) 
  # })
  
  data_en_filter <- reactive({ sentiment_data })
  
  output$call_sentiment1_plot <- renderEcharts4r({
    
    # Calcul des totaux pour chaque sentiment
    total_negative <- sum(data_en_filter()$negative)
    total_positive <- sum(data_en_filter()$positive)
    total_neutral <- sum(data_en_filter()$neutral)
    
    # Préparation des données pour echarts4r
    data <- data.frame(
      sentiment = c("Negative", "Positive", "Neutral"),
      count = c(total_negative, total_positive, total_neutral),
      color = colorRampPalette(c("#23557f", "gray20", "gray80"))(3)
    )
    
    # Création du diagramme en anneau
    pie_chart_sentiments <- data %>%
      e_charts(sentiment) %>%
      e_pie(
        count,
        radius = c("40%", "70%"),
        itemStyle = list(
          borderRadius = 20,
          borderColor = '#fff',
          borderWidth = 2
        )
      ) %>%
      e_tooltip(formatter = htmlwidgets::JS("function(params) { return params.name + ': ' + (params.percent + '%'); }")) %>%
      e_labels(show = TRUE,
               formatter = "{d}%",
               position = "inside") %>%
      e_legend(
        right = 0,
        orient = "vertical"
      ) %>%  
      e_add_nested("itemStyle", color)
    pie_chart_sentiments
    
    
  }) 
  
  output$call_sentiment2_plot <- renderEcharts4r({
    emotions <- colSums(prop.table(data_en_filter()[,3:10]))
    
    df_emotions <- as.data.frame(emotions)
    df_emotions$label <- rownames(df_emotions)
    df_emotions$color <- colorRampPalette(c("#23557f", "gray20", "gray80"))(8)
    
    pie_chart <- df_emotions |> 
      e_charts(label) |> 
      e_pie(
        emotions,
        radius = c("40%", "70%"),
        itemStyle = list(
          borderRadius = 20,
          borderColor = '#fff',
          borderWidth = 2
        )
      ) %>%  # Centrer le graphique
      e_tooltip(formatter = htmlwidgets::JS("function(params) { return params.name + ': ' + (params.percent + '%'); }")) %>%
      e_labels(show = TRUE,
               formatter = "{d}%",
               position = "inside") %>%
      e_legend(right = 0, 
               orient = "vertical")%>%  
      e_add_nested("itemStyle", color)
    
    # Affichage du graphique
    pie_chart
    
  }) 
}