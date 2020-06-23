setwd("C:/Users/Kyle/Documents/R_practice/R_for_data_science/")
setwd("/home/kyle/R_practice/R_for_data_science/")

install.packages("ggplot2")
install.packages("bindrcpp")
install.packages("rlang")
install.packages("plyr")
install.packages("tidyverse")
install.packages("maps")

#needed to install Rtools35.exe from CRAN
#https://cran.r-project.org/bin/windows/Rtools/

#Ubuntu execute this line for dependencies:
#sudo apt install libcurl4-openssl-dev libssl-dev libxml2-dev

library(tidyverse)
library(maps)

#notes on http://vita.had.co.nz/papers/layered-grammar.pdf
#1.INTRODUCTION
  #develop a "grammar" for visualization and graphics
  #based on "The Grammar of Graphics" (2005) Wilkinson, Anand, Grossman
#2.HOW TO BUILD A PLOT
  #variables can be mapped to aesthetics


#3.3 Aesthetic Mappings

# general formula
# ggplot(data = <DATA>) +
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

ggplot(data = mpg)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = cty > 20))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = hwy, y = cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl))

#facet wrap
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 3)

#can add facet grid (ooooo fancy)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ drv)

#other geoms
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))

#makes same graph as above
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(se = FALSE) + 
  geom_point(show.legend = FALSE)

ggplot(data = mpg, mapping = aes(x = hwy)) + 
  geom_area(stat = "bin")

ggplot(data = mpg, mapping = aes(x = hwy, y = cty)) + 
  geom_point(mapping = aes(color = drv)) + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = hwy, y = cty)) +
  geom_text(aes(label = drv))

#Exercise 3.7.1 (#6)
#plot 1
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(size = 3) + 
  geom_smooth(size = 2, se = FALSE)

#plot 2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(size = 3) + 
  geom_smooth(mapping = aes(group = drv), size = 2, se = FALSE)

#plot 3
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point(size = 3) + 
  geom_smooth(size = 2, se = FALSE)

#plot 4
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv), size = 3) +
  geom_smooth(se = FALSE, size = 2)

#plot 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv), size = 3) +
  geom_smooth(mapping = aes(linetype = drv), se = FALSE, size = 2)

#plot 6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(size = 6, color = "white") + 
  geom_point(mapping = aes(color = drv), size = 3)

#3.7 Statistical Transformations

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) +
  geom_col(mapping = aes(x = cut, y = depth))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut), color = "#000000")

#3.8 Position Adjustments

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 0.2, position = "identity")

ggplot(data = diamonds, mapping = aes(x = cut, color = clarity)) +
  geom_bar(fill = NA, position = "identity")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

#3.8.1 Exercises
#1
#original plot
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point()
#revised plot
#there are many overlapping points, so random noise helps view better
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter()

#2 - the argument <width> alters the amount of "jitter" or randomness in the points

#3 - geom_jitter vs geom_count
# geom_jitter moves the points around so they are visualized
# geom_count alters the size of the point to represent the number of 
# points on the same spot.
# compare this graph with the one above
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count()

#4 - geom_boxplot
# x must be categorical, y must be continuous
ggplot(data = mpg, mapping =aes(x = class, y = cty)) +
  geom_boxplot()

#3.9 Coordinate Systems
#coord_flip() switches x and y axis
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

#map data
nz <- map_data("nz")
usa <- map_data("usa")
states <- map_data("state")

ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "#FFFFFF", color = "#000000") + 
  coord_quickmap()

ggplot(usa, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "#FFFFFF", color = "#000000") +
  coord_quickmap()

arrests <- USArrests
names(arrests) <- tolower(names(arrests))
arrests$region <- tolower(rownames(USArrests))

chono <- merge(states, arrests, sort = FALSE, by = "region")
chono <- chono[order(chono$order),]

ggplot(chono, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(group = group, fill =  assault)) +
  coord_quickmap()

#polar coordinates
bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

#3.9.1 Exercises
#1 - turn a stacked bar chart into a pie chart using coord_polar()
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = "", fill = cut), position = "stack") +
  coord_polar(theta = "y")
  
#2 - labs() is the labels for the graph
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut)) +
  ggtitle("STUFF") +
  xlab("this is the x axis") +
  ylab("this is the y axis")

#3 - coord_quickmap() vs. coord_map()
nz <- map_data("nz")
ggplot(data = nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "black", color = "red") +
  coord_map()

#4 - geom_abline(), default slope = 0 and default intercept = (0,0)
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  coord_fixed() +
  geom_abline(slope = 1, intercept = 0)

#chapter 5 - Data transformation
# dplyr basics: 
  # filter() picks observations by values
  # arrange() reorders the rows
  # select() chooses columns
  # mutate()
  # summarise()
install.packages("nycflights13")
library(nycflights13)
library(tidyverse)

filter(flights, month == 1, day ==1)
filter(flights, dep_delay == -4)
jan1 <- filter(flights, month == 1, day == 1)
dec25 <- filter(flights, month == 12, day == 25)

p <- ggplot(data = flights, aes(x = dep_delay, y = arr_delay))
p + geom_point()

# == vs. near()
sqrt(2) ^ 2 == 2 #FALSE
1 / 49 * 49 == 1 #FALSE
near(sqrt(2) ^ 2, 2) #TRUE
near(1/49 * 49, 1) #TRUE

ggplot(data = flights, mapping = aes(x = carrier, y = dep_delay)) +
  geom_boxplot()
ggplot(data = flights, mapping = aes(x = dep_delay, y = arr_delay)) +
  geom_point() +
  geom_abline()

nov_dec <- filter(flights, month == 11 | month == 12)
#is the same as
nov_dec <- filter(flights, month %in% c(11,12))
nov_dec

#if you want to know if a value is missing
x <- NA
is.na(x) #TRUE

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, x > 1 | is.na(x))

#5.2.4 Exercises
?flights
#1.1 arrival of 2 or more hours
filter(flights, arr_delay >= 120)
#1.2 flew to Houston (airport code IAH or HOU)
filter(flights, dest == "IAH" | dest =="HOU")
filter(flights, dest %in% c("IAH","HOU"))
#1.3 Operated by United (UA), American (AA), or Delta (DL)
filter(flights, carrier == "UA" | carrier == "AA" | carrier == "DL")
filter(flights, carrier %in% c("UA","AA","DL"))
#1.4 Departed in the summer (July, Aug, Sept) (7,8,9)
filter(flights, month >= 7 & month <= 9)
filter(flights, month %in% c(7,8,9))
filter(flights, month == 7 | month == 8 | month == 9)
filter(flights, between(month, 7, 9))
#1.5 Arrived more than 2 hours late, but didn't leave late
filter(flights, arr_delay >= 120 & dep_delay <= 0)
#1.6 Were delayed by at least an hour, but made up over 30 min in flight
filter(flights, dep_delay >= 60 & dep_delay - arr_delay >= 30)
#1.7 Departed between midnight and 6am
filter(flights, dep_time >= 0000 & dep_time <= 0600)
?between
filter(flights, between(dep_time, 0000, 0600))
#2 - between, see altered answers above
#3 How many flights have a missing dep_time? (is.na)
filter(flights, is.na(dep_time))
#4 Stuff on NA
NA ^ 0 # 1, any value ^ 0 = 1
NA * 0 # NA hmmm...
NA | TRUE # TRUE, will always evaluate to TRUE
TRUE | NA # TRUE, same as above 
NA & FALSE # FALSE, will always evaluate to FALSE

#5.3 arrange()
?arrange() #arranges rows, default is ascending, NA is always at the end
arrange(flights, year, month, day)
# can set to descending with desc()
arrange(flights, desc(dep_delay))
#5.3.1 Exercises
#1 Sort all missing values to top
arrange(flights, desc(is.na(dep_delay)))#sorts alphabetically by TRUE/FALSE
arrange(flights, !is.na(dep_delay))
#2 most delayed flights
arrange(flights, desc(dep_delay)) # most delayed
arrange(flights, dep_delay) # left earliest
#3 find the fastest flights
arrange(flights, air_time)
d <- select(flights, air_time, origin, dest, everything())
arrange(d, air_time) #shortest flight
t <- select(flights, distance, air_time, origin, dest, everything())
arrange(t, desc(distance/air_time)) #fastest flight in speed
#4 flights traveled the longest, shortest
f <- select(flights, distance, air_time, origin, dest, everything())
arrange(f, distance) #shortest --> newark to NYC(LGA)
arrange(f, desc(distance)) #longest NYC(JFK) to HNL (Honolulu, HI)

#5.4 select()
#select these specific columns
select(flights, year, month, day)
#select all columns between year and day
select(flights, year:day)
#select all columns except for those between year and day
select(flights, -(year:day))
#useful commands:
  #starts_with("abc"): matches name beginning with "abc"
  #ends_with("xyz"): matches name ending with "xyz"
  #contains("ijk"): matches names containing "ijk"
  #matches("<regular expression>")
  #num_range("x", 1:3) matches x1, x2, x3
#rename() can remane variables
  #in the format rename(data, NEW_NAME = OLD_NAME)
