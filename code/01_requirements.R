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
          "BiocManager",
          "adephylo",
          "tibble",
          "colourvalues",
          "ape")

pkgs <- unique(pkgs)

groundhog_date = "2023-08-03"

if(!("groundhog"%in% rownames(installed.packages()))){
  utils::install.packages("groundhog")
}
library(groundhog)


groundhog_dir <- paste0("groundhog_libraries_", groundhog_date)

if(!dir.exists(groundhog_dir)){
  dir.create(groundhog_dir)
}

groundhog::set.groundhog.folder(groundhog_dir)

groundhog.library(pkgs, groundhog_date)


if(!("rcldf"%in% rownames(installed.packages()))){
  install_github("SimonGreenhill/rcldf", dependencies = TRUE, ref = "v1.2.0")
}
library(rcldf)

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



dir <- "data"
if(!dir.exists(dir)){
  dir.create(dir)
}

dir <- "data/processed_data"
if(!dir.exists(dir)){
  dir.create(dir)
}

dir <- "functions"
if(!dir.exists(dir)){
  dir.create(dir)
}



source("01_requirements_further.R")
