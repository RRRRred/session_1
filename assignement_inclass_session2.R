## In Class assignement 
## Session 2
## Data visualisation

library(tidyverse)
library(ggplot2)
mpg

# Exercise set 1
#1
ggplot(mpg, aes(x=cty, y=hwy, colour=trans)) + geom_point()

#2
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point(colour='red') + geom_smooth()

#3
ggplot(mpg, aes(x=displ, y=hwy, colour=drv)) + geom_point() + geom_smooth(method='lm', se=F)

#4
ggplot(mpg, aes(x=displ, y=hwy, colour=cyl)) + geom_point() + geom_smooth()

# Exercise set 2
#5
mpg %>% tbl_df
str(mpg)

ggplot(mpg, aes(x = displ, y = hwy, colour = factor(cyl))) + 
  geom_point() + geom_smooth(method = "lm", se = FALSE) +
  scale_x_log10(breaks = c(2, 3, 4, 5, 6, 7), name = "Displacement") +
  scale_y_log10(breaks = c(20, 30, 40), name = "MPG, highway") +
  facet_grid(year ~ ., labeller = as_labeller(c("1999" = "Model year 1999", "2008" = "Model year 2008"))) +
  labs(color = "Cylinders", title = "Fuel economy and engine size")


# Exercise set 3
#6
mpg2 <- mpg %>% select(manufacturer, model, displ, year, cyl, trans, cty, hwy)

#7
mpg3 <- mpg2 %>% mutate(displ2 = displ^2, vol_per_cyl = round(displ/cyl,2))


#8
mpg3 %>% arrange(desc(vol_per_cyl))
mpg3 %>% filter(manufacturer == "chevrolet") %>% arrange(desc(vol_per_cyl))
mpg3 %>% group_by(manufacturer, year) %>% summarise(max_vol_per_cyl=max(vol_per_cyl))
# why does the next line not work, what happens? There is no max_vol_per_cyl column
# but also no error message
mpg3 %>% group_by(manufacturer, year) %>% mutate(max_vol_per_cyl=max(vol_per_cyl))
mpg3$max_vol_per_cyl #column unknown, why, even with summarise function

mpg4 <- mpg3 %>% group_by(manufacturer, year) %>% summarise(max_vol_per_cyl=max(vol_per_cyl))

#9
mpg5 <- mpg4 %>% spread(year, max_vol_per_cyl)

#10
mpg6 <- mpg5 %>%  mutate(change = `2008`-`1999`) #backticks nodig, altijd bij tidyr?

#11
mpg6 <- mpg6 %>% rename(max_vpc_1999 =`1999`, max_vpc_2008 = `2008`) 
# ik moet het weer terug opslaan in mpg6 om opgeslagen te worden in het dataframe, klopt dat?
mpg6$max_vpc_1999
mpg6 %>% gather(variable, value, max_vpc_1999, change) %>% View

# Exercise set 4
#12
install.packages("nycflights13")
library(nycflights13)
flights
str(flights)
tbl_df #what does deprecated mean, use as.tibble instead? 
airlines
weather
#both already a tibble when loading it, klopt dat?

flights2 <- flights %>% select(origin, year, month, day, hour,
                               sched_dep_time, dep_delay, carrier)
weather2 <- weather %>% select(origin, year, month, day, hour,
                                precip, wind_speed, visib)
inner_join(flights2,airlines)
# foutje in handout inner join between flight2 and airlines. ipv flights
flights2 %>% left_join(weather2)

#13
weather2 %>% summarise(min_precip = min(precip, na.rm = TRUE),
                      min_wind = min(wind_speed, na.rm = TRUE), 
                      max_visib = max(visib, na.rm = TRUE))

good_weather_delays <- flights2 %>% inner_join(weather2) %>% filter(precip == 0 & wind_speed == 0 & visib == 10)
avg_good_weather_delays <- good_weather_delays %>% group_by(carrier) %>% summarise(dep_delay = mean(dep_delay,
                       na.rm = TRUE)) %>% arrange(desc(dep_delay)) %>% inner_join(airlines)
#na.rm = TRUE is heel belangrijk
#allows us to ignore any weather data where one of these variables might be missing (i.e. NA)

#14
ggplot(avg_good_weather_delays, aes(x=dep_delay, y=name)) #waarom is dit plot leeg
ranked_airline_labels <- avg_good_weather_delays %>% transmute(carrier,
                                                          name = factor(-row_number(), labels = name))
good_weather_delays %>% inner_join(ranked_airline_labels) %>% ggplot(aes(x=name,
                        y = dep_delay)) + stat_summary() + coord_flip() +
                          labs(x = "", y= "Average deprture delay",
                               title= "Departure delays under ideal weather conditions\nNYC airports, 2013")
#waarom kon dit plot niet gemaakt worden met avg_good_weather_delays?
ggplot(avg_good_weather_delays, aes(x=name, y=dep_delay)) 