p <- rename(flights, tail_num = tailnum)
select(p, tail_num)
p
#5.4.1 Exercises
#1 - how many ways to select dep_time, dep_delay, arr_time, arr_delay
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, starts_with("dep"), starts_with("arr"))
#2 - same variable multiple times in select()
select(flights, month, month, month) #removes redundencies
#3 - What does one_of() do?
  #if variable is not in list, then it will still create the dataset, but
  #simply give a warning
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
vars_error <- c("year", "month", "day", "dep_delay", "arr_delay", "weight")
select(flights, one_of(vars))
select(flights, one_of(vars_error))
?one_of
#4 - does this result surprise you
select(flights, contains("TIME"))
#yes, I thought it would be case sensitive
?contains() #can change default
select(flights, contains("TIME", ignore.case = FALSE))

#5.5 Add new variables with mutate()
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60,
       hours = air_time / 60,
       gain_per_hour = gain / hours #can reference variables just created
) # need to store in new variable if want to keep, alternative, pipe to other things

#transmute() only keeps new variables
transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)

#5.5.1 Useful creation functions to use with mutate()
# function must be vectorized
# arithmetic operations: + - * / ^
# can also do sum() and mean() etc.
# modular arithmetic %/% (integer division) and %% (remainder)
# x == y * (x %/% y) + (x %% y)
# x == y * integer_floor + remaider
transmute(flights,
          dep_time,
          hour = dep_time %/% 100, # gives hour since this is in military time
          minute = dep_time %% 100 # remaining minutes
          )
# logs() i.e. log(), log2(), log10()
# offsets: lead() and lag()
# cumulative and rolling aggregates
x <- c(1:10)
cumsum(x) #each value is the cumulative sum of the values
cummean(x) # each value is the cumulative mean of the values
#ranking
  #min_rank() adds a column with the rank of the variable given
  #default is low to high, to reverse, do min_rank(desc(y))

#5.5.2 Exercises
#1 - dep_time and sched_dep_time are hard to compute with. Convert to minutes since midnight
x <- select(flights, dep_time, sched_dep_time)
y <- mutate(x,
       dt_from_mid = ((dep_time %/% 100)*60 + dep_time %% 60),
       sdt_from_mid = ((sched_dep_time %/% 100)*60 + sched_dep_time %% 60)
)
#2 - compare air_time with arr_time - dep_time
p <- select(flights, air_time, arr_time, dep_time)
mutate (p,
        at_from_mid = ((arr_time %/% 100)*60 + arr_time %% 60),
        dt_from_mid = ((dep_time %/% 100)*60 + dep_time %% 60),
        adj_total_time = at_from_mid - dt_from_mid,
        wrong_total_time = arr_time - dep_time
        )
  # they are different because one is in time and the other is in military time, not an int
  # need to change to min since midnight as in #1

#3 - compare dep_time, sched_dep_time, and dep_delay. how are they related?
p <- select(flights, dep_time, sched_dep_time, dep_delay)
  #dep_delay = dep_time - sched_dep_time
  #dep_delay should be the same as:
  #mutate(flights, x = dep_time - sched_dep_time)
q <- mutate(p, x = dep_time - sched_dep_time)
  #needs to be changed to time, its not an int. same as problem #2

#4 - find the 10 most delayed flights using a ranking function. How to handle ties?
p <- select(flights, dep_delay, everything()) %>% arrange()
p <- arrange(p, dep_delay)
p

flights %>%
  select(dep_delay, everything()) %>%
  arrange(dep_delay)

#5 - what does 1:3 + 1:10 do?
1:3 + 1:10
  #takes the longer object (1:10) and addes the short object (1:3) across each element
  #1 2 3 4 5 6 7  8  9 10 (1:10)
  #1 2 3 1 2 3 1  2  3  1 (1:3)
  #2 4 6 5 7 9 8 10 12 11 (result)

#6 - what trig functions does R provide?
  #sin(), cos(), tan(), sinh(), cosh(), tanh(), asin(), acos(), atan()

# Chapter 5.6 - Grouped Summaries with summarize()

flights %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE))

p <- flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE),
            stdev = sd(dep_delay, na.rm = TRUE))

q <- ggplot(data = p, aes(x = day, y = delay)) +
  geom_line() +
  facet_wrap( ~ month) +
  geom_errorbar(aes(ymin = delay - stdev, ymax = delay + stdev))

#5.6.1 THE PIPE %>%
#combine functions together to make more readable code
#sidenote: ggvis is the next version of ggplot2 which uses the pipe


delays <- flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")
  
#5.6.2 Missing Values
  #the na.rm = TRUE means remove missing values prior to computation

not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))

#5.6.3 Counts
  #whenever an aggregation is done, its generally good to do a count using n()
  #also do a count of non-missing values with sum(!is.na(x))

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(
    count = n(),
    delay = mean(arr_delay),
    delay_sd = sd(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)

not_cancelled %>%
  select(tailnum, arr_delay) %>%
  group_by(tailnum) %>%
  summarise(delaymean = mean(arr_delay),
            n = n()) %>%
  arrange(desc(delaymean))

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 0.1)

delays %>%
  filter(n > 25) %>%
  ggplot(mapping = aes(x = n, y = delay)) + 
    geom_point(alpha = 0.1)

install.packages("Lahman")
batting <- as_tibble(Lahman::Batting)

batters <- batting %>%
  group_by(playerID) %>%
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>%
  filter(ab > 100) %>%
  ggplot(mapping = aes(x = ab, y = ba)) + 
  geom_point() + 
  geom_smooth(se = FALSE)


#5.6.4 Useful Summary Functions
#measures of location:
  # mean(), median()

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # average positive delay
  )

#measures of spread
  # sd() = standard deviation
  # IQR() = inter quartile range
  # mad() = median absolute deviation

not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance),
            n = n()) %>% 
  arrange(desc(distance_sd))

#measures of rank
  # min()
  # quartile(x, 0.25) will find a value of x > 25% of the values and less than the remaining 75%
  # max()

  #when do the first and last flights leave each day?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

#measures of position
  # first()
  # nth(x, 2) second value? works similar to x[2]
  # last()

  #find first and last departure for each day
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )

#counts
  # n() takes no arguments and returns the size of the current group
  # sum(!is.na(x)) counts the number of non-missing values
  # n_distinct(x) counts the number of unique values

  #which destinations had the most carriers?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))

not_cancelled %>% 
  count(dest)

not_cancelled %>% 
  count(tailnum) #flights flown by each tailnum (plane)

not_cancelled %>% 
  count(tailnum, wt = distance) #totals the distance for each tailnum (plane). wt = "weight"

#can use boolean evals to count number of observasions that meet that criteria
#sum(BOOLEAN) works because TRUE is evaluated as 1 and FALSE as 0
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time < 500)) #how many flights leave before 5am?

#What proportion of flights are delayed by more than an hour?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_delay = mean(arr_delay > 60)) #mean(boolean) is the same as proportion

#5.6.5 GROUPING WITH MULTIPLE VARIABLES

daily <- flights %>% 
  group_by(year, month, day)
(per_day <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))

#5.6.6 UNGROUPING

daily %>% 
  ungroup() %>% 
  summarise(flights = n())

#5.6.7 EXERCISES
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))
  #1 - Brainstorm 5 different ways to assess the following:
  #A - flights arrives 15min early 50% of the time and 15min late the other 50%
A <- not_cancelled %>% #fuck this problem
  select(flight, arr_delay) %>% 
  group_by(flight) %>% 
  summarise(late_or_early = mean(arr_delay < -15 | arr_delay > 15)) %>% 
  filter(late_or_early == 1)
  
  #B - A flight is always 10 min late
B <- not_cancelled %>% 
  select(flight, arr_delay) %>% 
  group_by(flight) %>% 
  summarise(
    n = n(),
    late10 = sum(arr_delay > 10)
  ) %>% 
  filter(late10 == n) %>% 
  arrange(desc(n))
B

#flight 3585 is always > 10 min late. What is the route of the flight?
flights %>% 
  filter(flight == 3585) %>% 
  select(year, month, day, origin, dest, carrier)
  #route is JFK --> PHL
  #all flights were in July/August

  #C - find another way to to the following without count()
not_cancelled %>% 
  count(dest)

not_cancelled %>% 
  group_by(dest) %>% 
  summarise(n = n())

#3 - definition of cancelled flight is (is.na(dep_delay) | is.na(arr_delay)).
  #why is this suboptimal? which is more important?
  #arr_delay is more important because dep_delay flights can be rerouted to another
    #airport or they can crash

  #4 - is there a pattern to cancelled flights?
flights %>% 
  select(year, month, day, arr_delay) %>% 
  filter(is.na(arr_delay)) %>% 
  group_by(year, month, day) %>% 
  summarise(n = n()) %>% 
  ggplot(mapping = aes(x = day, y = n)) + 
  geom_line() + 
  facet_wrap( ~ month)

#there is a spike in early february in flights not arriving. What about departures?

flights %>% 
  select(year, month, day, dep_delay) %>% 
  filter(is.na(dep_delay)) %>% 
  group_by(year, month, day) %>% 
  summarise(n = n()) %>% 
  ggplot(mapping = aes(x = day, y = n)) + 
  geom_line() + 
  facet_wrap( ~ month)

#plot both? or plot difference in not arrived vs not left

flights %>% 
  select(year, month, day, dep_delay, arr_delay) %>% 
  filter(is.na(dep_delay) | is.na(arr_delay)) %>% 
  group_by(year, month, day) %>% 
  summarise(
    n_delayed = sum(is.na(dep_delay)),
    n_not_arrived = sum(is.na(arr_delay)),
    diff = n_not_arrived - n_delayed
  ) %>% 
  ggplot() + 
  geom_line(mapping = aes(x = day, y = diff)) +
  #geom_line(mapping = aes(x = day, y = n_delayed, color = "red")) + 
  #geom_line(mapping = aes(x = day, y = n_not_arrived, color = "blue")) + 
  facet_wrap( ~ month)


