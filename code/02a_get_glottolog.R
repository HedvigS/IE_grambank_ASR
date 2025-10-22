#This script takes the values and languages tables from a cldf-release and combines then and transforms them to a wide data format from a long. It does not take into account the parameter or code tables.

source("01_requirements.R")

if(!file.exists("output/processed_data/glottolog_5.0_languages.tsv")){

# fetching Glottolog v5.0 from Zenodo using rcldf (requires internet)
glottolog_rcldf_obj <- rcldf::cldf("https://zenodo.org/records/10804582/files/glottolog/glottolog-cldf-v5.0.zip", load_bib = F)

ValueTable_wide <- glottolog_rcldf_obj$tables$ValueTable %>% 
  reshape2::dcast(Language_ID ~ Parameter_ID, value.var = "Value")
  
glottolog_rcldf_obj$tables$LanguageTable %>% 
  dplyr::rename(Language_level_ID = Language_ID, Language_ID = ID) %>% 
  full_join(ValueTable_wide, by = "Language_ID") %>% 
  write_tsv("output/processed_data/glottolog_5.0_languages.tsv")
}

if(!file.exists("output/processed_data/glottolog_5.0_IE_tree.tree")){
Glottolog_LanguageTable <- read_tsv("output/processed_data/glottolog_5.0_languages.tsv", show_col_types = F) %>% 
  tibble::column_to_rownames("Language_ID")

tree_IE_full <- ape::read.tree(text = Glottolog_LanguageTable["indo1319",]$subclassification)

tree_IE_full <- ape::compute.brlen(tree_IE_full, method = "grafen") %>% ladderize()

tree_IE_full %>% 
  ape::write.tree("output/processed_data/glottolog_5.0_IE_tree.tree")
}