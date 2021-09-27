###########################################################
###########################################################
###########################################################
#### This Script scrapes the table from duiblock.com ######
###########################################################
###########################################################
###########################################################

###########################################################
###########################################################
#### Load packages
library(tidyverse)
library(rvest)
###########################################################
###########################################################



###########################################################
#### Function that build the table page by page ###########
#### HTML encoding is unclear, but seems to be working ####
#### Need to update to scrape first page ##################
###########################################################

scrape_dui = function(page) {
  
  url = paste("http://www.duiblock.com/dui_checkpoint_locations/colorado/?page=", page, sep = "")
  
  webpage = read_html(url, encoding = "ISO-8859-1")
  
  city = html_nodes(webpage, "center tr+ tr td+ td b")
  city = html_text(city)
  city = city[4:length(city)]
  
  county = html_nodes(webpage, "center a b")
  county = html_text(county)
  county = county[2:length(county)]
  
  location = html_nodes(webpage, "center td td+ td a font")
  location = html_text(location)
  
  time_date = html_nodes(webpage, "tr+ tr td~ td+ td > font")
  time_date = html_text(time_date)
  time_date = time_date[3:22]
  
  df = data.frame(county = county, city = city, location = location, time_date = time_date)
  
  return(df)
  
  Sys.sleep(2+rnorm(1, 1))
  
}

###########################################################
###########################################################
###########################################################
###########################################################

###########################################################
#### Set page range here (needs to start at 2) ############
###########################################################
pages = 2:16


###########################################################
###########################################################
#### Execute this loop to make a df with results ##########
###########################################################
###########################################################
results = data.frame()

for (i in 1:length(pages)) {
  
  temp = scrape_dui(pages[i])
  results = rbind(results, temp)
  
}
###########################################################
###########################################################
###########################################################

write.csv(results, file = "colorado.csv")
