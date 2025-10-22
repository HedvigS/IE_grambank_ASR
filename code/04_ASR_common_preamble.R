source("01_requirements.R")

tree <- ape::read.tree("output/processed_data/IE_heggarty2023_MCCT.tree")

#reading in GB
GB_df_desc <-  data.table::fread(file = "output/processed_data/Grambank_2.0_ParameterTable.tsv",
                                 encoding = 'UTF-8', 
                                 quote = "\"", 
                                 fill = T, 
                                 header = TRUE, 
                                 sep = "\t") %>% 
  dplyr::select(ID, Grambank_ID_desc) %>% 
  mutate(Grambank_ID_desc = str_replace_all(Grambank_ID_desc, " ", "_"))

#reading in Grambank
GB_df_all <- read_tsv(file = "output/processed_data/Grambank_2.0_ValueTable.tsv", show_col_types = FALSE) 

glottolog_df <- read_tsv(file = "output/processed_data/glottolog_5.0_languages.tsv", show_col_types = FALSE)


ntips_half <- 40

source("functions/fun_def_plotRECON_tweaked.R")

colours_binary = c("yellow", "purple")
