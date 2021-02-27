
library(raster)
library(rgbif)
library(tidyverse)

occs <- sapply(c(2000:2021), function(x) {rgbif::occ_count(year = x)})

occs <- tibble(year = c(2000:2021), occ = occs)
# probably cut off at 2019

den <- map_fetch(srs = "EPSG:3857") * occ_count(georeferenced = TRUE)
r <- setExtent(den, extent(-20037508, 20037508, -20037508, 20037508))
plot(r)

writeRaster(r, 'gbif.grd')

# library(mapview)
# library(leaflet)
# 
# prefix = 'https://api.gbif.org/v2/map/occurrence/density/{z}/{x}/{y}@1x.png?'
# style = 'style=purpleYellow.point'
# tile = paste0(prefix,style)
# 
# leaflet() %>%
#   setView(lng = 20, lat = 20, zoom = 01) %>%
#   addTiles() %>%  
#   addTiles(urlTemplate=tile) -> l
# 
# mapshot(l, file = "world.pdf")

