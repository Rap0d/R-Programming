library(dplyr)
library(ggplot2)
library(httr)
library(knitr)
library(readr)
library(tidyr)
library(leaflet)
library(stringr)
library(lintr)
getwd()

shooting_data <- read.csv("R_Script/191001_01/shootings-2018.csv", stringsAsFactors = F)
View(shooting_data)


##### Summary information #####

### Following questions
# 1. How many shootings occurred?
shootings_occurred <- nrow(shooting_data)
shootings_occurred
# 2. How many lives were lost?
shootings_lost <- sum(shooting_data$num_killed)
shootings_lost

# 3. Which city was most impacted by shootings (make sure to clarify  how you
#    are measuring "impact")?
most_impacted_city <- shooting_data %>%
  group_by(city) %>%
  summarize(sum_killed_injured = sum(num_killed) + sum(num_injured)) %>%
  arrange(-sum_killed_injured) %>%
  slice(1) %>%
  pull(city)
# This result is measured by summing up the total number of injured and lost,
# then arranged based on the total amount each obervation has.

# 4. How much are the percentages of killed and injured data from each state?
each_rated_state <- shooting_data %>%
  group_by(state) %>%
  summarize(total_deaths = sum(num_killed),
            total_injured = sum(num_injured)) %>%
  mutate(
    rate_of_deaths = paste0(round(
      (total_deaths / sum(total_deaths)) * 100, 2
    ), "%"),
    rate_of_injured = paste0(round(
      (total_injured / sum(total_injured)) * 100, 2
    ), "%")
  )

arranged_each_rated_state <- each_rated_state[, c(1, 2, 4, 3, 5)]

first_ranked_state <- each_rated_state %>%
  group_by(state) %>%
  summarize(total_num_incident = sum(total_deaths + total_injured)) %>%
  arrange(-total_num_incident) %>%
  slice(1) %>%
  pull(state)

second_ranked_state <- each_rated_state %>%
  group_by(state) %>%
  summarize(total_num_incident = sum(total_deaths + total_injured)) %>%
  arrange(-total_num_incident) %>%
  slice(2) %>%
  pull(state)

third_ranked_state <- each_rated_state %>%
  group_by(state) %>%
  summarize(total_num_incident = sum(total_deaths + total_injured)) %>%
  arrange(-total_num_incident) %>%
  slice(3) %>%
  pull(state)

# 5. How much is the rate of occurrence of gun shooting for each month?
add_month <- shooting_data %>%
  separate(date, c("dumy", "year"), sep = ",") %>%
  separate(dumy, c("month", "day"), sep = " ") %>%
  filter(year == " 2018") %>%
  mutate(year_num = as.integer(year)) %>%
  group_by(state, month, year_num) %>%
  summarize(
    sum_kill = sum(num_killed),
    sum_injury = sum(num_injured)
  )

num_montly <- add_month %>%
  group_by(month) %>%
  summarize(deaths_and_injured = sum(sum_kill) + sum(sum_injury))

arranged_num_montly <- num_montly[c(5, 4, 8, 1, 9, 7, 6, 2, 12, 11, 10, 3), ]

most_impacted_month <- arranged_num_montly %>%
  arrange(-deaths_and_injured) %>%
  slice(1) %>%
  pull(month)

most_impacted_month_num <- arranged_num_montly %>%
  arrange(-deaths_and_injured) %>%
  slice(1) %>%
  pull(deaths_and_injured)

least_impacted_month <- arranged_num_montly %>%
  arrange(+deaths_and_injured) %>%
  slice(1) %>%
  pull(month)

least_impacted_month_num <- arranged_num_montly %>%
  arrange(+deaths_and_injured) %>%
  slice(1) %>%
  pull(deaths_and_injured)

##### Summary table #####
summary_table <- kable(arranged_each_rated_state)

##### Discription of particular incident #####
sunny_side <- shooting_data %>%
  filter(city == "Sunnyside")

num_sun_killed <- sunny_side %>%
  pull(num_killed)

num_sun_injured <- sunny_side %>%
  pull(num_injured)

address_sunny <- sunny_side %>%
  pull(address)

date_sunny <- sunny_side %>%
  pull(date)



##### An interactive map #####
interactive_map <- leaflet(data = shooting_data) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -100, lat = 30, zoom = 3) %>%
  addCircleMarkers(
    lat = ~lat,
    lng = ~long,
    popup = ~ paste(
      state, "<br> The number of casualties: ", num_killed,
      "<br> The number of injured: ", num_injured
    ),
    radius = ~ num_killed + num_injured
  )

##### plot of your choice #####

bar_graph <- ggplot(data = arranged_num_montly) +
  geom_col(
    mapping = aes(x = month, y = deaths_and_injured),
    fill = "lightblue", colour = "black", width = 1
  ) +
  labs(title = "Statistics of gun shootings for each month in 2018")
bar_graph