library(tidyverse)
library(rvest)

url = "http://www.duiblock.com/dui_checkpoint_locations/california/?page=2"

webpage = read_html(url)

city = html_nodes(webpage, "center tr+ tr td+ td b")

city = html_text(city)

city = city[4:length(city)]

county = html_nodes(webpage, "center a b")

county = html_text(county)

county = county[2:length(county)]
