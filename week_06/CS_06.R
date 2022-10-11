library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)

library(ncdf4)
data(world)
download.file("https://crudata.uea.ac.uk/cru/data/temperature/absolute.nc","crudata.nc")
tmean=raster("crudata.nc")
names(tmean) <- "tmean"
world_without_Antarctica <- world %>% filter(continent != "Antarctica")

names(tmean) <- "tmax"
tmax_monthly_max <- raster::extract(tmean,world_without_Antarctica,fun=max,na.rm=T, small=T, sp=T)

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