cancelled <- flights %>% 
  select(year, month, day, dep_delay, origin) %>% 
  filter(month == 2, day == 8:9, is.na(dep_delay)) %>% 
  group_by(origin) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))
#  ggplot(mapping = aes(x = day, y = n)) + 
 # geom_line() +
  #facet_wrap( ~ month)
cancelled

#5 - which carrier had the worst delay?
not_cancelled %>% 
  select(carrier, dep_delay) %>% 
  group_by(carrier) %>% 
  summarise(
    mean_delay = mean(dep_delay)
  ) %>% 
  arrange(desc(mean_delay))

#which departing airports have the worst delay?
not_cancelled %>% 
  select(origin, dep_delay) %>% 
  group_by(origin) %>% 
  summarise(
    mean_delay = mean(dep_delay)
  ) %>% 
  arrange(desc(mean_delay))

#which destinations have worst arrival time?
not_cancelled %>% 
  select(dest, arr_delay) %>% 
  group_by(dest) %>% 
  summarise(
    mean_arr_delay = mean(arr_delay)
  ) %>% 
  arrange(desc(mean_arr_delay))

flights_sml <- flights %>% 
  select(year:day,
         ends_with("delay"),
         distance,
         air_time
  ) %>% 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60
  )

#finds the fastest flights
flights_sml %>% 
  arrange(desc(speed))

#5.7 GROUPED MUTATES (AND FILTERS)
  #using group_by() with mutate() and filter()
#find the worst members of each group
#groups by year/month/day, then shows the top 10 for each group
flights_sml %>% 
  group_by(year, month, day) %>% 
  filter(rank(desc(arr_delay)) < 10)

# find all groups bigger than a certain threshold
popular_dest <- flights %>% 
  # select(dest, everything()) %>% 
  group_by(dest) %>% 
  filter(n() > 365)
popular_dest

# Standarize to compute per group metrics
popular_dest %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  select(year:day, dest, arr_delay, prop_delay)

#5.7.1 EXERCISES
  # 2 - Which tailnum had the worst on-time record?
flights %>% 
  filter(!is.na(tailnum), !is.na(dep_delay)) %>% 
  group_by(carrier) %>%
  summarise(
    n = n(),
    prop_late = sum(dep_delay > 0) / n,
  ) %>% 
  # arrange(desc(prop_late), desc(n)) %>% 
  ggplot(mapping = aes(x = n, y = prop_late, label = carrier)) +
  geom_point(mapping = aes(color = carrier)) +
  geom_text(position = position_nudge(y = -0.05)) +
  xlim(0,60000) + 
  ylim(0,1.0)

#WORST PLANE. SHAME. 16 flights all late
flights %>% 
  filter(tailnum == "N66808")

  #3 - What time of day should you fly if you want to avoid delays?
flights %>% 
  filter(!is.na(dep_time), !is.na(dep_delay)) %>% 
  mutate(dep_time_by_hour = dep_time %/% 100) %>% # bin to every hour
  group_by(dep_time_by_hour) %>%
  summarise(
    n = n(),
    prop_late = sum(dep_delay > 0) / n
  ) %>% 
  filter(n > 0) %>% 
  ggplot(mapping = aes(x = dep_time_by_hour, y = prop_late)) + 
  geom_line()

flights %>% 
  filter(dep_time %/% 100 == 4) %>% 
  arrange(desc(dep_delay))

  #4 for each dest, calculate the total min of delay
flights %>% 
  filter(!is.na(dep_delay), !is.na(dep_time)) %>% 
  group_by(dest) %>% 
  summarise(
    n = n(),
    total_delay = sum(dep_delay),
    ave_delay = mean(dep_delay)
  ) %>% 
  arrange(desc(total_delay), n)

  #6 - find oddly fast flights
flights %>% 
  filter(!is.na(dep_time), !is.na(dep_delay)) %>% 
  mutate(
    speed = distance / air_time * 60
  ) %>% 
  select(speed, origin, dest, distance, air_time) %>% 
  arrange(desc(speed))

flights %>% 
  filter(dest == "ATL", origin == "LGA", !is.na(dep_time), !is.na(dep_delay)) %>% 
  mutate(
    speed = distance / air_time * 60
  ) %>% 
  select(speed, origin, dest, distance, air_time) %>% 
  arrange(desc(speed))

  #7 - find all destinations flown by 2 or more carriers
flights %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  filter(carriers > 1) %>% 
  arrange(desc(carriers))


#CHAPTER 6 - WORKFLOW
# ive already been doing this

#CHAPTER 7 - EXPLORATORY DATA ANALYSIS
#7.3.1 - Visualizing discributions
#categorical variable:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

diamonds %>% 
  count(cut)

#continuous variable:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = carat), binwidth = 0.5)

diamonds %>% 
  count(cut_width(carat, 0.5)) # this is what i was looking for in 5.7.1 Exercises

  #always check multiple bins
smaller <- diamonds %>% 
  filter(carat < 3)
ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.05)

  #overlaying multiple histograms
ggplot(data = smaller, mapping = aes(x = carat, color = cut)) + 
  geom_freqpoly(binwidth = 0.01)

diamonds %>% 
  group_by(carat) %>% 
  summarise(
    n = n()
  ) %>% 
  arrange(desc(n))

#7.3.2 Typical Values
ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_histogram(binwidth = 0.1)

#7.3.3 Unusual Values
  #look for outliers, may be error in data entry?
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5)
  #the only evidence that there is an outlier is the long x-axis (labeled "y")

#shorted y-axis
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) + 
  coord_cartesian(ylim = c(0,50))
  # ylim(0,50) dont use this because it throws out values outside the limits

diamonds %>% 
  filter(y < 3 | y > 25) %>% 
  select(price, x, y, z) %>% 
  arrange(y)
  # there are two outliers, one with y = 58.9 and another with y = 31.8
  # also values at 0, error in data entry. Size in mm cannot be 0

#7.3.4 Exercises
  #1 - explore x y z in diamonds

# x vs y
diamonds %>% 
  filter(x> 0, y > 0, z > 0, y < 25) %>%  #removes those outliers from before
  ggplot(mapping = aes(x = x, y = y)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# x vs z
diamonds %>% 
  filter(x> 0, y > 0, z > 0, y < 25, z < 25) %>%  #removes those outliers from before
  ggplot(mapping = aes(x = x, y = z)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# y vs z
diamonds %>% 
  filter(x> 0, y > 0, z > 0, y < 25, z < 25) %>%  #removes those outliers from before
  ggplot(mapping = aes(x = y, y = z)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

diamonds %>% 
  filter(z > 0) %>% 
  arrange(z)

#7.4 MISSING VALUES
# what to do with missing/unusual values?
# remove entire row?
diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20)) #removes weird values

# replace weird values with NA, as to preserve the other data
diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
  # ifelse has 3 arguments
  # (boolean test, value if TRUE, value if FALSE)
  # ggplot2 will warn you if NA values are removed. It does not plot them

ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
  geom_point() 
  # 9 rows removes for having missing values (NA)
  # the warning can be suppressed with na.rm = TRUE
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
  geom_point(na.rm = TRUE)

#compare scheduled dep times and non-cancelled times
flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
    ggplot(mapping = aes(sched_dep_time)) + 
    geom_freqpoly(mapping = aes(color = cancelled), binwidth = 0.25)

#7.4.1 EXERCISES
  #1 - what happens to missing values in histograms?
  diamonds2 %>% 
    ggplot(mapping = aes(x = y)) + 
    geom_histogram(binwidth = 0.1)
  # the rows with the NA values get removed
  #2 - what does na.rm = TRUE do in mean() and sum()
  # it removes the NA values before calculaing the mean or sum. Otherwise it 
  # returns NA. Default assignment is na.rm = FALSE
  
#7.5 COVARIATION

ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500)
  # hard to see difference because overall counts differ. Need to normalize by n

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500)
  # fair diamonds appear to have the highest average price

diamonds %>% 
  group_by(cut) %>% 
  summarise(
    ave_price = mean(price)
  )

#try using a box plot
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + 
  geom_boxplot()

#how does mileage vary across car classes
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
#reorder x-axis by median value of hwy by using reorder()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))
#flip coordinates with coord_flip()
ggplot(data = mpg) + # dont need to declare x and y twice. removed here
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip()

#7.5.1.1 EXERCISES
#2 - what var is most important in predicting the price of a diamond?

#builds a single observation for score and corellation
build_obs <- function(
  df = diamonds,
  carat_w = runif(1, 0.8, 1),
  depth_w = runif(1, 0, 0.1),
  table_w = runif(1, 0, 0.1),
  x_w = runif(1, 0, 0.3),
  y_w = runif(1, 0, 0.3),
  z_w = runif(1, 0, 0.3)
){
  tempdf <- mutate(df,
         carat_new = carat * carat_w,
         depth_new = depth * depth_w,
         table_new = table * table_w,
         x_new = x * x_w,
         y_new = y * y_w,
         z_new = z * z_w,
         score = carat_new + depth_new + table_new + x_new + y_new + z_new
         )
  corellation <- cor(tempdf$score, tempdf$price)
  output <- tibble(carat_w = carat_w,
                   depth_w = depth_w,
                   table_w = table_w,
                   x_w = x_w,
                   y_w = y_w,
                   z_w = z_w,
                   corellation = corellation)
  return(output)
}

