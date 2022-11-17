library(tidyverse)
library(nycflights13)

farthest_record <- flights %>% arrange(desc(distance)) %>% slice(1)

farthest_record_new <- farthest_record[c("origin","dest","distance")]

farthest_record_join <- left_join(farthest_record,airports,by=c("dest"="faa"))

farthest_airport_name <- farthest_record_join["name"]

farthest_airport_name
