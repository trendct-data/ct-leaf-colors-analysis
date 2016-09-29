# Talcott Mountain
# 41.825198, -72.798078

# Mohawk Mountain
# 41.838156, -73.315196

library(stringr)
require(maptools)
require(ggplot2)
library(extrafont)
require(rgdal)
library(ggmap)
library(extrafont)
library(viridis)
library(magick)

statetracts <- readOGR(dsn="shapes", layer="cb_2015_us_state_5m")

statetracts_only <- statetracts
statetracts <- fortify(statetracts, region="STUSPS")


statetracts2 <- dplyr::filter(statetracts, id=="ME" | id=="NH" | id=="VT" | id=="CT" | id=="MA" | id=="RI" |
                         id=="NY" | id== "NJ"| id=="PA")
ct_only <- dplyr::filter(statetracts, id=="CT")




## Circle maps

gg_circle <- function(r, xc, yc, color="black", fill=NA, ...) {
  x <- xc + r*cos(seq(0, pi, length.out=100))
  ymax <- yc + r*sin(seq(0, pi, length.out=100))
  ymin <- yc + r*sin(seq(0, -pi, length.out=100))
  annotate("ribbon", x=x, ymin=ymin, ymax=ymax, color=color, fill=fill, ...)
}

### Large
pm_ct <- ggplot() 
pm_ct <- pm_ct + geom_polygon(data = statetracts2, aes(x=long, y=lat, group=group), fill="white", color = "black", size=0.2)
pm_ct <- pm_ct + gg_circle(r=2, xc=-72.7, yc=41.58, color="gray93", fill="white", alpha=0.2, size=40) 
pm_ct <- pm_ct + gg_circle(r=2.02, xc=-72.7, yc=41.58, color="white", fill="white", alpha=0.2, size=40) 

pm_ct <- pm_ct + theme_nothing(legend=TRUE) 
pm_ct <- pm_ct + labs(x=NULL, y=NULL)
pm_ct <- pm_ct + theme(text = element_text(size=15), panel.background = element_rect(fill = 'gray93', color=NA))

pm_ct <- pm_ct + coord_fixed()
pm_ct <- pm_ct + annotate("point", x = -72.798078, y = 41.825198, colour = "tomato", size = 2) 
#pm_ct <- pm_ct + annotate("point", x = -73.315196, y = 41.838156, colour = "tomato", size = 2) 
pm_ct <- pm_ct + annotate("text", x = -72.3, y = 41.725198, label = "Talcott Mountain", size=3, family="Lato Black", colour="gray30") 
  
ggsave("talcott_map.jpg", width=16, height=12, units="in", dpi=300)

fer_magick <- image_read("map/talcott_map.jpg") %>%
  image_crop("950x950+2257+1845")

image_write(fer_magick, "map/talcott_map.png")

### Small

pm_ct <- ggplot() 
pm_ct <- pm_ct + geom_polygon(data = ct_only, aes(x=long, y=lat, group=group), fill="white", color = "black", size=2)
pm_ct <- pm_ct + gg_circle(r=2, xc=-72.7, yc=41.58, color="gray93", fill="white", alpha=0.2, size=40) 
pm_ct <- pm_ct + gg_circle(r=2.02, xc=-72.7, yc=41.58, color="white", fill="white", alpha=0.2, size=40) 

pm_ct <- pm_ct + theme_nothing(legend=TRUE) 
pm_ct <- pm_ct + labs(x=NULL, y=NULL)
pm_ct <- pm_ct + theme(text = element_text(size=15), panel.background = element_rect(fill = 'white', color=NA))

pm_ct <- pm_ct + coord_fixed()
pm_ct <- pm_ct + annotate("point", x = -72.798078, y = 41.825198, colour = "tomato", size = 16) 
#pm_ct <- pm_ct + annotate("point", x = -73.315196, y = 41.838156, colour = "tomato", size = 2) 
#pm_ct <- pm_ct + annotate("text", x = -72.3, y = 41.725198, label = "Talcott Mountain", size=4, family="Lato Black", colour="gray30") 

ggsave("map/talcott_map_sm.png", width=8, height=6, units="in", dpi=300)