#build table
for (i in c(1:10000)){
  if (i == 1){
    output <- build_obs()
  } else {
   x <- build_obs()
   output <- full_join(output, x)
  }
}
output

#sort by highest corellation
output %>% 
  arrange(desc(corellation))

#calculate mean weightings for corrlations above a certain threshold
output %>% 
  filter(corellation > 0.91) %>% 
  summarise(
    n = n(),
    mean_carat = mean(carat_w),
    mean_depth = mean(depth_w),
    mean_table = mean(table_w),
    mean_x = mean(x_w),
    mean_y = mean(y_w),
    mean_z = mean(z_w)
  )

#corrlations of individual values
diamonds %>% 
  select(carat, depth, table, price, x, y, z) %>% 
  cor()

#calculate cor. coeff. for data score as is (all weights == 1)
diamonds %>% 
  mutate(
    score = carat + depth + table + x + y + z
  ) %>% 
  select(score, price) %>% 
  cor() #0.7451318

#build histogram of corellation coefficients
output %>% 
  ggplot(mapping = aes(x = corellation)) + 
  geom_histogram(binwidth = 0.0001)

#5 - compare and contrast geom_violin() with geom_histogram, geom_freqpoly()
diamonds %>% 
  group_by(cut) %>% 
  ggplot(mapping = aes(x = cut, y = carat)) + 
  geom_violin(mapping = aes(color = cut, fill = cut), show.legend = FALSE) + 
  geom_boxplot(mapping = aes(alpha = 0.3), show.legend = FALSE) + 
  theme(
    panel.background = element_blank(),
    axis.line = element_line(color = "#000000"),
  )

#7.5.2 TWO CATEGORICAL VARIABLES
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))

diamonds %>% 
  count(color, cut) %>% 
  ggplot(mapping = aes(x = color, y = cut)) + 
  geom_tile(mapping = aes(fill = n))

#7.5.3 TWO CONTINUOUS VARIABLES
diamonds %>% 
  ggplot() +
  geom_point(mapping = aes(x = carat, y = price), alpha = 0.1)

diamonds %>% 
  ggplot() + 
  geom_bin2d(mapping = aes(x = carat, y = price))

#hex plot
install.packages("hexbin")
library("hexbin")
diamonds %>% 
  ggplot() +
  geom_hex(mapping = aes(x = carat, y = price))

#bin one var so it acts like a categorical var
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))

#7.6 PATTERNS AND MODELS
  # spot a pattern:
  # ask:
  # due to coincidence?
  # what relationship is implyed?
  # how strong is the relationship?
  # what other variable affect relationship?
  # does relationship change when looking at different subgroups?

ggplot(data = faithful) +
  geom_point(mapping = aes(eruptions, y = waiting))

library("modelr")
# lm() - linear model function
mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

ggplot(data = diamonds2) +
  geom_point(mapping = aes(x = carat, y = resid))

ggplot(data = diamonds2) + 
  geom_boxplot(mapping = aes(x = cut, y = resid))

# 7.7 GGPLOT CALLS
# do less typing. dont need "data =" or "mapping =" or x/y = ...
ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_freqpoly(binwidth = 0.25)
#can be rewritten as:
ggplot(faithful, aes(eruptions)) + 
  geom_freqpoly(binwidth = 0.25)
# can pipe data from dplyr stuff into ggplot
diamonds %>% 
  count(cut, clarity) %>% 
  ggplot(aes(clarity, cut, fill = n)) + 
    geom_tile()

#8 - WORKFLOW: PROJECTS
# highly recommended to not save .RData workspace between sessions
# forces you to write down everything in the to the editor and save the file
# trick to make sure captured important parts in the code:
  # Ctrl + Shift + F10 = restarts RStudio
  # Ctrl + Shift + S = reruns entire script

#--------------------WRANGLE--------------------------------

#10 - TIBBLES
vignette("tibble") #might be a good read
#coerce a data frame to a tibble with as_tibble()
as_tibble(iris)
#create new tibble with tibble()
#it will recycle vars of length 1, and extend the all the way down the column
#does not convert strings to factors
tibble(
  x = 1:5,
  y = 1,
  z = x^2 + y
)
#for variables that dont start with letters (i.e. number, or special char)
#surround in backticks ``
tb <- tibble(
  `:)` = "smile",
  ` ` = "space",
  `2000` = "number",
  x = 1:5
)
tb

#another way do create a tibble is with transposed tibble - tribble()
#basically tibble is typed out as a table with comma separaters
tribble(
  ~x, ~y, ~z,
  #--/--/---- denotes where header is, personal style of H.W.
  "a", 2, 3.6,
  "b", 1, 8.5
)

#10.3 - Tibbles vs data.frame
#printing
#tibbles only show the first 10 rows and as many columns as can fit in the display
#if you want more lines, print(n = 20) prints 20 rows, etc.
#if you want all columns to be displayed, set
# width = Inf
nycflights13::flights %>% 
  print(n = 10, width = Inf)

#10.3.2 - SUBSETTING
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

#extract by name
df$x #get column x
df[["x"]] #get column x
#extract by position
df[[1]] #get column 1

# to pipe with, need the placeholder '.'
df %>% 
  .$x

#to coerse tibble back to data.frame use as.data.frame()

#10.5 EXERCISES
#1 - how do you tell if an object is a tibble? Try printing mtcars
#formatting is different
mtcars
print(mtcars)
as_tibble(mtcars)

#2 - compare and contrast data.frame operations
df <- data.frame(abc = 1, xyz = "a")
df$x #returns column xyz
df[,"xyz"] #retruns column xyz
df[, c("abc","xyz")] #returns both columns
  #why is that comma there?

#3 - if a variable has the name of an obiect in a tibble, how to extract
var <- "mpg"
df <- tibble(mtcars)
df$var #does not work
df[[var]] #this works because it needs quotes normally

#4 - do the following in this annoying data frame (tibble)
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
annoying
  #extract the variable `1`
annoying$`1`
  #scatterplot of `1` vs `2`
annoying %>% 
  ggplot(aes(`1`,`2`)) +
  geom_point()
  #create new column 3 which is 2 divided by 1
annoying2 <- annoying %>% 
  mutate(
    `3` = `2` / 1
  )
  #rename columns to one, two, three
annoying2 %>% 
  rename(one = `1`, two = `2`, three = `3`)

#5 - what does tibble::enframe() do?
tibble::enframe(c(a = 5, b = 7))
enframe(list(one = 1, two = 2:3, three = 4:6))

#---------------------------------------------------------
#11 - DATA IMPORT
#reading in data with readr (part of tidyverse)
read_csv() #reads in comma delimited files
read_csv2() #reads in semicolon separated files (common in countries where , is decimal)
read_tsv() #reads in tab delimited files
read_delim() #reads in with any delimiter
read_fwf() #reads fixed width files
read_log #reads Apache style log files

#first argument is filepath
#can also enter inline csv file:
read_csv(
  "a,b,c
  1,2,3
  4,5,6"
)

