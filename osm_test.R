# maps and openstreetmaps in R
library(tidyverse)
library(osmdata)
library(sf)
library(ggmap)

# need latest dev version because of jpeg issues
#devtools::install_github("dkahle/ggmap") 

##########################################################

## restaurants in amsterdam
amsterdam = restaurants %>% 
  filter(
    plaats == "Amsterdam",
    !is.na(aantalreviews)
  )
projcrs <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
amsterdam <- st_as_sf(
  x = amsterdam,                         
  coords = c("LONGs", "LATs"),
  crs = projcrs
)

amsterdam_map <- get_map(
  getbb("Amsterdam"), 
  maptype = "toner-background", 
  source = "stamen"
)

ggmap(amsterdam_map) +
  geom_sf(data = df,
          inherit.aes =FALSE,
          aes(colour = aantalreviews, fill = aantalreviews),
          alpha = .65,
          size = 1,
          shape = 21)+
  labs(title = "restaurants in Amsterdam", x="",y="")


############################################################

mad_map <- get_map(
  c(left = 3.3, bottom = 50.5, right = 7.3, top = 53.6902),
  maptype = "toner-background", 
  source = "stamen"
  )

df <- st_as_sf(
  x = restaurants,                         
  coords = c("LONGs", "LATs"),
  crs = projcrs
)

ggmap(mad_map) +
  geom_sf(data = df,
          inherit.aes =FALSE,
          aes(colour = aantalreviews),
          fill="#004529",
          alpha = .65,
          size = 2,
          shape = 21)+
  labs(title = "restaurants in Amsterdam", x="",y="")

###############################################################

# Er is meer. Je kan PoI opvragen met osm

## aanwezige features
available_features()

# Een feature is bijvoorbeeld amenities (voorzieningen / faciliteiten)
# en deze heeft weer tags. Die kan je tonen
available_tags("amenity")

#shops
available_tags("shop")

# Querying PoI's
q <- getbb("Amsterdam")%>%
  opq()%>%
  #add_osm_feature("amenity", "restaurant")
  add_osm_feature("highway",	"speed_camera")

out = osmdata_sf(q)
pp = cinema$osm_points 


q <- getbb("Amsterdam")%>%
  opq() %>%
  add_osm_feature("shop")

out = osmdata_sf(q)
pp = out$osm_points 
ppp = pp %>%  select(name, addr.city, opening_hours, shop )
typewinkels = ppp %>% group_by(shop) %>%  summarise(n=n())

cheesewinkels = ppp %>% filter(shop == "cheese")

# Plaats PoI's op een kaart

# Kaartje met PoI's
ggmap(amsterdam_map) +
  geom_sf(data = cheesewinkels,
          inherit.aes =FALSE,
          colour="#238443",
          fill="#004529",
          alpha = .95,
          size = 2,
          shape=21)+
  labs(title = "cheese shops in Amsterdam")

