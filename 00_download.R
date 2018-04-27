
# Load libraries
require(raster)
require(RGDAL)

# Article: https://www.nature.com/articles/sdata2017191#abstract 
# Download: https://www.northwestknowledge.net/monthly-climate-and-climatic-water-balance-global-terrestrial-surfaces-1958-2015

# Initial setup
g <- gc(reset = TRUE)
options(scipen = 999)
rm(list = ls())

# Download Potential Evapotranspiration
dir.create('../_data/_raster/_nc/_world', recursive = TRUE)
urlbase <- 'https://climate.northwestknowledge.net/TERRACLIMATE-DATA/TerraClimate'
urls <- paste0(urlbase, '_pet_', 1980:2017, '.nc')
nms.pet <- paste0('terra_pet_', 1980:2017, '.nc')
Map('download.file', url = urls, destfile = paste0('../_data/_raster/_nc/_world/', nms.pet), mode = 'wb')

# Another way to download that information, execute the next line in Linux, please go to the path using cd path//whereisthebatch
'//mnt/workspace_cluster_9/Coffee_Cocoa2/_uganda_terraClimate/_data/_raster/_tif/_pet/terraclimate_wget.sh'