#if the first n rows are comments, can skip those lines with skip = n
read_csv("The first line of metadata
         the second line of metatdata
         x,y,z
         1,2,3
         4,5,6", skip = 2)

#can also define what lines to skip be comment char
read_csv("# comment 1
         # comment 2
         # blahblahblah
         x,y,z
         1,2,3", comment = "#")
read_csv("# A comment I want to skip
         another comment
         x,y,z
         1,2,3", comment = "#")

#if columns have no names, set col_names = FALSE
read_csv("1,2,3\n4,5,6", col_names = FALSE)
#col_names can also be passed a vector to use as the names 
read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))

# na = spcifies the char used for NA values
read_csv("a,b,c\n1,2,.", na = ".")

#11.2.2 EXERCISES
#1 - what to use to read in file delimited with |
read_delim("a|b|c\n1|2|3", delim = "|")
read_fwf()

#11.3 PARSING A VECTOR
#purpose is to read in a character vector and return a different vector (int, dbl, date)
#some of the parse_*() functions:
parse_logical()
parse_integer()
parse_date()
parse_character()
parse_factor()

str(parse_integer(c("1","2","3")))

#first argument is the character vector to parse
#na argument says which strings should be treated as missing or NA
parse_integer(c("1","2","3","."), na = ".")

#failed parsing returns a warning
x <- parse_integer(c("123","456","abc","123.45"))
#failed values will be NA
#can analyze failed parsed values with problems()
problems(x) #returns a tibble, which can be played with to determine why vals missing

#11.3.1 NUMBERS (as in parsing numbers)
#sometimes people write numbers differently in different parts of the world
#i.e. "." vs "," for a decimal
#sometimes numbers are surrounded by special character ($, %, currency symbols)
#the can contian grouping chars (i.e 1,000,000 instead of 1000000)

# . vs ,
parse_double("1.23")
parse_double("1,23", locale = locale(decimal_mark = ","))

# special chars
parse_number("$100") #100
parse_number("20%") #20
parse_number("It cost $123.45") #123.45, ignores non-numeric chars before and after num

# grouping marks
parse_number("$123,456,789") #123456789
parse_number("123.456.789", locale = locale(grouping_mark = ".")) #123456789
parse_number("123'456'789", locale = locale(grouping_mark = "'")) #123456789

#11.3.2 STRINGS (parsing strings)
#not really straight forward.
#look at raw hex values for char with charToRaw()
charToRaw("Hadley")
#rear default encoding is UTF-8
#some data cannot be understood by UTF-8
x1 <- "El Ni\xf1o was particularly bad this year"
x1
parse_character(x1, locale = locale(encoding = "Latin1"))
#usually encoding is in the documentation, but what if you can't find it?
#use guess_encoding()
guess_encoding(charToRaw(x1))
normal <- "this is a normal sentence"
guess_encoding(charToRaw(normal))

#a FACTOR is a set of categorical variables that has a known set of possible values
fruit <- c("apple", "banana")
parse_factor(c("apple", "banana", "banananana"), levels = fruit)
#banananana is not in fruit, so it throws an error

#11.3.4 DATES and DATE-TIMES and TIMES
#parse_datetime() expects ISO-8601
parse_datetime("2010-10-01T2010")
parse_datetime("20101010") # if no time, time is set to midnight
parse_datetime("2010-10-10")

#parse_date() expects 4 digit year [- or /], month, [- or /], then day
parse_date("2010-10-01")

#parse_time() expects hour : minute : second (optionally) am/pm (optionally)
library(hms)
parse_time("01:10 am")
parse_time("2:45 pm")
parse_time("20:10:00")

#format can be supplied
parse_date("01/02/15", "%m/%d/%y") #January, 2nd 2015
parse_date("01/02/15", "%d/%m/%y") #February, 1st 2015
parse_date("01/02/15", "%y/%m/%d") #February 15th, 2001

# %Y = 4 digit year (2010)
# %y = 2 digit year (00 - 69 = 2000 to 2069; 70-99 = 1970 - 1999)
# %m = 2 digit month
# %b = abbev. name Jan, Feb, Mar, ...
# %B = full name January, February, ... can also be used with other languages
# %d = 2 digit day
# %e = optional leading space
# %H = hour (military time)
# %I = 0-12 hour, needs to be used with %p
# %p = AM/PM indicator
# %M = minutes
# %S = integer seconds
# %OS = real seconds
# %Z = Time Zone
# %z = offset from UTC, e.g. +0800
# %. = skips one non-digit char
# %* = skips any number of non-digits


#11.3.5 EXERCISES
#1 - most important arguments to locale()?
?locale()
  #decimal_mark = 
  #grouping_mark = 
  #encoding = 

#2 - what happens if decimal_mark = grouping_mark?
parse_number("123,123,123,123", locale = locale(grouping_mark = ",", decimal_mark = ","))
#throws error if decimal_mark and grouping_mark are different

#3 - what do options date_format and time_format do in locale()?

#5 - read_csv() reads comma sep variables, read_csv2() reads semicolon sep variables

#6 - most common encodings in EU? Asia?
  #Europe - ISO-8859 / ISO-8859-1

#7 - parse the following date times
d1 <- "January 1, 2010"
parse_date(d1, format = "%B %d, %Y")
d2 <- "2015-Mar-07"
parse_date(d2, format = "%Y-%b-%d")
d3 <- "06-Jun-2017"
parse_date(d3, format = "%d-%b-%Y")
d4 <- c("August 19 (2015)", "July 1 (2015)")
parse_date(d4, format = "%B %d (%Y)")
d5 <- "12/30/14" # Dec 30, 2014
parse_date(d5, format = "%m/%d/%y")
t1 <- "1705"
parse_time(t1, format = "%H%M")
t2 <- "11:15:10.12 PM"
parse_time(t2, format = "%I:%M:%OS %p")

#11.4.1 PARSING STRATEGY
#guess_parser() if you don't know which parser to use
guess_parser("2010-10-10") # date
guess_parser("15:01") # time
guess_parser(c(TRUE, FALSE)) # logical
guess_parser(c("1","5","6")) # double
guess_parser(c("2,234,234")) # number

challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)

challenge

# every parse_*() function has a corresponding col_*() function
# parse_*() is used when the data is a character vector
# col_*() is used when you want to tell readr how to load the data
# I assume all of the 

#11.5 WRITING TO FILE
# ALWAYS ENCODE STRINGS IN UTF-8
# ALWAYS SAVE DATES AS ISO-8061 (YYYY-MM-DD)

# use write_excel_csv() if exporting to Excel csv.
# It writes a special char at the begninng to tell it its in UTF-8

write_csv(challenge, "challenge.csv") # data.frame to save, filepath

# if written then read back in, it loses any pasrsing designations that were modified

# to get around this, use write_rds() and read_rds()

write_rds(challenge, "challenge.rds")
read_rds("challenge.rds")

readxl() #reads in .xls and .xlsx files

#-------------------------------------------------------------------
#CHAPTER 12 - TIDY DATA

# 3 rules make a tidy dataset
  # 1 - each variable must have its own column
  # 2 - each observation must have its own row
  # 3 - each value must have its own cell

# how to fix a variable spread across multiple columns,
# or an observation spread across multiple rows
# using pivot_longer()
# and pivot_wider()

table4a <- tribble(
  ~country, ~`1999`, ~`2000`,
  "Afghanistan", 745, 2666,
  "Brazil", 37737, 80488,
  "China", 212258, 213766
)
table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

#Tidy the tibble below
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes", NA, 10,
  "no", 20, 12
)

preg %>% 
  pivot_longer(
             cols = c(male, female), 
             names_to = "gender", 
             values_to = "count",
             values_drop_na = TRUE)

#12.4.1 SEPARATE
# how to separate one column into multiple columns
table3 <- tribble(
  ~country, ~year, ~rate,
  "Afg", 1999, "765/123456",
  "Afg", 2000, "2666/3729758",
  "Bra", 1999, "37737/34567245",
  "Bra", 2000, "80488/5434454",
  "Chn", 1999, "211211/399543049",
  "Chn", 2000, "455434/562465434"
)

table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)

table5 <- table3 %>% 
  separate(year, into = c("century", "year"), sep = 1, convert = TRUE)

#12.4.2 UNITE
# the opposite of separate()

table5
table5 %>% 
  unite(new_var, country, year, sep = "")

#12.5 MISSING VALUES

# explicit vs implicit missing values
# explicit is in the data as NA
# implicit is not in the data at all

# the function complete() is useful for making implicit missing values explicit

# sometimes a NA means the previous value. for example:
treatment <- tribble(
  ~person, ~treatment, ~response,
  "Kyle", 1, 7,
  NA, 2, 10,
  NA, 3, 9,
  "Anna", 1, 4
)

treatment %>% 
  fill(person) #fills NA values with value above it.

#12.6 CASE STUDY

who #dataset of TB cases broken down by year, county, age, gender, diagnoso method

who2 <- who %>% 
  pivot_longer(
    cols = c(-country, -iso2, -iso3, -year),
    names_to = "key",
    values_to = "cases",
    values_drop_na = TRUE
  )


who3 <- who2 %>% 
  mutate(names_from = stringr::str_replace(key, "newrel", "new_rel")) %>% 
  separate(key, c("new", "type", "sexage"), sep = "_") %>% 
  separate(sexage, c("sex", "agegroup"), sep = 1) %>% 
  select(-new, -iso2, -iso3)

who3 %>% 
  group_by(sex) %>% 
  count()

who3 %>% 
  group_by(country, year, sex)


# CHAPTER 13 RELATIONAL DATA
# Relational data means multiple tables of data. How do we combine data spanning multiple datasets?
# Relations are always defined as a pair of tables

# Three families of "verbs"
# Mutating joins
  # add new variable from one data frame from a matching observation from another
# Filtering joins
  # filter observations in one data frame based on the data in another data frame
# Set operations
  # treat observations as if they were set elements (What does this mean?)

# RDBMS = Relational DataBase Management System

# Explore the nycflights13 dataset

library(tidyverse)
library(nycflights13)
# nycflights contains 4 tibbles related to flights:
airlines # defines the airlines from the 2-letter idendifiers in `flights`
airports # contains data for airports by 3-digit FAA name (name, lat, lon, altitude, timezone)
planes # info about each plane identified in flights$tailnum
weather # weather at each NYC airport for each hour for the whole year :O

weather %>% 
  arrange(desc(wind_speed))

#13.2.1 Exercises
#1 - How to draw routes between each origin and dest? What vars needed? 
    # airport locations (lat, lon), origin, dest
#2 - what is the relationship between weather and airports? in diagram?
    # arrow from origin to faa
#3 - this would contain a relationship between dest. Probably have a variable
    # called "location" rather than "origin"
#4 - data frame of special days. Year, month, day, holiday(?)

#13.3 KEYS
# Primary Keys
    # uniquely identifies an object in its own table
    # planes$tailnum = identifies each plane in the planes table
planes %>% 
  count(tailnum) %>% 
  filter(n > 1) # this returns a list of 0 because each tailnum identifies 1 observation

# Foreign Keys
    # uniquely identifies an observation in another table. Flights$tailnum.
    # multiple flights can have the same tailnum. Tailnum alone does not identify a single observation
    # 
flights %>% 
  count(tailnum) %>% 
  filter(n > 1) # this returns a table with many rows, because multiple flights can have the same tailnum

# How to get the primary keys for weather?
weather %>% 
  count(year, month, day, hour, origin) %>% 
  filter(n > 1) # this surprisingly is not unique. There are 3 observations which have the same of the variables

# what is the primary key in the flights table?
flights %>% 
  filter(!is.na(dep_time)) %>% 
  count(year, month, day, dep_time, tailnum) %>% 
  filter(n > 1)

