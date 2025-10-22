source("01_requirements.R")

GB_LanguageTable <- read_csv("../../../../grambank-v2.0rc2 2/cldf/languages.csv", show_col_types = FALSE)  
  
GB_ValueTable <- read_csv("../../../../grambank-v2.0rc2 2/cldf/values.csv", show_col_types = FALSE) %>% 
    rgrambank::make_binary_ValueTable(keep_multistate = FALSE, keep_native_binary = TRUE) %>% 
  rgrambank::reduce_ValueTable_to_unique_glottocodes(LanguageTable = GB_LanguageTable, merge_dialects = T, method = "combine_random", replace_missing_language_level_ID = T)

GB_ValueTable %>% 
  write_tsv("output/processed_data/Grambank_2.0_ValueTable.tsv", na = "", quote = "all")


GB_ParameterTable <- read_csv("../../../../grambank-v2.0rc2 2/cldf/parameters.csv", show_col_types = FALSE) %>% 
  rgrambank::make_binary_ParameterTable(keep_multi_state_features = FALSE)

GB_ParameterTable %>% 
  write_tsv("output/processed_data/Grambank_2.0_ParameterTable.tsv", na = "", quote = "all")

Glottolog_LanguageTable <- read_tsv("output/processed_data/glottolog_5.0_languages.tsv", show_col_types = F) %>% 
  filter(Family_ID == "indo1319")  %>% 
  dplyr::select(Glottocode, Longitude, Latitude, Macroarea, Name, aes, med, Is_Isolate, classification, subclassification, Family_ID)
  
GB_ValueTable %>% 
  dplyr::select(Glottocode) %>% 
  inner_join(Glottolog_LanguageTable, by = "Glottocode") %>%
  distinct() %>% 
  write_tsv("output/processed_data/GB_v2.0_LanguageTable.tsv")

#props
n_max <- GB_ValueTable$Parameter_ID %>% unique() %>% length()

GB_props <- GB_ValueTable %>% 
  inner_join(Glottolog_LanguageTable, by = "Glottocode") %>% 
  dplyr::group_by(Glottocode) %>% 
  summarise(n = n()) %>% 
  mutate(prop = n/n_max)
  
GB_props %>% 
  write_tsv("output/processed_data/GB_v2.0_prop.tsv")
