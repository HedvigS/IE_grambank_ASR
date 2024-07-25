source("01_requirements.R")

GB_ParameterTable <- read_csv("../../../../Grambank 2.0/cldf/parameters.csv", show_col_types = FALSE)  %>% 
  dplyr::select(Parameter_ID = ID, Name, Grambank_ID_desc)

IE_CladeTable <- read_tsv("data/IE_clades.tsv", show_col_types = FALSE) %>% 
  filter(!is.na(Clade)) %>% 
  filter(is.na(Contact)) %>% 
  dplyr::select(Glottocode, Clade) %>% 
  group_by(Clade) %>% 
  mutate(n_clade = n()) 

Grambank_ValueTable <-   read_tsv("data/processed_data/Grambank_2.0_ValueTable.tsv", show_col_types = FALSE) %>% 
  inner_join(IE_CladeTable, by = "Glottocode") 

Table <-  Grambank_ValueTable %>% 
  group_by(Clade, Parameter_ID) %>% 
  summarise(n = n(), 
            n_clade = first(n_clade), .groups = "drop") %>% 
  mutate(coverage = n/n_clade) %>% 
  group_by(Clade) %>%
  slice_max(order_by = coverage, n = 20) %>% 
  mutate(Clade = paste0("Proto-", Clade)) %>% 
  left_join(GB_ParameterTable, by = "Parameter_ID") %>% 
  dplyr::select(Clade, Parameter_ID, Name, Grambank_ID_desc) %>% 
  mutate(Value = NA, 
         Source = NA, 
         Comment = NA)

Table %>% 
  write_tsv("data/processed_data/Proto-lgs_table.tsv", na = "")

  
  