# sometimes its useful to add a surrogate key by performing
id_flights <- flights %>%
  arrange(year, month, day, sched_dep_time, tailnum) %>% 
  mutate(
    id = row_number()
  )

#13.3.1 Exercises
#1 - add a suggogate key to flights (already did above in id_flights)
#2 - identify keys in the following datasets:

Lahman::Batting %>% glimpse()
Lahman::Batting %>% 
  count(playerID, yearID, stint, teamID) %>% 
  filter(n > 1)
  #reason: players play over multiple years, can play for different teams in one year, can play for the same team "twice" in the same year (stint)

install.packages("babynames")
babynames::babynames %>% glimpse() # 1924655 observations
babynames::babynames %>% 
  count(name, year, sex) %>% 
  filter(n > 1)

install.packages("nasaweather")
nasaweather::atmos %>% glimpse() # 41472 observations
nasaweather::atmos %>% 
  count(lat, long, year, month) %>% 
  filter(n > 1)

install.packages("fueleconomy")
fueleconomy::vehicles %>% glimpse() # 33442 observations
fueleconomy::vehicles %>% 
  count(id) %>% 
  filter(n > 1) # already has id number

diamonds %>% glimpse()
# for this, I dont think there is a primary key, we have to add one
diamonds3 <- diamonds %>% 
  mutate(
    id = row_number()
  )
diamonds3

#13.4 Mutating Joins
# how to combine data from two tables
# join based on key, which is why primary keys are so important

# first matches observations by their key
# then copies across variables from one tabel to the other

# the join() functions add variables to the right, just like mutate()

library(nycflights13)
# simple dataset for practice
flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

# add full airline name to flights2
# data is in airlines
airlines
flights2 %>% 
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")

# could have also performed like this:
flights2 %>% 
  select(-origin, -dest) %>% 
  mutate(
    name = airlines$name[match(carrier, airlines$carrier)] # harder to interpret
  )

# 13.4.1 Understanding Joins
# example tibbles
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

# a join is a way of connecting each row in x to 0, 1, or many rows in y

# 13.4.2 Inner Join
# the simples join in the inner join
# matches pairs of observations when the keys are equal ==

# unmatched rows are not included in the result
# usually not appropriate for use in analysis because its easy to lose observations
x %>% 
  inner_join(y, by = "key")

# 13.4.3 Outer Joins
# includes left_join(), right_join(), and full_join()

# left_join() keeps all observations in x
# right_join() keeps all observations in y
# full_join() keeps all observations in both x and y
# if 

# default join is the left_join().
# you want to add additional data from another table, and want to keep all original observations

x %>% 
  left_join(y, by = "key")

x %>% 
  right_join(y, by = "key")

x %>% 
  full_join(y, by = "key")

flights2 %>% 
  left_join(airlines, by = "carrier")

# 13.4.4 Duplicate Keys
# sometimes tables will have duplicate keys

# x has two keys for the number 2
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  4, "x4"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  )

# simply adds the value of val_y to x based on the value of val_x
left_join(x, y, by = "key")

# what if both tables have duplicate keys?
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  4, "x4"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  2, "y3",
  4, "y4"
)

# gives all possible combinations
left_join(x, y, by = "key")

# 13.4.5 Defining the Key Columns
# using other variable encoded for "by = "

# the default by = NULL uses all variable that appear in both tables
# here is uses year, month, day, hour, origin
# called a "natural join"
flights2 %>% 
  left_join(weather)

# using a character vector
# flights and planes have a variable called year, but they mean different things
# so by = NULL would not be appropriate here
flights2 %>% 
  left_join(planes, by = "tailnum")
# if there are common variables, it adds a .<tablename> to the common var
# see the year variable. it is year.x and year.y

# if the common variables don't have the same name
# flights$dest can be matched with airports$faa
flights2 %>% 
  left_join(airports, by = c("dest" = "faa"))

flights2 %>% 
  left_join(airports, by = c("origin" = "faa"))

# 13.4.6 Exercises
#1 - compute the average delay by destination the join on the airports data frame

mean_delay_by_dest <- flights %>% 
  group_by(dest) %>% 
  summarise(
    ave_delay = mean(arr_delay, na.rm = TRUE)
  )

# adds airport data to modified flights table
mean_delay_by_dest %>% #modified from flights
  left_join(airports, by = c(dest = "faa"))

# adds mean_delay_by_dest data to airports
# all airport codes are represented here, so many airports will not have ave_delay
# because they dont receieve flights from NYC
airports %>% 
  left_join(mean_delay_by_dest, by = c(faa = "dest"))


mean_delay_by_dest %>% 
  left_join(airports, by = c(dest = "faa")) %>% 
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point(aes(color = ave_delay)) +
  scale_color_gradient(low = "green", high = "red") +
  coord_quickmap()

airports %>% 
  semi_join(mean_delay_by_dest, c("faa" = "dest")) %>% 
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

airports %>% 
  semi_join(flights, c("faa" = "dest")) %>% 
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() + 
  coord_quickmap()

#2 - add location (lat, lon) for origin and dest for flights

airport_locations <- airports %>% 
  select(faa, lat, lon)

flights %>% 
  left_join(airport_locations, by = c(dest = "faa")) %>% 
  left_join(airport_locations, by = c(origin = "faa")) %>% 
  mutate(
    test = sqrt((lat.x - lat.y)^2 + (lon.x - lon.y)^2)
  ) %>% 
  print(width = Inf)

#3 - is there a relationship between the age of a plane and its delay

plane_ages <- planes %>% 
  select(tailnum, year)

flights %>% 
  left_join(plane_ages, by = "tailnum") %>%
  # group_by(year.y) %>% 
  # summarise(
  #   mean_delay_by_plane_age = mean(arr_delay, na.rm = TRUE)
  # ) %>% 
  ggplot(aes(year.y, arr_delay, group = year.y)) + 
  geom_boxplot(outlier.alpha = 0.1)

#4 - what weather conditions make it more likely to see a delay?
weather
# precip vs dep_delay
flights %>% 
  left_join(weather, by = "time_hour") %>% 
  group_by(precip) %>% 
  summarise(
    delay = mean(dep_delay, na.rm = TRUE),
    n = n()
  ) %>% 
  print(n = 60)
# ggplot(aes(precip, delay)) + 
  # geom_point()

# wind_dir vs arr_delay
flights %>% 
  left_join(weather, by = "time_hour") %>% 
  ggplot(aes(wind_dir, arr_delay)) + 
  geom_point()

# temp vs dep_delay
flights %>% 
  left_join(weather, by = "time_hour") %>% 
  ggplot(aes(temp, dep_delay)) + 
  geom_point()

# dewp vs dep_delay
flights %>% 
  left_join(weather, by = "time_hour") %>% 
  ggplot(aes(dewp, dep_delay)) + 
  geom_point() + 
  geom_smooth()


#4 - what happened on June 13, 2013?
# average dep_delay was 45.8 min
# average arr_delay was 63.8 min
flights %>% 
  filter(year == 2013, month == 6, day == 13) %>% 
  summarise(
    delay = mean(dep_delay, na.rm = TRUE),
    delayarr = mean(arr_delay, na.rm = TRUE)
  )

# 13.5 Filtering Joins
# how to use semi_join() and anti_join()

# semi_join(x, y) keeps all observations in x that have a match in y
# anti_join(x, y) drops all observations in x that have a match in y

# returns top 10 destinations
top_dest <- flights %>% 
  count(dest, sort = TRUE) %>% 
  head(10)
# find each flight that went to one of those destinations
flights %>% 
  filter(dest %in% top_dest$dest)
# gets complicated with multiple variables
flights %>% 
  semi_join(top_dest) # keeps observations in flights that match a dest in top_dest

flights %>% 
  anti_join(top_dest) # removes top destinations from flights dataset

# anti joins useful for dianosing mismatches
# many flights don't have a match in planes
absent_planes <- flights %>% 
  anti_join(planes, by = "tailnum") %>% 
  count(tailnum, sort = TRUE) # 722 planes not in planes dataset

flights %>% 
  semi_join(absent_planes, by = "tailnum") %>%
  count(carrier, sort = TRUE)


#2 - Filter flights to only show flights with the planes that have flown at least 100 flights
freq_flyers <- flights %>% 
  count(tailnum, sort = TRUE) %>% 
  filter(!is.na(tailnum), n >= 100)

flights %>% 
  semi_join(freq_flyers, by = "tailnum") %>% 
  count(tailnum) %>% 
  tail() # confirms that we are sorting out flights with fewer than 100 flights

#3 - combine fueleconomy::vehicles and fueleconomy::common to fine only
# the records for the most common models

fueleconomy::vehicles
fueleconomy::common

fueleconomy::vehicles %>% 
  semi_join(fueleconomy::common, by = c("make", "model"))

#4 - ambiguous question...

#5 - what does this tell you?
flights %>% 
  anti_join(airports, by = c("dest" = "faa")) #flights not in the faa records? International flights?

# what about
airports %>% 
  anti_join(flights, by = c("faa" = "dest")) # airports not flown to from NYC

# 13.6 Join Problems
# How to go about making joins run smoothly

# Identify variables that form the primary key.
# Do this by understanding the data, no arbitrarily choosing randon vars

# Make sure all vars in the primary key do not contian NAs

# make sure all foreign keys match primary keys (can check with anti_join())


# 13.7 Set Operations
# not used as frequently, but can be used to break a complex file into simple pieces
# interesct(x, y) returns observations in both x and y
# union(x, y) returns unique observations in x and y
# setdiff(x, y) returns observations in x, but not y

