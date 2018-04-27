
# Load libraries
require(raster)
require(rgdal)
require(tidyverse)
require(velox)
require(stringr)
require(doMC)
require(foreach)

# Initial setup
rm(list = ls())
setwd('//mnt/workspace_cluster_9/Coffee_Cocoa2/_uganda_terraClimate')

# Functions to use
extMskNCO <- function(vr, yr, path_inp, path_out){
  inp <- paste0(path_inp, vr, '_', yr, '.nc')
  out <- paste0(path_out, vr, '_', yr, '.nc')
  system(paste("cdo sellonlatbox,", 
               xmin = 29, ",", 
               xmax = 36, ",", 
               ymin = -2, ",", 
               ymax = 5, " ", 
               nc = inp, " ", 
               outNc = out, sep=""))
  print('Done!!!')
}

# Load data
yrs <- 1980:2017
path_climate <- '//mnt/data_cluster_4/observed/gridded_products/terra-climate'
path_climate <- '//mnt/workspace_cluster_9/Coffee_Cocoa2/_uganda_terraClimate/_data/_raster/_nc/_world'
vrs <- c('ppt', 'tmax', 'tmin')
fls <- list.files(path_climate, full.name = T, pattern = '.nc$') %>% 
  grep(paste0(yrs, collapse = '|'), ., value = T) %>% 
  grep(paste0(vrs, collapse = '|'), ., value = TRUE)
uga <- getData(name = 'GADM', country = 'UGA', level = 0)
ext <- extent(c(29, 36, -2, 5))

# Apply function to extract mask [Example!!!]
extMskNCO(vr = vrs[1], 
          yr = yrs[1], 
          path_inp = '//mnt/data_cluster_4/observed/gridded_products/terra-climate/TerraClimate_', 
          path_out = '//mnt/workspace_cluster_9/Coffee_Cocoa2/_uganda_terraClimate/_data/_raster/_nc/_ext/')

# Parallelization
registerDoMC(18)
foreach(i = 1:length(yrs), .packages = c('dplyr'), .verbose = TRUE) %dopar% {
  print(yrs[[i]])
  extMskNCO(vr = 'tmax', 
            yr = yrs[i],
            path_inp = '//mnt/data_cluster_4/observed/gridded_products/terra-climate/TerraClimate_',
            path_out = '//mnt/workspace_cluster_9/Coffee_Cocoa2/_uganda_terraClimate/_data/_raster/_nc/_ext/')
} 

registerDoMC(18)
foreach(i = 1:length(yrs), .packages = c('dplyr'), .verbose = TRUE) %dopar% {
  print(yrs[[i]])
  extMskNCO(vr = 'tmin', 
            yr = yrs[i],
            path_inp = '//mnt/data_cluster_4/observed/gridded_products/terra-climate/TerraClimate_',
            path_out = '//mnt/workspace_cluster_9/Coffee_Cocoa2/_uganda_terraClimate/_data/_raster/_nc/_ext/')
} 

registerDoMC(18)
foreach(i = 1:length(yrs), .packages = c('dplyr'), .verbose = TRUE) %dopar% {
  print(yrs[[i]])
  extMskNCO(vr = 'ppt', 
            yr = yrs[i],
            path_inp = '//mnt/data_cluster_4/observed/gridded_products/terra-climate/TerraClimate_',
            path_out = '//mnt/workspace_cluster_9/Coffee_Cocoa2/_uganda_terraClimate/_data/_raster/_nc/_ext/')
} 

registerDoMC(18)
foreach(i = 1:length(yrs), .packages = c('dplyr'), .verbose = TRUE) %dopar% {
  print(yrs[[i]])
  extMskNCO(vr = 'pet', 
            yr = yrs[i],
            path_inp = '//mnt/workspace_cluster_9/Coffee_Cocoa2/_uganda_terraClimate/_data/_raster/_nc/_world/terra_',
            path_out = '//mnt/workspace_cluster_9/Coffee_Cocoa2/_uganda_terraClimate/_data/_raster/_nc/_ext/')
} 




