# This script takes raw images in a folder, crops them to where the foliage is,
# determines the median color for each, and adds it to a dataframe and exports it

#devtools::install_github("joelcarlson/RImagePalette")
library(RImagePalette)
#install.packages("magick")
library(magick)

# Creating a function that will export a dataframe of hex colors
# based on camera number and folder where raw photos are
# as well as where to set the crop (will have to figure this part out by hand ahead of time)

# for example, cam is "2320", dir is "2320/2320c", crop_directions is "125x70+652+560"

img_cropper <- function(cam, dir, crop, letter) {
  letter <- letter
  directory_name2 <- cam
  directory_name <- dir
  crop_directions <- crop
  
files_list <- list.files(directory_name)

for (i in 1:length(files_list)) {
  file_name <- files_list[i]
  file_name2 <- paste0(directory_name, "/", file_name)
  year <- substr(file_name, 1,4)
  
  foliage <- image_read(file_name2)
  #print(foliage)
  foliage_crop <- image_crop(foliage, crop_directions)
  
  #print(foliage_crop)
  
  cropped_folder <- paste0(directory_name2, "/", directory_name2, "_cropped/", file_name)
  image_write(foliage_crop, cropped_folder)
  image <- jpeg::readJPEG(cropped_folder)
  imagePalette <- image_palette(image, n=1, choice=max, volume=TRUE)
  date <- gsub(".jpg", "", file_name)
  
  ind_row <- data.frame(row=i, year=year, date=date, color=imagePalette)
  
  if (i==1) {
    mega <- ind_row
  } else {
    mega <- rbind(mega, ind_row)
  }
  print(nrow(mega))
}
filename_A <- paste0(directory_name2, "/mega", letter, ".csv")
write.csv(mega, filename_A)
}

# Lots of sub folders of photos because sometimes the camera moves
# So that means the crop must adjust to that so it keeps the foliage as the focus

img_cropper("2319", "2319/2319a", "2592x400+0+1000", "A")
img_cropper("2319", "2319/2319b", "1392x400+1200+600", "B")
img_cropper("2319", "2319/2319c", "692x2050+150+1600", "C")
img_cropper("2319", "2319/2319d", "2592x900+0+1400", "D")
img_cropper("2319", "2319/2319e", "2592x600+0+2100", "E")
img_cropper("2319", "2319/2319f", "1000x600+1500+1500", "F")
img_cropper("2319", "2319/2319g", "2592x500+0+775", "G")

# Read in all the exported spreadsheets and create one big one

A <- read.csv("2319/megaA.csv")
B <- read.csv("2319/megaB.csv")
C <- read.csv("2319/megaC.csv")
D <- read.csv("2319/megaD.csv")
E <- read.csv("2319/megaE.csv")
H <- read.csv("2319/megaF.csv")
G <- read.csv("2319/megaG.csv")

mega <- rbind(A, B)
mega <- rbind(mega, C)
mega <- rbind(mega, D)
mega <- rbind(mega, E)
mega <- rbind(mega, H)
mega <- rbind(mega, G)

# Putting it all back in order of date
mega <- arrange(mega, date)
mega$row <- as.numeric(rownames(mega))
mega$X <- NULL
write.csv(mega, "2319/mega.csv")


## 2318
img_cropper("2318", "2318/2318a", "1000x600+0+1250", "A")
img_cropper("2318", "2318/2318b", "1000x350+850+900", "B")

A <- read.csv("2318/megaA.csv")
B <- read.csv("2318/megaB.csv")

mega <- rbind(A, B)

mega <- arrange(mega, date)
mega$row <- as.numeric(rownames(mega))
mega$X <- NULL
write.csv(mega, "2318/mega.csv")

## 2320

img_cropper("2320", "2320/2320a", "90x40+1080+385", "A")
img_cropper("2320", "2320/2320b", "90x40+1080+457", "B")
#img_cropper("2320", "2320/2320c", "130x70+400+550", "C")
img_cropper("2320", "2320/2320c", "125x70+652+560", "C")

A <- read.csv("2320/megaA.csv")
B <- read.csv("2320/megaB.csv")
C <- read.csv("2320/megaC.csv")

mega <- rbind(A, B)
mega <- rbind(mega, C)

mega <- arrange(mega, date)
mega$row <- as.numeric(rownames(mega))
mega$X <- NULL
write.csv(mega, "2320/mega.csv")

# Replacing NA fields with the color White

mega <- read.csv("2318/mega.csv")
mega$date[is.na(mega$date)] <- "#FFFFFF"
write.csv(mega, "2318/mega.csv")

mega <- read.csv("2319/mega.csv")
mega$date[is.na(mega$date)] <- "#FFFFFF"
write.csv(mega, "2319/mega.csv")

mega <- read.csv("2320/mega.csv")
mega$date[is.na(mega$date)] <- "#FFFFFF"
write.csv(mega, "2320/mega.csv")
