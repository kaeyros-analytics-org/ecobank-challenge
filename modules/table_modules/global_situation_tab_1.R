##################### First table of Situation globale
global_situation_tab_1 <- shiny::reactive({
  ### fill cell for compte courant
  compte_courant_amount <- fill_cell(reactives$compte_courant(),filterStates$first_date,"Compte courant")
  tab$first_date[which(tab$`encours_ressources` == "Compte courant")] <- compte_courant_amount
  
  ############### compte_bloquées #########################
  compte_bloquee_amount <- fill_cell(reactives$compte_bloquee(),filterStates$first_date,"Compte bloquées")
  tab$first_date[which(tab$`encours_ressources` == "Compte bloquées")] <- compte_bloquee_amount
  
  ############### compte_cheques #######################
  compte_cheques_amount <- fill_cell(reactives$compte_cheques(),filterStates$first_date,"Compte chèques")
  tab$first_date[which(tab$`encours_ressources` == "Compte chèques")] <- compte_cheques_amount
  
  ############### compte_livrets #############################
  compte_livrets_amount <- fill_cell(reactives$compte_livrets(),filterStates$first_date,"Compte livrets")
  tab$first_date[which(tab$`encours_ressources` == "Compte livrets")] <- compte_livrets_amount
  
  ############### depot_garantie #############################
  depot_garantie_amount <- fill_cell(reactives$depot_garantie(),filterStates$first_date,"Dépots de garantie")
  tab$first_date[which(tab$`encours_ressources` == "Dépots de garantie")] <- depot_garantie_amount
  
  ############### flash_cash #############################
  flash_cash_amount <- fill_cell(reactives$flash_cash(),filterStates$first_date,"Flash cash")
  tab$first_date[which(tab$`encours_ressources` == "Flash cash")] <- flash_cash_amount
  
  ############### autre_somme_client #############################
  autre_somme_client_amount <- fill_cell(reactives$autre_somme_client(),filterStates$first_date,"Autres sommes dues à la clientèle")
  tab$first_date[which(tab$`encours_ressources` == "Autres sommes dues à la clientèle")] <- autre_somme_client_amount
  
  ############### valeur_non_imputees #############################
  valeur_non_imputees_amount <- fill_cell(reactives$valeur_non_imputees(),filterStates$first_date,"Valeur non imputées")
  tab$first_date[which(tab$`encours_ressources` == "Valeur non imputées")] <- valeur_non_imputees_amount
  
  ############### compte_a_vue #############################
  compte_a_vue_amount <- fill_cell(reactives$compte_a_vue(),filterStates$first_date,"Comptes à vue des correspondants")
  tab$first_date[which(tab$`encours_ressources` == "Comptes à vue des correspondants")] <- compte_a_vue_amount
  
  ############### disposition_a_payer #############################
  disposition_a_payer_amount <- fill_cell(reactives$disposition_a_payer(),filterStates$first_date,"Disposition à Payer")
  tab$first_date[which(tab$`encours_ressources` == "Disposition à Payer")] <- disposition_a_payer_amount
  
  
  ############### Dépôts à vue ############################# Sum of all lines
  depot_a_vue_amount <- c(compte_courant_amount + compte_bloquee_amount + compte_cheques_amount
                          + compte_livrets_amount + depot_garantie_amount + flash_cash_amount + autre_somme_client_amount
                          + valeur_non_imputees_amount + compte_a_vue_amount + disposition_a_payer_amount)
  
  tab$first_date[which(tab$`encours_ressources` == 'Dépôts à vue')] <- depot_a_vue_amount
  
  #### fill cell for bons de caisse
  bon_caisse_amount <- fill_cell(reactives$bon_de_caisse(),filterStates$first_date,"Bons de caisse")
  tab$first_date[which(tab$`encours_ressources` == "Bons de caisse")] <- bon_caisse_amount
  
  ### fill cell for Dépôts à terme1
  depot_terme_amount <- fill_cell(reactives$depot_a_terme(),filterStates$first_date,"Dépôts à terme")
  tab$first_date[which(tab$`encours_ressources` == "Dépôts à terme")] <- depot_terme_amount
  
  ### fill cell for Banque et Etabl. Fin
  banque_ets_amount <- fill_cell(reactives$banque_ets(),filterStates$first_date,"Banque et Etabl. Fin")
  tab$first_date[which(tab$`encours_ressources` == "Banque et Etabl. Fin")] <- banque_ets_amount
  
  ### fill cell for Dépôts à terme2
  depot_terme_amount_final <- c(bon_caisse_amount + depot_terme_amount + banque_ets_amount)
  tab$first_date[which(tab$`encours_ressources` == 'Dépôts à terme ')] <- depot_terme_amount_final
  
  ## fill cell for Total des ressources
  total_ressources_amount <- c(depot_terme_amount_final + depot_a_vue_amount)
  tab$first_date[which(tab$`encours_ressources` == 'Total des ressources')] <- total_ressources_amount
  
  ##### fill the first date column 
  compte_courant_amount2 <- fill_cell(reactives$compte_courant(),filterStates$date_start,"Compte courant")
  tab$date_start[which(tab$`encours_ressources` == "Compte courant")] <- compte_courant_amount2
  
  ############### compte_bloquées #########################
  compte_bloquee_amount2 <- fill_cell(reactives$compte_bloquee(),filterStates$date_start,"Compte bloquées")
  tab$date_start[which(tab$`encours_ressources` == "Compte bloquées")] <- compte_bloquee_amount2
  
  ############### compte_cheques #######################
  compte_cheques_amount2 <- fill_cell(reactives$compte_cheques(),filterStates$date_start,"Compte chèques")
  tab$date_start[which(tab$`encours_ressources` == "Compte chèques")] <- compte_cheques_amount2
  
  ############### compte_livrets #############################
  compte_livrets_amount2 <- fill_cell(reactives$compte_livrets(),filterStates$date_start,"Compte livrets")
  tab$date_start[which(tab$`encours_ressources` == "Compte livrets")] <- compte_livrets_amount2
  
  ############### depot_garantie #############################
  depot_garantie_amount2 <- fill_cell(reactives$depot_garantie(),filterStates$date_start,"Dépots de garantie")
  tab$date_start[which(tab$`encours_ressources` == "Dépots de garantie")] <- depot_garantie_amount2
  
  ############### flash_cash #############################
  flash_cash_amount2 <- fill_cell(reactives$flash_cash(),filterStates$date_start,"Flash cash")
  tab$date_start[which(tab$`encours_ressources` == "Flash cash")] <- flash_cash_amount2
  
  ############### autre_somme_client #############################
  autre_somme_client_amount2 <- fill_cell(reactives$autre_somme_client(),filterStates$date_start,"Autres sommes dues à la clientèle")
  tab$date_start[which(tab$`encours_ressources` == "Autres sommes dues à la clientèle")] <- autre_somme_client_amount2
  
  ############### valeur_non_imputees #############################
  valeur_non_imputees_amount2 <- fill_cell(reactives$valeur_non_imputees(),filterStates$date_start,"Valeur non imputées")
  tab$date_start[which(tab$`encours_ressources` == "Valeur non imputées")] <- valeur_non_imputees_amount2
  
  ############### compte_a_vue #############################
  compte_a_vue_amount2 <- fill_cell(reactives$compte_a_vue(),filterStates$date_start,"Comptes à vue des correspondants")
  tab$date_start[which(tab$`encours_ressources` == "Comptes à vue des correspondants")] <- compte_a_vue_amount2
  
  ############### disposition_a_payer #############################
  disposition_a_payer_amount2 <- fill_cell(reactives$disposition_a_payer(),filterStates$date_start,"Disposition à Payer")
  tab$date_start[which(tab$`encours_ressources` == "Disposition à Payer")] <- disposition_a_payer_amount2
  
  ############### Dépôts à vue ############################# Sum of all lines
  depot_a_vue_amount2 <- c(compte_courant_amount2 + compte_bloquee_amount2 + compte_cheques_amount2
                           + compte_livrets_amount2 + depot_garantie_amount2 + flash_cash_amount2 + autre_somme_client_amount2
                           + valeur_non_imputees_amount2 + compte_a_vue_amount2 + disposition_a_payer_amount2)
  
  tab$date_start[which(tab$`encours_ressources` == 'Dépôts à vue')] <- depot_a_vue_amount2
  
  #### fill cell for bons de caisse
  bon_caisse_amount2 <- fill_cell(reactives$bon_de_caisse(),filterStates$date_start,"Bons de caisse")
  tab$date_start[which(tab$`encours_ressources` == "Bons de caisse")] <- bon_caisse_amount2
  
  ### fill cell for Dépôts à terme1
  depot_terme_amount2 <- fill_cell(reactives$depot_a_terme(),filterStates$date_start,"Dépôts à terme")
  tab$date_start[which(tab$`encours_ressources` == "Dépôts à terme")] <- depot_terme_amount2
  
  ### fill cell for Banque et Etabl. Fin
  banque_ets_amount2 <- fill_cell(reactives$banque_ets(),filterStates$date_start,"Banque et Etabl. Fin")
  tab$date_start[which(tab$`encours_ressources` == "Banque et Etabl. Fin")] <- banque_ets_amount2
  
  ### fill cell for Dépôts à terme2
  depot_terme_amount2_final <- c(bon_caisse_amount2 + depot_terme_amount2 + banque_ets_amount2)
  tab$date_start[which(tab$`encours_ressources` == 'Dépôts à terme ')] <- depot_terme_amount2_final
  
  
  ## fill cell for Total des ressources
  total_ressources_amount2 <- c(depot_terme_amount2_final + depot_a_vue_amount2)
  tab$date_start[which(tab$`encours_ressources` == 'Total des ressources')] <- total_ressources_amount2
  
  ### fill column second date
  compte_courant_amount3 <- fill_cell(reactives$compte_courant(),filterStates$date_end,"Compte courant")
  tab$date_end[which(tab$`encours_ressources` == "Compte courant")] <- compte_courant_amount3
  
  ############### compte_bloquées #########################
  compte_bloquee_amount3 <- fill_cell(reactives$compte_bloquee(),filterStates$date_end,"Compte bloquées")
  tab$date_end[which(tab$`encours_ressources` == "Compte bloquées")] <- compte_bloquee_amount3
  
  ############### compte_cheques #######################
  compte_cheques_amount3 <- fill_cell(reactives$compte_cheques(),filterStates$date_end,"Compte chèques")
  tab$date_end[which(tab$`encours_ressources` == "Compte chèques")] <- compte_cheques_amount3
  
  ############### compte_livrets #############################
  compte_livrets_amount3 <- fill_cell(reactives$compte_livrets(),filterStates$date_end,"Compte livrets")
  tab$date_end[which(tab$`encours_ressources` == "Compte livrets")] <- compte_livrets_amount3
  
  ############### depot_garantie #############################
  depot_garantie_amount3 <- fill_cell(reactives$depot_garantie(),filterStates$date_end,"Dépots de garantie")
  tab$date_end[which(tab$`encours_ressources` == "Dépots de garantie")] <- depot_garantie_amount3
  
  ############### flash_cash #############################
  flash_cash_amount3 <- fill_cell(reactives$flash_cash(),filterStates$date_end,"Flash cash")
  tab$date_end[which(tab$`encours_ressources` == "Flash cash")] <- flash_cash_amount3
  
  ############### autre_somme_client #############################
  autre_somme_client_amount3 <- fill_cell(reactives$autre_somme_client(),filterStates$date_end,"Autres sommes dues à la clientèle")
  tab$date_end[which(tab$`encours_ressources` == "Autres sommes dues à la clientèle")] <- autre_somme_client_amount3
  
  ############### valeur_non_imputees #############################
  valeur_non_imputees_amount3 <- fill_cell(reactives$valeur_non_imputees(),filterStates$date_end,"Valeur non imputées")
  tab$date_end[which(tab$`encours_ressources` == "Valeur non imputées")] <- valeur_non_imputees_amount3
  
  ############### compte_a_vue #############################
  compte_a_vue_amount3 <- fill_cell(reactives$compte_a_vue(),filterStates$date_end,"Comptes à vue des correspondants")
  tab$date_end[which(tab$`encours_ressources` == "Comptes à vue des correspondants")] <- compte_a_vue_amount3
  
  ############### disposition_a_payer #############################
  disposition_a_payer_amount3 <- fill_cell(reactives$disposition_a_payer(),filterStates$date_end,"Disposition à Payer")
  tab$date_end[which(tab$`encours_ressources` == "Disposition à Payer")] <- disposition_a_payer_amount3
  
  ############### Dépôts à vue ############################# Sum of all lines
  depot_a_vue_amount3 <- c(compte_courant_amount3 + compte_bloquee_amount3 + compte_cheques_amount3
                           + compte_livrets_amount3 + depot_garantie_amount3 + flash_cash_amount3 + autre_somme_client_amount3
                           + valeur_non_imputees_amount3 + compte_a_vue_amount3 + disposition_a_payer_amount3)
  
  tab$date_end[which(tab$`encours_ressources` == 'Dépôts à vue')] <- depot_a_vue_amount3
  
  #### fill cell for bons de caisse
  bon_caisse_amount3 <- fill_cell(reactives$bon_de_caisse(),filterStates$date_end,"Bons de caisse")
  tab$date_end[which(tab$`encours_ressources` == "Bons de caisse")] <- bon_caisse_amount3
  
  ### fill cell for Dépôts à terme1
  depot_terme_amount3 <- fill_cell(reactives$depot_a_terme(),filterStates$date_end,"Dépôts à terme")
  tab$date_end[which(tab$`encours_ressources` == "Dépôts à terme")] <- depot_terme_amount3
  
  ### fill cell for Banque et Etabl. Fin
  banque_ets_amount3 <- fill_cell(reactives$banque_ets(),filterStates$date_end,"Banque et Etabl. Fin")
  tab$date_end[which(tab$`encours_ressources` == "Banque et Etabl. Fin")] <- banque_ets_amount3
  
  ### fill cell for Dépôts à terme2
  depot_terme_amount3_final <- c(bon_caisse_amount3 + depot_terme_amount3 + banque_ets_amount3)
  tab$date_end[which(tab$`encours_ressources` == 'Dépôts à terme ')] <- depot_terme_amount3_final
  
  
  ## fill cell for Total des ressources
  total_ressources_amount3 <- c(depot_terme_amount3_final + depot_a_vue_amount3)
  tab$date_end[which(tab$`encours_ressources` == 'Total des ressources')] <- total_ressources_amount3
  
  for (i in 1:nrow(tab)){
    tab$Variation[i] <- as.numeric(tab$date_end[i]) - as.numeric(tab$date_start[i])
  }
  
  tab$Réalisation <- tab$date_end
  
  
  colnames(tab)[colnames(tab) == 'first_date'] <- as.character(filterStates$first_date)
  colnames(tab)[colnames(tab) == 'date_start'] <- as.character(filterStates$date_start)
  colnames(tab)[colnames(tab) == 'date_end'] <- as.character(filterStates$date_end)
  colnames(tab)[colnames(tab) == 'Objectifs_year'] <- paste("Objectif", year(filterStates$date_start))
  
  ############### Final data frame
  tab
}) #### END