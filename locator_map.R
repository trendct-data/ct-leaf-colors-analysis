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


statetracts2 <- filter(statetracts, id=="ME" | id=="NH" | id=="VT" | id=="CT" | id=="MA" | id=="RI" |
                         id=="NY" | id== "NJ"| id=="PA")
ct_only <- filter(statetracts, id=="CT")


extra_label <- c("topright", "bottomleft")
extra_lat <- c(46.358685, 35.872715)
extra_lon <- c(-64.209938, -79.735653)


gg_circle <- function(r, xc, yc, color="black", fill=NA, ...) {
  x <- xc + r*cos(seq(0, pi, length.out=100))
  ymax <- yc + r*sin(seq(0, pi, length.out=100))
  ymin <- yc + r*sin(seq(0, -pi, length.out=100))
  annotate("ribbon", x=x, ymin=ymin, ymax=ymax, color=color, fill=fill, ...)
}


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