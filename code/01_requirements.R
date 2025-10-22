# Please run this script first to make sure you have all the necessary packages 
# installed for running the rest of the scripts in this R project

#### PACKAGE INSTALLATION AND LOADING ########
# packages are installed given specific versions of date, to increase replicability of the code 

pkgs = c( "dplyr",
          "readr", 
          "tidyr",
          "stringr",
          "forcats",
          "magrittr",
          "reshape2", 
          "remotes",
          "phytools",
#          "BiocManager",
          "adephylo",
          "tibble",
         # "colourvalues",
          "ape")

pkgs <- unique(pkgs)

for(i in pkgs){
  library(i, character.only = T)
}




if(!("rcldf"%in% rownames(installed.packages()))){
  install_github("SimonGreenhill/rcldf", dependencies = TRUE, ref = "v1.2.0")
}
library(rcldf)


if(!("rgrambank"%in% rownames(installed.packages()))){
  install_github("HedvigS/rgrambank", dependencies = TRUE)
}
library(rgrambank)


if(!("SH.misc"%in% rownames(installed.packages()))){
  install_github("HedvigS/SH.misc", dependencies = TRUE)
}
library(SH.misc)


if(!("ggtree"%in% rownames(installed.packages()))){
  BiocManager::install("ggtree") #version v3.11.0
}
library(ggtree)

dir <- "output"
if(!dir.exists(dir)){
  dir.create(dir)
}

dir <- "output/plots/"
if(!dir.exists(dir)){
  dir.create(dir)
}

dir <- "output/results/"
if(!dir.exists(dir)){
  dir.create(dir)
}


dir <- "output/plots/ASR_ML_tree/"
if(!dir.exists(dir)){
  dir.create(dir)
}


dir <- "data"
if(!dir.exists(dir)){
  dir.create(dir)
}

dir <- "output/processed_data"
if(!dir.exists(dir)){
  dir.create(dir)
}

dir <- "functions"
if(!dir.exists(dir)){
  dir.create(dir)
}


