# This script creates an annual collage of earthcam photos
# It uses the magick library to resize and place raw photos into a grid

#install.packages("magick")
library(magick)
library(dplyr)

# The size of individual photos we're shooting for
# 175 x 131

# Creating a function to create collages around specific camera photo folders and years
# x is year
# y is folder 

collage_maker <- function(x, y) {
x <- x
y <- y
mega <- read.csv(paste0(y, "/mega.csv"))

the_year <- as.character(x)
the_dates <- seq(as.Date(paste0(the_year,"/1/1")), as.Date(paste0(the_year,"/12/31")), by="day")
the_dates <- data.frame(gsub("-", "", as.character(the_dates)))
colnames(the_dates) <- "date"

image_df <- filter(mega, year==the_year)
image_df$date <- as.character(image_df$date)
the_dates$date <- as.character(the_dates$date)
image_df <- left_join(the_dates, image_df)
image_df <- subset(image_df, date!=(paste0(the_year, "0229")))
image_df <- image_df[1:365,]
#image_df$color <- ifelse(is.na(image_df$color), "#FFFFFF", image_df$color)
image_df$row <- as.numeric(rownames(image_df))

collage_row <- data.frame(rep(1:73, each=5))
colnames(collage_row) <- "collage_row"

image_df <- cbind(image_df, collage_row)

image_df$collage_column <- seq(1, 5, by=1)


directory_name <- paste0(y, "/", x)

files_list <- list.files(directory_name)


base_img <- image_read("collage-base.png")

for (i in 1:nrow(image_df)) {
  
  if (!is.na(image_df$color[i])) {
  file_name <- paste0(directory_name, "/", paste0(image_df$date[i], ".jpg"))
  img_file <- image_read(file_name)
  offset_top <- ifelse(image_df$collage_row[i]==1, 0, (image_df$collage_row[i]-1)*131)
  offset_side <- ifelse(image_df$collage_column[i]==1, 0, (image_df$collage_column[i]-1)*175)
  
  offset_calc <- paste0("+", offset_side, "+", offset_top)
  if (!exists("composite")) {
    composite <- image_composite(base_img, image_scale(img_file, "175"), offset=offset_calc)
  } else {
    composite <- image_composite(composite, image_scale(img_file, "175"), offset=offset_calc)
    
  } 
  print(i)
  } else {
    print("no image")
  }
}

image_write(composite, paste0("collage-", y, "-", x, ".png", format="png"))

}

# Now running the functions on yeras and folders
# these folders are not in the repo because they're huge (5GB each)

collage_maker(2012, "2319")
collage_maker(2013, "2319")
collage_maker(2014, "2319")
collage_maker(2015, "2319")

collage_maker(2012, "2318")
collage_maker(2013, "2318")
collage_maker(2014, "2318")
collage_maker(2015, "2318")

collage_maker(2012, "2320")
collage_maker(2013, "2320")
collage_maker(2014, "2320")
collage_maker(2015, "2320")