df1 <- tribble(
  ~x, ~y,
  1, 1,
  2, 1
)

df2 <- tribble(
  ~x, ~y,
  1, 1,
  1, 2
)

intersect(df1, df2)

union(df1, df2)

setdiff(df1, df2)

# -----------------------------------------------------------------
# Chapter 14 - Strings
# focus of chapter is on regular expressions
# uses the stringr package in the tidyverse
library(tidyverse)

# 14.2 String Basics
string1 <- "this is a string"
string2 <- 'to include a "quote" in a string, use single quotes'

# to include a single or double quote in a string, use a \ to back it up
double_quote <- "\""
single_quote <- '\''
singlebackslash <- "\\"

writeLines(double_quote)
writeLines(single_quote)
writeLines(singlebackslash)

newline <- "\nplaceholder"
tab <- "\tplaceholder"

writeLines(newline)
writeLines(tab)

x <- "kyle"
y <- "helzer"
str_length(x) # gets length of string
str_c(x,y) # concatenates strings together
str_c(x,y, sep = " ") # can add a separater char

# dealing with NAs
z <- c("abc", NA) 
str_c("|-", z, "-|") # when an NA is present, it make the whole string NA
str_c("|-", str_replace_na(z), "-|") # this literally puts "NA" in as a string

# putting in a vector to str_c returns a vector
str_c("prefix-", c("a", "b", "c"), "-suffix")

# strings with length 0 are silenty dropped
str_c("a", "b", "c", if(FALSE) "d", "e") # drops d,

# str_c() can collapse a vector of strings into one stirng
# use collapse = to set separator
str_c(c("a", "b", "c"), collapse = ",")

# 14.2.3 Subsetting strings
z <- c("apple", "banana", "pear")
str_sub(z, 1, 3) # chars 1 - 3 (inclusive)
str_sub(z, -3, -1) # negative numbers count backwards from the end
str_sub(z, 3, 1) # if range is incorrectly entered, returns blank "" (not NA)
str_sub(z, 3, 10) # if range extends past length, it returns as much as possible
str_sub(z, 1, 1) <- str_to_lower(str_sub(z, 1, 1)) # somehow this works
z

# str_to_lower() makes lowercase
# str_to_upper() makes uppercase
# str_to_title() makes first letter uppercase

# 14.2.4 Locales
# locale is specified by the ISO 639 language code (2 or 3 letter abbrev)
# this can affect sorting, as different alphabets sort differently
x <- c("apple", "eggplant", "banana")
str_sort(x) # default is english
str_sort(x, locale = "haw") #Hawaiian

# 14.2.5 Exercises
#1 - different between paste() and paste0()
?paste() # concatenate strings. Adds space between strings by default
?paste0() # eqivalent to paste(..., sep = "", collapse). No space between strings

#2 - sep takes the multiple values passed into str_c
    # collapse takes in a vector

#3 - 
middle_char <- function(x){
  mid <- floor((str_length(x)/2) + 1)
  z <- str_sub(x, mid, mid)
  return(z)
}
middle_char("abc")
middle_char("aaaaataaaaa")
middle_char("abc12def")

#4 - what does str_wrap() do?
?str_wrap() # Wraps strings into nicely formatted paragraphs
# used in print statements? Useful for long strings that need to be typeset

#5 - what does str_trim() do?
?str_trim() # trims whitespace from a string. can specify the side (left, right, both)
?str_squish() # reduces whitespace inside of a string
?str_pad() # opposide of str_trim(). adds padding to string. Can add 

str_pad(c("aaa", "bbb", "ccc"), 10, pad = "-", side = "both")

# 14.3 Matching patterns with regular expressions

# for describing patterns in strings

# simples is patterns that match exact strings

x <- c('apple', 'banana', 'pear')

str_view(x, 'an')
str_view(x, '.a.') # . matches any char
# how do we represent a dot?
dot <- '\\.'
writeLines(dot)

str_view(c('abc', 'a.c', 'bef'), 'a\\.c')

# in \\. the \. will escape the . as a match-all, then the \ escapes the \ as an escape char

# in \\\\ it can be broken down into (\\)(\\) with each escaping the escape to make (\)(\)
# this then creates just \

str_view('a\\b', '\\\\') # searches for \
  
# 14.3.2 Anchors

# ^ matches the start of a string
# $ matches the end of a string

str_view(x, "^a") #matches the start of 'apple'

# side note, "^>" will find the start of a fasta file (id line)

str_view(x, "a$") # matches with the end of banana

# use to find exact matches to a compete string

x <- c('apple pie', 'apple', 'apple cake')
str_view(x, "^apple$") # only matches apple

# 14.3.2.1 Exercises
#1 - how to match "$^$"

x <- c("$^$", "$$$", "^^^", "^$^", "$", '^')

str_view(x, "^\\$\\^\\$")

str_detect() #returns a boolean vector for each word in the input
str_detect(c('apple', 'banana', 'orange'), "g") # FALSE FALSE TRUE

# 14.3.3 Character classes and alternatives

# \d - matches any digit
# \s - matches any whitespace
# [abc] - matches a, b, or c
# [^abc] - matches anything except a, b, or c

# to put in a regexp, you need the escape char, so type \\d or \\s

# can also use brackets [] to match something that requires an escape char
# i.e. instead of \\. do [.]

str_detect(c("abc","a/c","a.c","a*c"), "a[.]c") # F F T F
str_detect(c("abc","a/c","a.c","a*c"), "a[*]c") # F F F T
str_detect(c("abc","a/c","a.c","a*c"), "a[/]c") # F T F F

# does not work with ] \ ^ -

# useful to use parens when using mathmatical expressions

str_detect(c("gray", "grey"), "gr(e|a)y") # T T
str_detect(c('gray', 'grey'), "gr[ea]y") # T T

# starts with a vowel
str_detect(c('as','es','os','is','us','ys'), "^[aeiou]") # T T T T T F
# only consonants
str_detect(c('as','es','os','is','us','ys'), "^[^aeiou]") # F F F F F T

# build df of words
word_df <- tibble(
  word = words,
  i = seq_along(word)
)

# words that end in x
word_df %>% 
  filter(str_detect(word, "x$"))

# there are no words in this list where q is not followed by a u
word_df %>% 
  filter(str_detect(word, "q[^u]"))

# ends in "ing" or "ise"
word_df %>% 
  filter(str_detect(word, "(ing|ise)$"))

# ends in "ed" but not in "eed"
word_df %>% 
  filter(str_detect(word, "[^e]ed$"))

# ends in just "ed"
word_df %>% 
  filter(str_detect(word, "ed$"))

# things that dont follow I before E except after C
word_df %>% 
  filter(str_detect(word, "cie"))

# 14.3.4 Repetition

# how many times a pattern matches:
# ? - 0 or 1
# + - 1 or more
# * - 0 or more
# {n} exactly n
# {n,} n or more
# {,m} at most m
# {n,m} between n and m

# this is useful if there is a long stretch of a certain letter you are looking for
# for example, in DNA, a string of 20 Gs
# would be "G{20}" instead of "GGGGGGGGGGGGGGGGGGGG"

x <- "1888 is the longest year in Roman numerals: MDCCCLXXVIII"

str_detect(x, "I{3}") # matches III

fruit <- c("banana", "coconut", "cucumber", "jujube", "papaya", "apple")

str_detect(fruit, "(..)\\1", match = TRUE) #doesn't work?

str_count() # find how many instances of the pattern occur in each word

str_count(c("apple", "banana", "pear"), "a") # 1 3 1

# build df of words
word_df <- tibble(
  word = words,
  i = seq_along(word)
)

# used with mutate 
word_df %>% 
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )

# 14.4.2 Extract Matches
# this will return the actual text of a match

# Harvard sentences stored in stringr::sentences
sentences
length(sentences) # 720 sentences
head(sentences)

# find sentences that contain a certain color
colors <- c("red", "oragne", "yellow", "green", "blue", "purple")
color_match <- str_c(colors, collapse = "|") # build regular expression
has_color <- str_subset(sentences, color_match)
matches <- str_extract(has_color, color_match) # this will only extract the first match (i.e. if two colors are in one sentence, it only returns the first)
head(matches)
str_extract_all(has_color, color_match) # returns all matches

# 14.3.3 Grouped Matches

noun <- "(a|the) ([^ ]+)"
has_noun <- sentences %>% 
  str_subset(noun) %>% 
  head(10)
has_noun %>% 
  str_extract(noun)

has_noun %>% 
  str_match(noun)

# 14.4.4 Replacing Matches
# str_replace() and str_replace_all() replace matches with new strings

x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-") # only replaces first hit
str_replace_all(x, "[aeiou]", "-") # replaces all hits

# can also perform multiple replacements
x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))

# 14.4.5 Splitting
# Use str_split() to split up a string into pieces

sentences %>% 
  head(5) %>% 
  str_split(" ") # returns a list

sentences %>% 
  head(5) %>% 
  str_split(" ", simplify = TRUE) # returns a matrix

sentences %>% 
  head(5) %>% 
  str_split(" ", n = 3, simplify = TRUE) # n denotes the max number of pieces. If more are presence, they are put in the last one

x <- "This is a sentence. This is another sentence."
str_split(x, boundary("word"))
str_split(x, boundary("character"))
str_split(x, boundary("line")) # includes whitespace after word
str_split(x, boundary("sentence")) # includes space after period

