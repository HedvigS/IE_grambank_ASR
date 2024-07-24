source("01_requirements.R")

if(!file.exists("functions/make_binary_ValueTable.R")){
SH.misc::fetch_lines("https://github.com/HedvigS/R_grambank_cookbook/raw/main/functions/make_binary_ValueTable.R", out_dir = "functions", add_date_fetched = T)
}

if(!file.exists("functions/reduce_ValueTable_to_unique_glottocodes.R")){
SH.misc::fetch_lines("https://github.com/HedvigS/R_grambank_cookbook/raw/main/functions/reduce_ValueTable_to_unique_glottocodes.R", out_dir = "functions", add_date_fetched = T)
}

source("functions/make_binary_ValueTable.R")
source("functions/reduce_ValueTable_to_unique_glottocodes.R")

GB_LanguageTable <- read_csv("../../../../Grambank 2.0/cldf/languages.csv", show_col_types = FALSE)  
  
GB_ValueTable <- read_csv("../../../../Grambank 2.0/cldf/values.csv", show_col_types = FALSE) %>% 
    make_binary_ValueTable(keep_multistate = F, keep_raw_binary = T) %>% 
  reduce_ValueTable_to_unique_glottocodes(LanguageTable = GB_LanguageTable, merge_dialects = T, method = "combine_random", replace_missing_language_level_ID = T, treat_question_mark_as_missing = T)

Glottolog_LanguageTable <- read_tsv("data/processed_data/glottolog_5.0_languages.tsv", show_col_types = F) %>% 
  filter(Family_ID == "indo1319")  %>% 
  dplyr::select(Glottocode)
  
n_max <- GB_ValueTable$Parameter_ID %>% unique() %>% length()

GB_props <- GB_ValueTable %>% 
  inner_join(Glottolog_LanguageTable, by = "Glottocode") %>% 
  dplyr::group_by(Glottocode) %>% 
  summarise(n = n()) %>% 
  mutate(prop = n/n_max)
  
GB_props %>% 
  write_tsv("data/processed_data/GB_v2.0_prop.tsv")
