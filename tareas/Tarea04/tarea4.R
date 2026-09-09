library(nycflights13)
library(tidyverse)
install.packages("nycflights13")
install.packages("tidyverse")



## 3.2 Rows - Exercises

# 1 Find all flights that meet each condition in a single pipeline: had an arrival delay of two or more hours; flew to Houston (IAH or HOU); were operated by United, American, or Delta; departed in summer (July, August, and September); arrived more than two hours late but did not leave late; and were delayed by at least an hour but made up over 30 minutes in flight.

flights |> 
  filter(arr_delay >= 120,
         dest %in% c("IAH", "HOU"),
         carrier %in% c("UA", "AA", "DL"),
         month %in% c(7, 8, 9),
         arr_delay > 120 & dep_delay <= 0,
         dep_delay >= 60 & (dep_delay - arr_delay) > 30)

# 2 Sort flights to find the flights with the longest departure delays. Find the flights that left earliest in the morning.

flights |>
  arrange(desc(dep_delay))

flights |>
  arrange(dep_delay)

# 3 Sort flights to find the fastest flights. (Hint: Try including a math calculation inside your function.)

flights |>
  arrange((air_time / distance))

# 4 Was there a flight on every day of 2013?
flights |>
  count(year, month, day) |>
  filter(n == 0)

# 5 Which flights traveled the farthest distance? Which traveled the least distance?
flights |>
  arrange(desc(distance))

flights |>
  arrange(distance)

# 6 Does it matter what order you use filter() and arrange() if you are using both? Why or why not? Think about the results and how much work the functions would have to do.

# Esto generalmente no importa, aunque debe afectar la eficiencia del calculo ya que si filtro es mejor hacerlo en un principio.

## 3.3 Columns - Exercises

# 1 Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?

# 2 Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.

# 3 What happens if you specify the name of the same variable multiple times in a select() call?

# 4 What does the any_of() function do? Why might it be helpful in conjunction with this vector: variables <- c("year", "month", "day", "dep_delay", "arr_delay")?

# 5 Does the result of running flights |> select(contains("TIME")) surprise you? How do the select helpers deal with upper and lower case by default? How can you change that default?

# 6 Rename air_time to air_time_min to indicate units of measurement and move it to the beginning of the data frame.

# 7 Why does the following not work, and what does the error mean? flights |> select(tailnum) |> arrange(arr_delay)

## 3.5 Groups - Exercises

# 1 Which carrier has the worst average delays? Challenge: Can you disentangle the effects of bad airports versus bad carriers? Why or why not? (Hint: Think about flights |> group_by(carrier, dest) |> summarize(n()).)

# 2 Find the flights that are most delayed upon departure to each destination.

# 3 How do delays vary over the course of the day? Illustrate your answer with a plot.

# 4 What happens if you supply a negative n to slice_min() and related functions?

# 5 Explain what count() does in terms of the dplyr verbs you just learned. What does the sort argument to count() do?

# 6 Suppose you have the following tiny data frame. For each pipeline below, predict the output, check whether you were correct, and describe what the pipeline does.
#    df <- tibble(x = 1:5, y = c("a", "b", "a", "a", "b"), z = c("K", "K", "L", "L", "K"))
#    a. df |> group_by(y)
#    b. df |> arrange(y)
#    c. df |> group_by(y) |> summarize(mean_x = mean(x))
#    d. df |> group_by(y, z) |> summarize(mean_x = mean(x)); describe what the message says.
#    e. df |> group_by(y, z) |> summarize(mean_x = mean(x), .groups = "drop"); explain how the output differs from part d.
#    f. Compare df |> group_by(y, z) |> summarize(mean_x = mean(x)) with df |> group_by(y, z) |> mutate(mean_x = mean(x)); explain how their outputs differ.