### Large
pm_ct <- ggplot() 
pm_ct <- pm_ct + geom_polygon(data = statetracts2, aes(x=long, y=lat, group=group), fill="white", color = "black", size=0.2)
pm_ct <- pm_ct + gg_circle(r=2, xc=-72.7, yc=41.58, color="gray93", fill="white", alpha=0.2, size=40) 
pm_ct <- pm_ct + gg_circle(r=2.02, xc=-72.7, yc=41.58, color="white", fill="white", alpha=0.2, size=40) 

pm_ct <- pm_ct + theme_nothing(legend=TRUE) 
pm_ct <- pm_ct + labs(x=NULL, y=NULL)
pm_ct <- pm_ct + theme(text = element_text(size=15), panel.background = element_rect(fill = 'gray93', color=NA))

pm_ct <- pm_ct + coord_fixed()
#pm_ct <- pm_ct + annotate("point", x = -72.798078, y = 41.825198, colour = "tomato", size = 2) 
pm_ct <- pm_ct + annotate("point", x = -73.315196, y = 41.838156, colour = "tomato", size = 2) 
pm_ct <- pm_ct + annotate("text", x = -72.85, y = 41.725198, label = "Mohawk Mountain", size=3, family="Lato Black", colour="gray30") 

ggsave("mohawk_map.jpg", width=16, height=12, units="in", dpi=300)

fer_magick <- image_read("map/mohawk_map.jpg") %>%
  image_crop("950x950+2257+1845")

image_write(fer_magick, "map/mohawk_map.png")


### Small

pm_ct <- ggplot() 
pm_ct <- pm_ct + geom_polygon(data = ct_only, aes(x=long, y=lat, group=group), fill="white", color = "black", size=2)
pm_ct <- pm_ct + gg_circle(r=2, xc=-72.7, yc=41.58, color="gray93", fill="white", alpha=0.2, size=40) 
pm_ct <- pm_ct + gg_circle(r=2.02, xc=-72.7, yc=41.58, color="white", fill="white", alpha=0.2, size=40) 

pm_ct <- pm_ct + theme_nothing(legend=TRUE) 
pm_ct <- pm_ct + labs(x=NULL, y=NULL)
pm_ct <- pm_ct + theme(text = element_text(size=15), panel.background = element_rect(fill = 'white', color=NA))

pm_ct <- pm_ct + coord_fixed()
pm_ct <- pm_ct + annotate("point", x = -73.315196, y = 41.838156, colour = "tomato", size = 16) 
#pm_ct <- pm_ct + annotate("point", x = -73.315196, y = 41.838156, colour = "tomato", size = 2) 

ggsave("map/mohawk_map_sm.png", width=8, height=6, units="in", dpi=300)


## Rectangular map

pm_ct <- ggplot() 
pm_ct <- pm_ct + geom_polygon(data = ct_only, aes(x=long, y=lat, group=group), fill="white", color = "black", size=1)
pm_ct <- pm_ct + gg_circle(r=2, xc=-72.7, yc=41.58, color="gray93", fill="white", alpha=0.2, size=40) 
pm_ct <- pm_ct + gg_circle(r=2.02, xc=-72.7, yc=41.58, color="white", fill="white", alpha=0.2, size=40) 

pm_ct <- pm_ct + theme_nothing(legend=TRUE) 
pm_ct <- pm_ct + labs(x=NULL, y=NULL)
pm_ct <- pm_ct + theme(text = element_text(size=15), panel.background = element_rect(fill = 'white', color=NA))

pm_ct <- pm_ct + coord_fixed()
pm_ct <- pm_ct + annotate("point", x = -72.798078, y = 41.825198, colour = "tomato", size = 8) 
#pm_ct <- pm_ct + annotate("point", x = -73.315196, y = 41.838156, colour = "tomato", size = 2) 
pm_ct <- pm_ct + annotate("text", x = -72.58, y = 41.825198, label = "Talcott Mountain", size=6, family="Lato Black", colour="gray30") 
pm_ct
ggsave("map/talcott_map_lg.png", width=12, height=8, units="in", dpi=300)


