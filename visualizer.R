library(ggplot2)
library(dplyr)
library(extrafont)


cam_spectrum <- function(x, y, z) {
y <- y
spot_name <- z
mega <- read.csv(paste0(y, "/mega.csv"))
the_year <- as.character(x)
the_dates <- seq(as.Date(paste0(the_year,"/1/1")), as.Date(paste0(the_year,"/12/31")), by="day")
the_dates <- data.frame(gsub("-", "", as.character(the_dates)))
colnames(the_dates) <- "date"

image_df <- filter(mega, year==the_year)
image_df$date <- as.character(image_df$date)
the_dates$date <- as.character(the_dates$date)
image_df <- left_join(the_dates, image_df)

#image_df$color <- ifelse(is.na(image_df$color), "#FFFFFF", image_df$color)
image_df$row <- as.numeric(rownames(image_df))

rows <- nrow(image_df)
gap_num <- 3
gap <- rows*gap_num

row_widths <- seq(1,gap, by=3)
image_df <- cbind(image_df, row_widths)
image_df$end <- image_df$row_widths+(gap_num-1)

gg <- ggplot(image_df) +
#p <- ggplot(airp, aes(row, average_min_temp)) +
  theme(plot.background = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank()) +
  geom_linerange(image_df, mapping=aes(x=row, ymin=1, ymax=50), colour = "white") 
  
  for (i in 1:nrow(image_df)) {
    gg <- gg + annotate("segment", x = image_df$row_widths[i], xend = image_df$end[i], y = -Inf, yend = Inf, colour = image_df$color[i],  size=3)
  }

gg <- gg +   coord_cartesian(xlim = c(0,365*gap_num)) +
  #scale_y_continuous(breaks = seq(-20,100, by=10), labels = a) +
  scale_y_continuous(breaks = seq(0,0), labels=NULL) +
  
    scale_x_continuous(expand = c(0, 0), 
                       breaks = c(0, 31*gap_num,59*gap_num,90*gap_num,120*gap_num,151*gap_num,181*gap_num,212*gap_num,
                                  243*gap_num,273*gap_num,304*gap_num,334*gap_num),
                       labels = c("JAN", "FEB", "MAR", 
                                  "APR", "MAY", "JUN", "JUL", "AUG", "SEP","OCT", 
                                  "NOV", "DEC")) +
  ggtitle(paste0(spot_name, ": ", the_year)) + 
  theme(plot.title=element_text(face="bold",hjust=.012,vjust=.8,colour="#3C3C3C",size=20, family="Lato Regular")) 

    gg
    
  ggsave(gg, file=paste0(y, "-", the_year, ".png"), width=9, height=2)
}

cam_spectrum(2010, "2319", "Talcott Mountain")
cam_spectrum(2011, "2319", "Talcott Mountain")
cam_spectrum(2012, "2319", "Talcott Mountain")
cam_spectrum(2013, "2319", "Talcott Mountain")
cam_spectrum(2014, "2319", "Talcott Mountain")
cam_spectrum(2015, "2319", "Talcott Mountain")

cam_spectrum(2010, "2318", "Mohawk Mountain")
cam_spectrum(2011, "2318", "Mohawk Mountain")
cam_spectrum(2012, "2318", "Mohawk Mountain")
cam_spectrum(2013, "2318", "Mohawk Mountain")
cam_spectrum(2014, "2318", "Mohawk Mountain")
cam_spectrum(2015, "2318", "Mohawk Mountain")


cam_spectrum(2010, "2320", "Criscuolo Park")
cam_spectrum(2011, "2320", "Criscuolo Park")
cam_spectrum(2012, "2320", "Criscuolo Park")
cam_spectrum(2013, "2320", "Criscuolo Park")
cam_spectrum(2014, "2320", "Criscuolo Park")
cam_spectrum(2015, "2320", "Criscuolo Park")