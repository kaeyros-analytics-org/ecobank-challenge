
##################### Second table of Situation globale
global_situation_tab_2 <- shiny::reactive({
  #compte courant retail
  compte_courant_amount <- fill_cell_retail(reactives$compte_courant(),filterStates$date_start,"Compte courant")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Compte courant")] <- compte_courant_amount
  
  compte_bloquee_amount <- fill_cell_retail(reactives$compte_bloquee(),filterStates$date_start,"Compte bloquées")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Compte bloquées")] <- compte_bloquee_amount
  
  compte_cheques_amount <- fill_cell_retail(reactives$compte_cheques(),filterStates$date_start,"Compte chèques")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Compte chèques")] <- compte_cheques_amount
  
  compte_livrets_amount <- fill_cell_retail(reactives$compte_livrets(),filterStates$date_start,"Compte livrets")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Compte livrets")] <- compte_livrets_amount
  
  depot_garantie_amount <- fill_cell_retail(reactives$depot_garantie(),filterStates$date_start,"Dépots de garantie")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Dépots de garantie")] <- depot_garantie_amount
  
  flash_cash_amount <- fill_cell_retail(reactives$flash_cash(),filterStates$date_start,"Flash cash")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Flash cash")] <- flash_cash_amount
  
  autre_somme_client_amount <- fill_cell_retail(reactives$autre_somme_client(),filterStates$date_start,"Autres sommes dues à la clientèle")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Autres sommes dues à la clientèle")] <- autre_somme_client_amount
  
  valeur_non_imputees_amount <- fill_cell_retail(reactives$valeur_non_imputees(),filterStates$date_start,"Valeur non imputées")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Valeur non imputées")] <- valeur_non_imputees_amount
  
  compte_a_vue_amount <- fill_cell_retail(reactives$compte_a_vue(),filterStates$date_start,"Comptes à vue des correspondants")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Comptes à vue des correspondants")] <- compte_a_vue_amount
  
  disposition_a_payer_amount <- fill_cell_retail(reactives$disposition_a_payer(),filterStates$date_start,"Disposition à Payer")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Disposition à Payer")] <- disposition_a_payer_amount
  
  depot_a_vue_amount <- c(compte_courant_amount + compte_bloquee_amount + compte_cheques_amount
                          + compte_livrets_amount + depot_garantie_amount + flash_cash_amount + autre_somme_client_amount
                          + valeur_non_imputees_amount + compte_a_vue_amount + disposition_a_payer_amount)
  
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == 'Dépôts à vue')] <- depot_a_vue_amount
  
  bon_caisse_amount <- fill_cell_retail(reactives$bon_de_caisse(),filterStates$date_start,"Bons de caisse")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Bons de caisse")] <- bon_caisse_amount
  
  depot_terme_amount <- fill_cell_retail(reactives$depot_a_terme(),filterStates$date_start,"Dépôts à terme")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Dépôts à terme")] <- depot_terme_amount
  
  banque_ets_amount <- fill_cell_retail(reactives$banque_ets(),filterStates$date_start,"Banque et Etabl. Fin")
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == "Banque et Etabl. Fin")] <- banque_ets_amount
  
  depot_terme_amount_final <- c(bon_caisse_amount + depot_terme_amount + banque_ets_amount)
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == 'Dépôts à terme ')] <- depot_terme_amount_final
  
  total_ressources_amount <- c(depot_terme_amount_final + depot_a_vue_amount)
  tab_2$retails_date_start[which(tab_2$`encours_ressources` == 'Total des ressources')] <- total_ressources_amount
  
  compte_courant_amount2 <- fill_cell_retail(reactives$compte_courant(),filterStates$date_end,"Compte courant")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Compte courant")] <- compte_courant_amount2
  
  compte_bloquee_amount2 <- fill_cell_retail(reactives$compte_bloquee(),filterStates$date_end,"Compte bloquées")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Compte bloquées")] <- compte_bloquee_amount2
  
  ############### compte_cheques #######################
  compte_cheques_amount2 <- fill_cell_retail(reactives$compte_cheques(),filterStates$date_end,"Compte chèques")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Compte chèques")] <- compte_cheques_amount2
  
  ############### compte_livrets #############################
  compte_livrets_amount2 <- fill_cell_retail(reactives$compte_livrets(),filterStates$date_end,"Compte livrets")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Compte livrets")] <- compte_livrets_amount2
  
  depot_garantie_amount2 <- fill_cell_retail(reactives$depot_garantie(),filterStates$date_end,"Dépots de garantie")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Dépots de garantie")] <- depot_garantie_amount2
  
  ############### flash_cash #############################
  flash_cash_amount2 <- fill_cell_retail(reactives$flash_cash(),filterStates$date_end,"Flash cash")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Flash cash")] <- flash_cash_amount2
  
  ############### autre_somme_client #############################
  autre_somme_client_amount2 <- fill_cell_retail(reactives$autre_somme_client(),filterStates$date_end,"Autres sommes dues à la clientèle")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Autres sommes dues à la clientèle")] <- autre_somme_client_amount2
  
  ############### valeur_non_imputees #############################
  valeur_non_imputees_amount2 <- fill_cell_retail(reactives$valeur_non_imputees(),filterStates$date_end,"Valeur non imputées")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Valeur non imputées")] <- valeur_non_imputees_amount2
  
  compte_a_vue_amount2 <- fill_cell_retail(reactives$compte_a_vue(),filterStates$date_end,"Comptes à vue des correspondants")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Comptes à vue des correspondants")] <- compte_a_vue_amount2
  
  ############### disposition_a_payer #############################
  disposition_a_payer_amount2 <- fill_cell_retail(reactives$disposition_a_payer(),filterStates$date_end,"Disposition à Payer")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Disposition à Payer")] <- disposition_a_payer_amount2
  
  ############### Dépôts à vue ############################# Sum of all lines
  depot_a_vue_amount2 <- c(compte_courant_amount2 + compte_bloquee_amount2 + compte_cheques_amount2
                           + compte_livrets_amount2 + depot_garantie_amount2 + flash_cash_amount2 + autre_somme_client_amount2
                           + valeur_non_imputees_amount2 + compte_a_vue_amount2 + disposition_a_payer_amount2)
  
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == 'Dépôts à vue')] <- depot_a_vue_amount2
  
  bon_caisse_amount2 <- fill_cell_retail(reactives$bon_de_caisse(),filterStates$date_end,"Bons de caisse")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Bons de caisse")] <- bon_caisse_amount2
  
  ### fill cell for Dépôts à terme1
  depot_terme_amount2 <- fill_cell_retail(reactives$depot_a_terme(),filterStates$date_end,"Dépôts à terme")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Dépôts à terme")] <- depot_terme_amount2
  
  ### fill cell for Banque et Etabl. Fin
  banque_ets_amount2 <- fill_cell_retail(reactives$banque_ets(),filterStates$date_end,"Banque et Etabl. Fin")
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == "Banque et Etabl. Fin")] <- banque_ets_amount2
  
  depot_terme_amount2_final <- c(bon_caisse_amount2 + depot_terme_amount2 + banque_ets_amount2)
  tab_2$retails_date_end[which(tab$`encours_ressources` == 'Dépôts à terme ')] <- depot_terme_amount2_final
  
  
  ## fill cell for Total des ressources
  total_ressources_amount2 <- c(depot_terme_amount2_final + depot_a_vue_amount2)
  tab_2$retails_date_end[which(tab_2$`encours_ressources` == 'Total des ressources')] <- total_ressources_amount2
  
  for (i in 1:nrow(tab_2)){
    tab_2$Variation[i] <- as.numeric(tab_2$retails_date_end[i]) - as.numeric(tab_2$retails_date_start[i])
  }
  
  colnames(tab_2)[colnames(tab_2) == 'retails_date_start'] <- as.character(filterStates$date_start)
  colnames(tab_2)[colnames(tab_2) == 'retails_date_end'] <- as.character(filterStates$date_end)

  ############### Final data frame
  tab_2
}) #### END