pm_ct <- ggplot() 
pm_ct <- pm_ct + geom_polygon(data = ct_only, aes(x=long, y=lat, group=group), fill="white", color = "black", size=1)
pm_ct <- pm_ct + gg_circle(r=2, xc=-72.7, yc=41.58, color="gray93", fill="white", alpha=0.2, size=40) 
pm_ct <- pm_ct + gg_circle(r=2.02, xc=-72.7, yc=41.58, color="white", fill="white", alpha=0.2, size=40) 

pm_ct <- pm_ct + theme_nothing(legend=TRUE) 
pm_ct <- pm_ct + labs(x=NULL, y=NULL)
pm_ct <- pm_ct + theme(text = element_text(size=15), panel.background = element_rect(fill = 'white', color=NA))

pm_ct <- pm_ct + coord_fixed()
pm_ct <- pm_ct + annotate("point", x = -73.315196, y = 41.838156, colour = "tomato", size = 8) 
#pm_ct <- pm_ct + annotate("point", x = -73.315196, y = 41.838156, colour = "tomato", size = 2) 
pm_ct <- pm_ct + annotate("text", x = -73.08, y = 41.838156, label = "Mohawk Mountain", size=6, family="Lato Black", colour="gray30") 
pm_ct
ggsave("map/mohawk_map_lg.png", width=12, height=8, units="in", dpi=300)

# blank small map

pm_ct <- ggplot() 
pm_ct <- pm_ct + geom_polygon(data = ct_only, aes(x=long, y=lat, group=group), fill="white", color = "black", size=1)
pm_ct <- pm_ct + gg_circle(r=2, xc=-72.7, yc=41.58, color="gray93", fill="white", alpha=0.2, size=40) 
pm_ct <- pm_ct + gg_circle(r=2.02, xc=-72.7, yc=41.58, color="white", fill="white", alpha=0.2, size=40) 

pm_ct <- pm_ct + theme_nothing(legend=TRUE) 
pm_ct <- pm_ct + labs(x=NULL, y=NULL)
pm_ct <- pm_ct + theme(text = element_text(size=15), panel.background = element_rect(fill = 'white', color=NA))

pm_ct <- pm_ct + coord_fixed()
ggsave("map/blank_map.png", width=6, height=4, units="in", dpi=300)

## ROADS


roads <- readOGR(dsn="shapes", layer="majorroadct_37800_0000_1995_s250_ctdep_1_shp_wgs84")
roads2 <- fortify(roads, region="AV_LEGEND")

plot(ct_only)
plot(roads)
pm_ct <- ggplot() 
pm_ct <- pm_ct + geom_polygon(data = roads, aes(x=long, y=lat, group=group), fill="white", color = "gray73", size=1)
pm_ct <- pm_ct + theme_nothing(legend=TRUE) 
pm_ct <- pm_ct + labs(x=NULL, y=NULL)
pm_ct <- pm_ct + theme(text = element_text(size=15), panel.background = element_rect(fill = 'white', color=NA))

pm_ct <- pm_ct + coord_fixed()
pm_ct
plot(roads)

ggsave("map/roads_map.png", bg = "transparent", width=6, height=4, units="in", dpi=300)

## State again


ct_clean <- readOGR(dsn="shapes", layer="ct_clean")
ct_clean2 <- fortify(ct_clean, region="STATE_COD")
pm_ct <- ggplot() 
pm_ct <- pm_ct + geom_polygon(data = ct_clean, aes(x=long, y=lat, group=group), fill="white", color = "black", size=1)

pm_ct <- pm_ct + geom_path(data = roads2, aes(x=long, y=lat, group=group), fill=NULL, color = "gray73", size=.5)
pm_ct <- pm_ct + theme_nothing(legend=TRUE) 
pm_ct <- pm_ct + labs(x=NULL, y=NULL)
#pm_ct <- pm_ct + theme(text = element_text(size=15), panel.background = element_rect(fill = NA, color=NA))

pm_ct <- pm_ct + coord_fixed()
pm_ct

ggsave("map/ct_map_roads.png", bg="transparent", width=6, height=4, units="in", dpi=300)