# 14.5 Other types of patterns

# the second part of all of these function calls regex()
bananas <- c("banana", "Banana", "BANANA")
# this
str_detect(bananas, "banana") # T F F 
# is the same as this
str_detect(bananas, regex("banana")) # T F F

# can use to ignore case
str_detect(bananas, regex("banana", ignore_case = TRUE)) # T T T

# in regex(), using comments = TRUE allows you to put in comments
phone <- regex("
               \\(?     # optional opening parens
               (\\d{3}) # area code
               [) -]?   # optional closing parens, space, or dash
               (\\d{3}) # another three numbers
               [ -]?    # optional space or dash
               (\\d{4})  # three more numbers
               ", comments = TRUE)
phone
str_match("514-791-8141", phone)

# multiline = TRUE treats each new line as a new string rather than a continuation of the whole string
# dotall = TRUE allows . to match everything including \n
# fixed() matches exactly the specificed sequence of bytes, runs faster than regex
  # this does have some drawbacks with non-English data, as accented letters can have two different byte codes

# 14.6 Other uses of regex

# built in apropos() function will search all objects available in the global env
apropos("replace")

# dir() is the list of all files in the directory.
# It can take an argument pattern = as a regex to match file names
dir(pattern = "\\.Rmd$") # finds all R markdown files

# 14.7 stringi

# stringr is built off of stringi, which is more comprehensive than stringr
# all functions are similar, str_ vs stri_

# ----------------------------------------------------------------------------
# Chapter 15 - FACTORS
# Factors are used to work with categorical variables which have a fixed and known set of possible values
# Useful for when there is a limited number of variables and they need to be sorted in a certain way
# package for factors is called forcats::

# months are a good example
x1 <- c("Dec", "Jan", "Apr", "Mar")
x2 <- c("Dec", "Jam", "Apr", "Mar") # contains a typo
sort(x1) # not useful
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

# create a factor
y1 <- factor(x1, levels = month_levels)
y1
sort(y1) # much more useful

y2 <- factor(x2, levels = month_levels) # throws error? Book say it should replace typo with NA

factor(x1) # if levels omitted, variable are put in alphabetical order

f1 <- factor(x1, levels = unique(x1)) # makes the levels as the appear in the data

# to get juts the levels use levels()
levels(y1)

# 15.3 General Social Survey
gss_cat
?gss_cat # sample of categorical variables from the General Social survey

# When stored in a tibble, levels can't be seen so easily. One way is to use count()
gss_cat %>% 
  count(race) # White Black Other

ggplot(gss_cat, aes(race)) + 
  geom_bar()

# Note: levels that have no values are dropped.
# To force them to be displayed:

ggplot(gss_cat, aes(race)) + 
  geom_bar() +
  scale_x_discrete(drop = FALSE) # "Not applicable" appears now

# 15.3.1 Exercises
# 1 - Explore the disctribution of rincome (reported income)
gss_cat %>% 
  count(rincome)

ggplot(gss_cat, aes(rincome)) + 
  geom_bar() + 
  theme(
    axis.text.x = element_text(angle = 90)
  )

ggplot(gss_cat, aes(rincome)) + 
  geom_bar() + 
  coord_flip() # Why so many rich people?

levels(gss_cat$rincome)

# 2 - What is the most common relig in this survey? What about party id?
gss_cat %>% 
  count(relig, sort = TRUE) # Top 3: Protestant, Cathloic, None

gss_cat %>% 
  count(partyid, sort = TRUE) # Independent

gss_cat %>% 
  count(denom, sort = TRUE)

# 15.4 Modifying Factor Order
# Its often useful to change the order of the factor levels in a visualization

# Examine average number of hours spent watching TV per day by religion
relig_summary <- gss_cat %>% 
  group_by(relig) %>% 
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

ggplot(relig_summary, aes(tvhours, relig)) +
  geom_point() # difficult to interpret

# use fct_reorder() to reorder the factors
# fct_reorder() takes 3 arguments
# f - the factor whose levels you want to modify
# x - a numeric vector that you want to use to reorder the levels
# (optional) fun - a function that's used if there are multiple values of x for each value of f. Default is Median

ggplot(relig_summary, aes(tvhours, fct_reorder(relig, tvhours))) + 
  geom_point()

# better to move the fct_reorder() out of aes() like so:
relig_summary %>% 
  mutate(
    relig = fct_reorder(relig, tvhours) # reorders relig by # of tvhours
  ) %>% 
  ggplot(aes(tvhours, relig)) + 
    geom_point()

# to reverse order use fct_rev()
relig_summary %>% 
  mutate(
    relig = fct_rev(fct_reorder(relig, tvhours)) # reorders relig by # of tvhours
  ) %>% 
  ggplot(aes(tvhours, relig)) + 
  geom_point()

# look at age varies across reported income levels
rincome_summary <- gss_cat %>% 
  group_by(rincome) %>% 
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  ) %>% 
ggplot(rincome_summary, aes(age, fct_reorder(rincome, age))) + 
  geom_point()
# this doesn't make sense because income levels are already ordered in a meaningful way
# ordering by age makes it difficult to interpret
# however, it does makes sense to put "Not applicable" to the front with other special levels
# use fct_relevel() to move specific levels to the front of the line

ggplot(rincome_summary, aes(age, fct_relevel(rincome, "Not applicable"))) + 
  geom_point()
# Not applicable age is so high because retirees have no income

# line up lines graph colors with legend
by_age <- gss_cat %>% 
  filter(!is.na(age)) %>% 
  count(age, marital) %>% 
  group_by(age) %>% 
  mutate(prop = n / sum(n))

ggplot(by_age, aes(age, prop, color = marital)) + 
  geom_line(na.rm = TRUE) # hard to interpret because key does not match ordering in graph

ggplot(by_age, aes(age, prop, color = fct_reorder2(marital, age, prop))) + 
  geom_line() + 
  labs(color = "marital")

# use fct_infreq() to order levels in a bar plot
gss_cat %>% 
  mutate(
    marital = marital %>% fct_infreq() %>% fct_rev() # use with fct_rev() to reverse ordering
  ) %>% 
  ggplot(aes(marital)) + 
  geom_bar()

# 15.5 Modifying Factor Levels
# Changing the values of levels
# use fct_recode()

gss_cat %>% 
  count(partyid) # levels are terse and inconsistent

gss_cat %>% 
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong" = "Strong republican",
                              "Republican, weak" = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak" = "Not str democrat",
                              "Democrat, strong" = "Strong democrat")
         ) %>% 
  count(partyid)
# leaves levels that aren't mentioned as is
# warns if a level that doesn't exist is referred to

# you can combine groups too

gss_cat %>% 
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong" = "Strong republican",
                              "Republican, weak" = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak" = "Not str democrat",
                              "Democrat, strong" = "Strong democrat",
                              "Other" = "No answer",
                              "Other" = "Don't know",
                              "Other" = "Other party")
  ) %>% 
  count(partyid)

# collapse multiple levels
gss_cat %>% 
  mutate(partyid = fct_collapse(partyid,
      other = c("No answer", "Don't know", "Other party"),
      rep = c("Strong republican", "Not str republican"),
      ind = c("Ind,near rep", "Independent", "Ind,near dem"),
      dem = c("Not str democrat", "Strong democrat")
      )) %>% 
  count(partyid)

# fct_lump() lumps together all the small groups to make a plot simpler
gss_cat %>% 
  mutate(
    relig = fct_lump(relig)
  ) %>% 
  count(relig) # in this case not very helpful
               # use n parameter to specify the number of groups you want to keep

gss_cat %>% 
  mutate(
    relig = fct_lump(relig, n = 10)
  ) %>% 
  count(relig, sort = TRUE) %>% 
  print(n = Inf)

gss_cat %>% 
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>% 
  group_by(year, partyid) %>% 
  summarise(
    n = n()
  ) %>% 
  mutate(
    freq = n / sum(n)
  ) %>% 
  ggplot(aes(year, freq, color = fct_reorder2(partyid, year, freq))) + 
  geom_line() + 
  labs(color = "Party ID")

#----------------------------------------------------------------------------------
# Chapter 16 DATES AND TIMES
# the package lubridate is made for working with dates and times
# will use nycflights13 for practice
library(tidyverse)
library(lubridate)
library(nycflights13)

# Three types of data/time data that refers to an instant in time
# Date - <date>
# Time - <time>
# Date-time - <dttm> --> these are called POSIXct elsewhere in R

# Use the simplest possible type of data that works for you
# use date instead of date-time if you can

# current date
today() # 2020-06-23 is a <date>
now() # 2020-06-23 15:21:11 CDT is a <dttm>

# 16.2.1 Making a date from a string
# many lubridate functions to do this
ymd("2017-01-31") # year month day
mdy("January 31st, 2017") # month day year
dmy("31-Jan-2017") # day month year

# also can take unquoted numbers
ymd(20170131) # returns 2017-01-31

# to create a datetime, add _ and hm or hms
ymd_hms("2017-01-31 20:11:59")
mdy_hm("01/31/2017 08:01")

# you can force the creation of a datetime by setting a timezone with tz
ymd(20170131, tz = "UTC")

# 16.2.2 Creating date from individual components
# sometimes year, month, day, etc... will be stored as different data points in a df
flights %>% 
  select(year, month, day, hour, minute)

# use make_date() or make_datetime() to create dates or datetimes
flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(
    departure = make_datetime(year, month, day, hour, minute)
  )
