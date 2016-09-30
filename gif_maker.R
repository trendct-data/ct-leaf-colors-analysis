
# Loop!
# Step 1. Load base background
# Step 2. Place map
# Step 3. Place legend
# Step 4. Add date annotation
# Step 5. Save image
# Step 6. Get file list and create gif

#install.packages("magick")
library(magick)
library(extrafont)

gif_base <- image_read("map/gif_background.png")
gif_legend <- image_read("map/map_legend.png")
phase_list <- read.csv("map/phase_sheet.csv", stringsAsFactors = F)
  
  
for (i in 1:nrow(phase_list)) {
  the_image <- image_read(paste0("map/",phase_list$File[i]))
  
  combined <- gif_base %>% image_composite(the_image, offset="+0+75") %>%
    image_composite(gif_legend, offset="+300+475") %>%
    image_annotate(phase_list$Title[i], size=46, location="+230+50") 
  
  
  image_write(combined, paste0("map/phases/", phase_list$File[i]))
  
  }



the_list <- paste0("map/phases/", list.files("map/phases/"))

frames <- lapply(the_list, image_read)
animation <- image_animate(image_join(frames), fps=1)
print(animation)
image_write(animation,"map/phases.gif")