######## UI for situation global
global_situation_ui <- function(id){
  ns <- NS(id)
  shinyjs::useShinyjs()
  fluentPage(
    tags$style("
               .fieldGroup-82{border: none;}
               "),
    div(class="container-fluid",
        tags$br(),
        div( id = "",
          reactableOutput(ns("global_situation_tab_1")),
        ),
        div(style="display: flex;",
          div(class="col-lg-6 pr-1 pl-0",
              uiOutput(ns("text_global_situation_tab_1")),
            div(style="display: flex; justify-content: flex-end;",
              div(style = "margin-right: 10px;",
                ActionButton.shinyInput("save", "Save", style = "background-color: #2E3A89;
                                        height:45px; color: #fff; font-weight: bold;width:50px")),
              ActionButton.shinyInput("edit", "Edit", style = "background-color: #2E3A89;
                           height:45px; color: #fff; font-weight: bold;width:50px")
              )
            ),
          div(class="col-lg-6 pl-1 pr-0", id = "linechart",
            plotlyOutput(ns("plot_1"), width = "600px", height = "500px")
          )
        ),
        tags$br(),
        div(style="display: flex; font-weight: bold;",
            div(style="margin-left:500px;",
                HTML("Retail banking")),
            div(style="margin-left:300px;",
                HTML("Corporate banking"))
            ),
        tags$br(),
        div(style="display:flex; justify-content: space-evenly;",
            reactableOutput(ns("global_situation_tab_2")),
            reactableOutput(ns("global_situation_tab_3"))
          )
       
    )
  )
  
}

########### Server for situation global
global_situation_server <- function(input, output, session){
  
  output$global_situation_tab_1 <- renderReactable({
    reactable(global_situation_tab_1(), resizable = TRUE, selection = "single", #searchable = TRUE,
              onClick = "select", pagination = FALSE,
              #searchable = TRUE,
              wrap = FALSE,
              striped = FALSE,
              highlight = FALSE,
              bordered = TRUE,
              defaultColDef = colDef(
                header = function(value) gsub(".", " ", value, fixed = TRUE),
                align = "right",
                headerStyle = list(background = "#f0f5f9")
              ),
              theme = reactableTheme(
                stripedColor = "#f6f8fa",
                highlightColor = "#5547AC",
                cellPadding = "8px 12px",
                style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI,
          Helvetica, Arial, sans-serif"),
                searchInputStyle = list(width = "100%"),
                headerStyle = list(
                  "&:hover[aria-sort]" = list(background = "hsl(0, 0%, 96%)"),
                  "&[aria-sort='ascending'], &[aria-sort='descending']"
                  = list(background = "hsl(0, 0%, 96%)"),
                  borderColor = "grey"
                ),
                rowSelectedStyle = list(backgroundColor = "#2E3A89",
                                        boxShadow = "inset 2px 0 0 0 #ffa62d")
                
              )
              
    ) # End Reactable
  })
  
  
  output$plot_1 <- renderPlotly({
    plot_ly(data=compte_courant, x=~date,  y = ~Amount,
            type = 'scatter', mode = 'lines+markers')
  })
  
  output$global_situation_tab_2 <- renderReactable({
    reactable(global_situation_tab_2(), resizable = TRUE, selection = "single", #searchable = TRUE,
              onClick = "select", pagination = FALSE, 
              #searchable = TRUE,
              wrap = FALSE,
              striped = FALSE,
              highlight = FALSE,
              bordered = TRUE,
              defaultColDef = colDef(
                header = function(value) gsub("_", " ", value, fixed = TRUE),
                align = "left",
                minWidth = 200,
                headerStyle = list(background = "#f0f5f9")
              ),
              theme = reactableTheme(
                stripedColor = "#f6f8fa",
                highlightColor = "#5547AC",
                cellPadding = "8px 12px",
                style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI,
          Helvetica, Arial, sans-serif"),
                searchInputStyle = list(width = "100%"),
                headerStyle = list(
                  "&:hover[aria-sort]" = list(background = "hsl(0, 0%, 96%)"),
                  "&[aria-sort='ascending'], &[aria-sort='descending']"
                  = list(background = "hsl(0, 0%, 96%)"),
                  borderColor = "grey"
                ),
                rowSelectedStyle = list(backgroundColor = "#2E3A89",
                                        boxShadow = "inset 2px 0 0 0 #ffa62d")
                
              )
              
    ) # End Reactable
  })
  
  output$global_situation_tab_3 <- renderReactable({
    reactable(global_situation_tab_3(), resizable = TRUE, selection = "single", #searchable = TRUE,
              onClick = "select", pagination = FALSE, 
              #searchable = TRUE,
              wrap = FALSE,
              striped = FALSE,
              highlight = FALSE,
              bordered = TRUE,
              defaultColDef = colDef(
                header = function(value) gsub(".", " ", value, fixed = TRUE),
                align = "right",
                headerStyle = list(background = "#f0f5f9")
              ),
              theme = reactableTheme(
                stripedColor = "#f6f8fa",
                highlightColor = "#5547AC",
                cellPadding = "8px 12px",
                style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI,
          Helvetica, Arial, sans-serif"),
                searchInputStyle = list(width = "100%"),
                headerStyle = list(
                  "&:hover[aria-sort]" = list(background = "hsl(0, 0%, 96%)"),
                  "&[aria-sort='ascending'], &[aria-sort='descending']"
                  = list(background = "hsl(0, 0%, 96%)"),
                  borderColor = "grey"
                ),
                rowSelectedStyle = list(backgroundColor = "#2E3A89",
                                        boxShadow = "inset 2px 0 0 0 #ffa62d")
                
              )
              
    ) # End Reactable
  })
  
  ################# TextArea Input for first table
  output$text_global_situation_tab_1 <- renderUI({
    textAreaInput("text_global_situation_tab_1",label="",placeholder = "Ecrivez votre commentaire ici",height="380px",width="600px")
  })
  
}