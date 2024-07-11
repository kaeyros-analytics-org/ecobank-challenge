# downloadbtn_ui ####
downloadbtn_ui <- function(id, downloadId, popoverId2) {
  
  ns <- NS(id)
  
  out <- htmlTemplate("www/htmlComponents/download_template.html",
                     downloadId = downloadId,
                     popoverId2 = popoverId2)
  
  return(out)
  
}

# downloadbtn_server ####
downloadbtn_server <- function(input,
                               output,
                               session,
                               tbdldl,
                               businessData,
                               filterStates) {

                                 
   tbldl_select <- tbdldl()$tbldl_select
   file_format <- tbdldl()$file_format

   if(!is.null(tbldl_select)) click("download_serverside")
   
   output$download_serverside <- downloadHandler(  
        filename = function() {
          if(file_format == ".csv") paste0(tbldl_select, "_data.csv") else paste0(tbldl_select, "_data.xlsx")
        },
        content = function(file) {
          
            if (str_detect(tbldl_select, "_ccLinechartEvents")){
              
              tbldl_select <- str_remove(tbldl_select, "Ereignisse")
              data <- businessData[[tbldl_select]][[1]][[1]] %>% 
                                                 select(-"Konflikttote")

              if(file_format == ".csv") write.csv(data, file, row.names = FALSE) else write.xlsx(data, file)

            } else if (str_detect(tbldl_select, "_ccLinechartKonflikttote")){
              
              tbldl_select <- str_remove(tbldl_select, "Konflikttote")
              data <- businessData[[tbldl_select]][[1]][[1]] %>% 
                                                 select(-"Ereignisse")
              if(file_format == ".csv") write.csv(data, file, row.names = FALSE) else write.xlsx(data, file)

            } else if (str_detect(tbldl_select, "_eoEventTable")) {

                data <- businessData[[paste0(filterStates$dataNavi$dataset, "_eventActor_data")]] %>%
                      filter(GID_1 %in% filterStates[[paste0(filterStates$dataNavi$dataset, "_provinceSelectionGID")]]) %>%
                      filter(SUB_EVENT_TYPE_DEU %in% filterStates[[paste0(filterStates$dataNavi$dataset, "_selectedEventTypes")]]) %>%
                      filter(DATA_ID %in% filterStates[[paste0(filterStates$dataNavi$dataset, "_eventSelection")]]) %>%
                      mutate(Ereigniszusammenfassung = 
                        paste0("<strong>Datum:</strong> ", EVENT_DATE, "<br/>",
                                "<strong>Akteur 1:</strong> ", ACTOR1, "<br/>",
                                "<strong>Akteur 2:</strong> ", ACTOR2, "<br/>",
                                "<strong>Konflikttote:</strong> ", FATALITIES, "<br/>",
                                "<strong>Eventkategorie:</strong> ", SUB_EVENT_TYPE_DEU, "<br/>",
                                "<strong>Zusammenfassung:</strong> ", NOTES))
                                
                  if(file_format == ".csv") write.csv(data, file, row.names = FALSE) else write.xlsx(data, file)
            } else {
              
              if (str_detect(tbldl_select, "_eoActorTable")) tbldl_select <- paste0(filterStates$dataNavi$dataset, "_eventActor_data")
              if (str_detect(tbldl_select, "_naNetwork")) tbldl_select <- paste0(filterStates$dataNavi$dataset, "_eventActor_data")
              if (str_detect(tbldl_select, "_eoBasemap")) tbldl_select <- paste0(filterStates$dataNavi$dataset, "_eventActor_data")

              if(file_format == ".csv") write.csv(businessData[[tbldl_select]], file, row.names = FALSE) else write.xlsx(businessData[[tbldl_select]], file)

            }

        }
    )

}