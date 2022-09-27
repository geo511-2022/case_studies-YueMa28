library(tidyverse)
library(nycflights13)

farthest_distance_df <- flights %>%
  group_by(origin) %>%
  summarise(distance=max(distance))

result <- inner_join(flights,farthest_distance_df,by=c("origin","distance"))

result

result_new <- select(result,c("origin","distance","dest"))

result_new <- unique(result_new)

result_new2 <- inner_join(result_new,airports,by=c("dest"="faa")) %>% select("origin","distance","name")

result_new2
