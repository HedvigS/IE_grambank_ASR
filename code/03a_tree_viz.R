source("01_requirements.R")

source("functions/fun_keep_as_tip.R")

GB_prop <- read_tsv("data/processed_data/GB_v2.0_prop.tsv", show_col_types = F) 

Glottolog_df <- read_tsv("data/processed_data/glottolog_5.0_languages.tsv", show_col_types = FALSE) %>% 
  filter(level == "language", 
         Family_ID == "indo1319")

tree <- ape::read.tree("data/processed_data/glottolog_5.0_IE_tree.tree")

pruned_tree <- keep_as_tip(tree, Glottolog_df$Glottocode)

#tree_heggarty <- ape::read.nexus("data/Heggearty_et_al_2023/01_Main_Analysis_M3/IECoR_Main_M3_Binary_Covarion_Rates_By_Mg_Bin/IECoR_Main_M3_Binary_Covarion_Rates_By_Mg_Bin_mcc.tree")

#extra <- data.frame(ascii_name = c("TsakonianPropontis", "TsakonianPeloponnese"), 
#                    Glottocode= c("prop1240", "tsak1248"), 
#                    Name = c("Propontis Tsakonian", "Peloponnese Tsakonian"))

#IECOR_LanguageTable <- read_csv("https://github.com/lexibank/iecor/raw/v1.1/cldf/languages.csv", show_col_types = F) %>% 
#  dplyr::select(ascii_name, Glottocode, Name) %>% 
#  full_join(extra, by = join_by(ascii_name, Glottocode, Name))
  
#tree_tip_df <- tree_heggarty$tip.label %>%
#  as.data.frame() %>% 
#  rename("ascii_name" = ".") 

#tree_tip_df <- tree_tip_df %>% 
#  left_join(IECOR_LanguageTable, by = "ascii_name")

tree_tip_df <- pruned_tree$tip.label %>%
  as.data.frame() %>% 
  rename("Glottocode" = ".")

df <- tree_tip_df %>% 
  left_join(GB_prop,  
            by = "Glottocode") %>% 
  mutate(prop = ifelse(is.na(prop), 0, prop)) %>% 
  mutate(n = ifelse(is.na(n), 0, n)) 

df$color <- colourvalues::colour_values(df$prop)

png("output/plots/tree_coverage.png", width = 50, height = 50, units = "cm", res = 300)
plot.phylo(pruned_tree, 
           col="grey", 
           tip.color = df$color, 
           type = "fan", 
           cex = 0.7,
           label.offset = 0.1)
 x <- dev.off()
