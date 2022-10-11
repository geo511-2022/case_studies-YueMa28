library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)

data(world)  #load 'world' data from spData package

world_without_Antarctica <- world %>% filter(continent != "Antarctica")

tmax_monthly <- getData(name = "worldclim", var="tmax", res=10)

tmax_monthly_max <- max(tmax_monthly)

tmax_monthly_max <- tmax_monthly_max / 10
names(tmax_monthly_max) <- "tmax"
tmax_monthly_max <- raster::extract(tmax_monthly_max,world_without_Antarctica,fun=max,na.rm=T, small=T, sp=T)

tmax_monthly_max <- st_as_sf(tmax_monthly_max)

ggplot(tmax_monthly_max,aes(fill=tmax)) + 
  geom_sf() + 
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)") +
  theme(legend.position = 'bottom',panel.grid.major = element_blank(),legend.title = element_text(size=20L),legend.text= element_text(size=13),axis.text = element_text(size=18))
  

hottest_country <- tmax_monthly_max %>%
  group_by(continent) %>%
  top_n(1, tmax) %>%
  select(name_long, continent, tmax) %>%
  st_set_geometry(NULL) %>%
  arrange(desc(tmax))

hottest_country

