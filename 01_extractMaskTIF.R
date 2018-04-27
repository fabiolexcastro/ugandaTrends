
# Load libraries
require(raster)
require(rgdal)
require(tidyverse)
require(velox)
require(stringr)
require(foreach)

# Initial setup
g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = alpha)

# Function to extract mask
extMskYr <- function(vr, yr){
  flssub <- grep(vr, fls, value = T) %>% grep(yr, ., value = T)
  stk <- stack(flssub)
  vlx <- velox(stk)
  vlx$crop(ext)
  stk.cut <- vlx$as.RasterLayer()
  nms <- names(stk) %>% 
    str_sub(., start = 2, end = 8) %>% 
    paste0(vr, '_',  .) %>% 
    str_replace(., pattern = '[.]', replacement = '_')
  lyrs <- unstack(stk)
  Map('writeRaster', x = stk.cut, filename = paste0('../_data/_raster/_tif/', nms, '.asc'), overwrite = FALSE)
  # Map('writeRaster', x = lyrs, filename = paste0('_data/_raster/_tif/_ext/', nms, '.asc'), overwrite = FALSE)
  rm(stk, vlx, stk.cut)
  print('Done')
  return(lyrs)
}

# Load data
fls <- list.files('../_data/_raster/_nc/_ext')




# Example with a year
system.time(expr = ppt81 <- extMskYr(vr = 'ppt', yr = 1981))


