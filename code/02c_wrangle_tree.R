
tree <- ape::read.nexus(file = "data/Heggarty_et_al_2023/01_Main_Analysis_M3/IECoR_Main_M3_Binary_Covarion_Rates_By_Mg_Bin/IECoR_Main_M3_Binary_Covarion_Rates_By_Mg_Bin_mcc.tree")

taxa_table <- read_tsv("data/Heggarty_et_al_2023/taxa_table.tsv", show_col_types = F) 

tree$tip.label <- tree$tip.label %>% 
  as.data.frame() %>% 
  full_join(taxa_table, by = c("." = "Name")) %>% 
  pull(Glottocode)

tree %>% 
  ape::write.tree(file = "output/processed_data/IE_heggarty2023_MCCT.tree")