######## Data to display customer_interaction_data page #############
wordcloud_data_file <- file.path(path_data,"customer_interaction_data","wordcloud_data.json")
wordcloud_data <- fromJSON(wordcloud_data_file)
wordcloud_data$Start_time_discusion <- as.Date(wordcloud_data$Start_time_discusion)


customer_interaction_ui <- function(id){
  ns <- NS(id)
  
  fluentPage(
    tags$style("
               .fieldGroup-82{border: none;}
               "),
    div(class="container-fluid", style = "text-align: center;", tags$h4("Wordcloud"),
            uiOutput(ns("Wordcloud"), style="display: inline-block;")
        ),
    div(class="container-fluid", style = "text-align: center;", tags$h4("Average Time of Resolution by Topic"),
            htmlOutput(ns('topicChart'))
        )
  )
  
  
}

customer_interaction_server <- function(input, output, session, filterStates){
  
  wordcloud_data_filter <- reactive({ wordcloud_data %>%
      filter(Start_time_discusion >= ymd(filterStates$date_start) &
               Start_time_discusion <= ymd(filterStates$date_end)) %>%
      filter(if (filterStates$citySelected != "All") city == filterStates$citySelected else TRUE)
  })
  
  output$topicChart <- renderUI({
    root <- getwd()
    path_data <- file.path(root,"data")
    route <- paste(file.path(path_data,"customer_interaction_data"),"/Topic_modelling", sep="")
    addResourcePath("lda", route)
    url = "lda/index.html"
    lda <- tags$iframe(src=url, height=700, width=1400)
    lda
    })
  
  output$Wordcloud <- renderUI({
    
    word_freq <- wordcloud_data_filter() %>%
      select(Claims_Assurance) %>%
      unnest_tokens(word, Claims_Assurance) %>%
      count(word, sort = TRUE)
    
    wordcloud2(word_freq, size = 2)
    
  })
  
}