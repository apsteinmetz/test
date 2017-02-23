# hadley's plotcon 2016 talk

library(tidyverse)
library(gapminder)
library(dplyr)

gapminder<-gapminder%>%mutate(year1950=year-1950)
by_country<-gapminder %>% group_by(continent,country) %>% nest()

country_model <- function(df) {
  lm(lifeExp ~ year1950, data=df)
  
}

models <-by_country %>% mutate(model = map(data,country_model))

models<- models %>% 
  mutate(
          glance = model %>% map(broom::glance),
          rsq = glance %>% map_dbl('r.squared'),
          tidy = model %>% map(broom::tidy),
          augment = model %>% map(broom::augment)
  )

models %>% ggplot(aes(rsq,reorder(country,rsq)))+geom_point(aes(colour=continent))
ggd<-unnest(models,tidy)%>%select(continent,country,term,estimate,rsq)%>%spread(term,estimate)
gg<-ggd%>%ggplot(aes(`(Intercept)`,year1950))
gg<-gg+geom_point(aes(colour=continent,size=rsq))
gg<-gg+xlab('Life Expectancy 1950')+ylab('Yearly Improvement')
gg<-gg+geom_smooth()
gg<-gg+scale_size_area()
gg
