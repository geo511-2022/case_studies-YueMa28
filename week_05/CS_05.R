library(spData)
library(sf)
library(tidyverse)
library(units) 
library(ggplot2)
data(world)  

# load 'states' boundaries from spData package
data(us_states)

albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

ny_data <- us_states %>% filter(NAME=="New York")
CA_data <- world %>% filter(name_long=="Canada")
ny_data_transformed <- st_transform(ny_data,albers)
CA_data_transformed <- st_transform(CA_data,albers)

CA_data_buffer <- st_buffer(CA_data_transformed,10000)

ny_CA_inter <- st_intersection(ny_data_transformed,CA_data_buffer)

final_plot <- ggplot() + 
  geom_sf(data=ny_data_transformed) + 
  geom_sf(data=ny_CA_inter,fill="Red") +
  labs(title="New York Land within 10 km") +
  theme(plot.title = element_text(size=25L),axis.text = element_text(size=18))



final_plot

total_area <- st_area(ny_CA_inter) %>% set_units("km^2")

total_area

