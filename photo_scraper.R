
library(RCurl)
library(RJSONIO)
# library(rjson) 
library(plyr)

test <- fromJSON(url)
data <- getURL(url)
rd <- readLines(url, warn="F") 
dat <- fromJSON(rd)
library(httr)

# dates1 = Hartford Criscuolo Park
dates1 <- seq(as.Date("2009-03-25"), as.Date("2016-02-09"), by="days")
dates1 <- as.character(dates1)
dates1 <- gsub("-", "", dates1)
dates1 <- paste0(dates1, "120012")

# Hartford Criscuolo Park
#  id=2320
#  projectid=1525
#  clientid=1
#  earliest: March 25, 2009 

id <- 2320
dir.create(as.character(id))
setwd(as.character(id))

for (i in 1:length(dates1)) {
  url <- paste0("http://www.earthcam.net/users2/json_request.php?page=archive_images&id=", id, "&projectid=1525&clientid=1075&archiveid=1&date=", dates1[i])
  response <- GET(url, 
                  set_cookies(`control_center_access_token` = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhdXRoLmVhcnRoY2FtLm5ldCIsInN1YiI6IjMxODMzIiwiaWF0IjoiMTQ1NTExNzE2NyIsImV4cCI6IjE0NTUxNDU5NjciLCJuYmYiOiIxNDU1MTE3MTY3IiwianRpIjoiMDM5OGVkMDQ4ZThkYzI2ZTEyODZiZjExZDJiZGE5ZGUifQ.lgiXOXCekluVyI9Hg-5uqu9Ez0Orgr_iq7mygDNek54",
                              `eula_users` = "user_31833%3D2",
                              `sid` = "fc4f4b51a8a6f4db33e0eb78f6d9efbf",
                              `system_check` = "1"))
  
  list <- content(x = response,as = 'text', encoding = "UTF-8")   
  
  json_data <- fromJSON(list, nullValue = NA)
  asFrame <- do.call("rbind.fill", lapply(json_data, as.data.frame))
  if (nrow(asFrame) > 3) {
    asFrame <-data.frame(t(asFrame))
    asFrame <- asFrame[,1:4]
    colnames(asFrame) <- c("time", "image_small", "image", "image_half")
    asFrame <- subset(asFrame, time=="120000")
    if (nrow(asFrame) > 0) {
    asFrame$image <- paste0("http://earthcam.net", asFrame$image)
    date_filename <- gsub('.{6}$', '', dates1[i])
    date_filename <- paste0(date_filename, ".jpg")
    download.file(asFrame$image,date_filename, mode = 'wb')
    }
  }
  print(i)
}

setwd("..")

##

# dates2 = Hartford Mohawk Mountain
dates2 <- seq(as.Date("2009-03-28"), as.Date("2016-02-09"), by="days")
dates2 <- as.character(dates2)
dates2 <- gsub("-", "", dates2)
dates2 <- paste0(dates2, "120012")

# Hartford Mohawk Mountain
#  id=2318
#  projectid=1525
#  clientid=1
#  earliest: March 28, 2009 

id <- 2318
dir.create(as.character(id))
setwd(as.character(id))

for (i in 1:length(dates2)) {
  url <- paste0("http://www.earthcam.net/users2/json_request.php?page=archive_images&id=", id, "&projectid=1525&clientid=1075&archiveid=1&date=", dates1[i])
  response <- GET(url, 
                  set_cookies(`control_center_access_token` = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhdXRoLmVhcnRoY2FtLm5ldCIsInN1YiI6IjMxODMzIiwiaWF0IjoiMTQ1NTExNzE2NyIsImV4cCI6IjE0NTUxNDU5NjciLCJuYmYiOiIxNDU1MTE3MTY3IiwianRpIjoiMDM5OGVkMDQ4ZThkYzI2ZTEyODZiZjExZDJiZGE5ZGUifQ.lgiXOXCekluVyI9Hg-5uqu9Ez0Orgr_iq7mygDNek54",
                              `eula_users` = "user_31833%3D2",
                              `sid` = "fc4f4b51a8a6f4db33e0eb78f6d9efbf",
                              `system_check` = "1"))
  
  list <- content(x = response,as = 'text', encoding = "UTF-8")   
  
  json_data <- fromJSON(list, nullValue = NA)
  asFrame <- do.call("rbind.fill", lapply(json_data, as.data.frame))
  if (nrow(asFrame) > 3) {
    asFrame <-data.frame(t(asFrame))
    asFrame <- asFrame[,1:4]
    colnames(asFrame) <- c("time", "image_small", "image", "image_half")
    asFrame <- subset(asFrame, time=="120000")
    if (nrow(asFrame) > 0) {
      asFrame$image <- paste0("http://earthcam.net", asFrame$image)
      date_filename <- gsub('.{6}$', '', dates1[i])
      date_filename <- paste0(date_filename, ".jpg")
      download.file(asFrame$image,date_filename, mode = 'wb')
    }
  }
  print(i)
}

setwd("..")

###

# dates3 = Hartford Talcott Mountain
dates3 <- seq(as.Date("2009-03-17"), as.Date("2016-02-09"), by="days")
dates3 <- as.character(dates3)
dates3 <- gsub("-", "", dates3)
dates3 <- paste0(dates3, "120012")

# Hartford Talcott Mountain
#  id=2319
#  projectid=1525
#  clientid=1
#  earliest: March 17, 2009 


id <- 2319
dir.create(as.character(id))
setwd(as.character(id))

for (i in 1:length(dates3)) {
  url <- paste0("http://www.earthcam.net/users2/json_request.php?page=archive_images&id=", id, "&projectid=1525&clientid=1075&archiveid=1&date=", dates1[i])
  response <- GET(url, 
                  set_cookies(`control_center_access_token` = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhdXRoLmVhcnRoY2FtLm5ldCIsInN1YiI6IjMxODMzIiwiaWF0IjoiMTQ1NTExNzE2NyIsImV4cCI6IjE0NTUxNDU5NjciLCJuYmYiOiIxNDU1MTE3MTY3IiwianRpIjoiMDM5OGVkMDQ4ZThkYzI2ZTEyODZiZjExZDJiZGE5ZGUifQ.lgiXOXCekluVyI9Hg-5uqu9Ez0Orgr_iq7mygDNek54",
                              `eula_users` = "user_31833%3D2",
                              `sid` = "fc4f4b51a8a6f4db33e0eb78f6d9efbf",
                              `system_check` = "1"))
  
  list <- content(x = response,as = 'text', encoding = "UTF-8")   
  
  json_data <- fromJSON(list, nullValue = NA)
  asFrame <- do.call("rbind.fill", lapply(json_data, as.data.frame))
  if (nrow(asFrame) > 3) {
    asFrame <-data.frame(t(asFrame))
    asFrame <- asFrame[,1:4]
    colnames(asFrame) <- c("time", "image_small", "image", "image_half")
    asFrame <- subset(asFrame, time=="120000")
    if (nrow(asFrame) > 0) {
      asFrame$image <- paste0("http://earthcam.net", asFrame$image)
      date_filename <- gsub('.{6}$', '', dates1[i])
      date_filename <- paste0(date_filename, ".jpg")
      download.file(asFrame$image,date_filename, mode = 'wb')
    }
  }
  print(i)
}

setwd("..")

