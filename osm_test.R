# maps and openstreetmaps in R
library(tidyverse)
library(osmdata)
library(sf)
library(ggmap)

# need latest dev version because of jpeg issues
#devtools::install_github("dkahle/ggmap") 

head(available_features(),100)
#amenities
head(available_tags("amenity"),100)
#shops
head(available_tags("shop"),100)

# Querying PoI's

q <- getbb("Amsterdam")%>%
  opq()%>%
  add_osm_feature("amenity", "cinema")

cinema <- osmdata_sf(q)
cinema

# Plaats PoI's op een kaart
mad_map <- get_map(
  getbb("Amsterdam"), 
  maptype = "toner-background", 
  source = "stamen"
)

# Kaartje met PoI's
ggmap(mad_map)+
  geom_sf(data=cinema$osm_points,
          inherit.aes =FALSE,
          colour="#238443",
          fill="#004529",
          alpha=.5,
          size=4,
          shape=21)+
  labs(title = "bioscopen in Amsterdam", x="",y="")
