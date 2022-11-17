library(ggplot2) 
library(gapminder)
library(dplyr)


gapmider_without_kuwait <- gapminder %>% filter(country != "Kuwait") 


plot1 <- ggplot(gapmider_without_kuwait, aes(x=lifeExp,y=gdpPercap,color=continent,size=pop/100000)) +
  geom_point() + 
  facet_wrap(~year,nrow=1) +
  scale_y_continuous(trans = "sqrt") +
  theme_bw() +
  labs(x="Life Expectancy", y= "GDP per capita",size="Population (100k)")
  
plot1

ggsave(
  filename = "plot1.png", 
  width = 15,           
  height = 7,            
  units = "in"   
)

gapminder_continent <- gapmider_without_kuwait %>%
  group_by(continent,year) %>%
  summarise(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop),
            pop = sum(as.numeric(pop)))

plot2 <- ggplot(gapmider_without_kuwait,aes(x=year,y=gdpPercap,color=continent,size=pop/100000)) + 
  geom_line(aes(group=country),size=0.3) + 
  geom_point() + 
  geom_line(data=gapminder_continent,aes(x=year,y=gdpPercapweighted),color="black",size=0.5) + 
  geom_point(data=gapminder_continent,aes(x=year,y=gdpPercapweighted),color="black") + 
  scale_size_continuous(trans = "sqrt")+
  facet_wrap(~continent,nrow=1) + 
  theme_bw() + 
  labs(x="Year", y= "GDP per capita",size="Population (100k)")


plot2

ggsave(
  filename = "plot2.png", 
  width = 15,           
  height = 7,            
  units = "in"   
)


