# This script resizes raw photos for use in our interactives

library(magick)

# x is the folder where the raw images are
# y is the destination folder

bulk_cropper <- function(x, y) {

source_dir <- x
destination_dir <- y

files_list <- list.files(source_dir)

  for (i in 1:length(files_list)) {
    file_name <- files_list[i]
    image_file <- image_read(paste0(source_dir, "/", file_name))
  
    image_file <- image_scale(image_file, "175")  
    image_write(image_file, paste0(destination_dir, "/", file_name))
    print(i)
  }

}

bulk_cropper("2318/2012", "2318_cropped")
bulk_cropper("2318/2013", "2318_cropped")
bulk_cropper("2318/2014", "2318_cropped")
bulk_cropper("2318/2015", "2318_cropped")

bulk_cropper("2319/2012", "2319_cropped")
bulk_cropper("2319/2013", "2319_cropped")
bulk_cropper("2319/2014", "2319_cropped")
bulk_cropper("2319/2015", "2319_cropped")

bulk_cropper("2320/2012", "2320_cropped")
bulk_cropper("2320/2013", "2320_cropped")
bulk_cropper("2320/2014", "2320_cropped")
bulk_cropper("2320/2015", "2320_cropped")

