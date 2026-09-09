library(nycflights13)
library(tidyverse)
# install.packages("nycflights13")
# install.packages("tidyverse")

####################################################################################################################
## 3.2 Rows - Exercises
####################################################################################################################

# 1 In a single pipeline for each condition, find all flights that meet the condition:
# Had an arrival delay of two or more hours

flights |>
  filter(arr_delay >= 120)

# Flew to Houston (IAH or HOU)

flights |>
  filter(dest %in% c("IAH", "HOU"))

# Were operated by United, American, or Delta

flights |>
  filter(carrier %in% c("UA", "AA", "DL"))

# Departed in summer (July, August, and September)

flights |>
  filter(month %in% c(7, 8, 9))

# Arrived more than two hours late but didn't leave late

flights |>
  filter(arr_delay > 120, dep_delay <= 0)

# Were delayed by at least an hour, but made up over 30 minutes in flight

flights |>
  filter(dep_delay >= 60, dep_delay - arr_delay > 30)

# Respuesta: Use filter() para quedarme con las filas que cumplen cada condicion.

# 2 Sort flights to find the flights with the longest departure delays. Find the flights that left earliest in the morning.

flights |>
  arrange(desc(dep_delay))

flights |>
  arrange(dep_time)

# 3 Sort flights to find the fastest flights. (Hint: Try including a math calculation inside your function.)

flights |>
  mutate(speed = distance / air_time * 60) |>
  arrange(desc(speed))

# 4 Was there a flight on every day of 2013?

flights |>
  mutate(date = as.Date(time_hour)) |>
  distinct(date) |>
  count()

# 5 Which flights traveled the farthest distance? Which traveled the least distance?
flights |>
  arrange(desc(distance))

flights |>
  arrange(distance)

# Respuesta: El primero muestra las distancias mas largas. El segundo muestra las mas cortas.

# 6 Does it matter what order you use filter() and arrange() if you are using both? Why or why not? Think about the results and how much work the functions would have to do.

# Respuesta: El resultado suele ser igual, pero conviene filtrar primero asi R ordena menos filas.

####################################################################################################################
## 3.3 Columns - Exercises
####################################################################################################################

# 1 Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?

flights |>
  select(dep_time, sched_dep_time, dep_delay)

# Respuesta: dep_time es la hora real, sched_dep_time es la hora planeada y dep_delay es el atraso.

# 2 Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.

flights |>
  select(dep_time, dep_delay, arr_time, arr_delay)

flights |>
  select(all_of(c("dep_time", "dep_delay", "arr_time", "arr_delay")))

flights |>
  select(matches("^(dep|arr)_(time|delay)$"))

# 3 What happens if you specify the name of the same variable multiple times in a select() call?

flights |>
  select(dep_time, dep_time, arr_time)

# Respuesta: R la deja una sola vez.

# 4 What does the any_of() function do? Why might it be helpful in conjunction with this vector: variables <- c("year", "month", "day", "dep_delay", "arr_delay")?

variables <- c("year", "month", "day", "dep_delay", "arr_delay")

flights |>
  select(any_of(variables))

# Respuesta: any_of() selecciona las columnas que existen.

# 5 Does the result of running flights |> select(contains("TIME")) surprise you? How do the select helpers deal with upper and lower case by default? How can you change that default?

flights |>
  select(contains("TIME"))

flights |>
  select(contains("TIME", ignore.case = FALSE))

# Respuesta: por defecto no importa si esta en mayuscula o minuscula.

# 6 Rename air_time to air_time_min to indicate units of measurement and move it to the beginning of the data frame.

flights |>
  rename(air_time_min = air_time) |>
  relocate(air_time_min)

# 7 Why doesn't the following work, and what does the error mean? flights |> select(tailnum) |> arrange(arr_delay)

# Respuesta: no funciona porque arr_delay ya no esta despues de select().

####################################################################################################################
## 3.5 Groups - Exercises
####################################################################################################################

# 1 Which carrier has the worst average delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why or why not?

flights |>
  group_by(carrier) |>
  summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE), n = n()) |>
  arrange(desc(avg_arr_delay))

flights |>
  group_by(carrier, dest) |>
  summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE), n = n()) |>
  arrange(desc(avg_arr_delay))

# 2 Find the flights that are most delayed upon departure to each destination.

flights |>
  group_by(dest) |>
  slice_max(dep_delay, n = 1, with_ties = FALSE) |>
  ungroup()

# Respuesta: agrupo por destino y me quedo con el mayor atraso.

# 3 How do delays vary over the course of the day? Illustrate your answer with a plot.

flights |>
  group_by(hour) |>
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) |>
  ggplot(aes(x = hour, y = avg_dep_delay)) +
  geom_line() +
  geom_point()

# Respuesta: los atrasos cambian segun la hora del dia.

# 4 What happens if you supply a negative n to slice_min() and related functions?

flights |>
  slice_min(dep_delay, n = -5)

# Respuesta: devuelve casi todas las filas y saca algunas del otro extremo.

# 5 Explain what count() does in terms of the dplyr verbs you just learned. What does the sort argument to count() do?

flights |>
  count(carrier)

flights |>
  count(carrier, sort = TRUE)

# Respuesta: cuenta las filas por grupo. sort = TRUE ordena de mayor a menor.

# 6 Suppose we have the following tiny data frame. For each pipeline below, predict the output, check whether you were correct, and describe what the pipeline does.

df <- tibble(x = 1:5, y = c("a", "b", "a", "a", "b"), z = c("K", "K", "L", "L", "K"))

df |> group_by(y)
# Respuesta: agrupa por y.

df |> arrange(y)
# Respuesta: ordena primero las a y despues las b.

df |> group_by(y) |> summarize(mean_x = mean(x))
# Respuesta: calcula el promedio de x para cada y.

df |> group_by(y, z) |> summarize(mean_x = mean(x))
# Respuesta: calcula el promedio por y y z y queda agrupado por y.

df |> group_by(y, z) |> summarize(mean_x = mean(x), .groups = "drop")
# Respuesta: hace lo mismo pero elimina los grupos.

df |> group_by(y, z) |> summarize(mean_x = mean(x))
df |> group_by(y, z) |> mutate(mean_x = mean(x))
# Respuesta: summarize() achica la tabla y mutate() mantiene todas las filas.

####################################################################################################################
## 19.2.4 Keys - Exercises
####################################################################################################################

# 1. We forgot to draw the relationship between weather and airports in Figure 19.1. What is the relationship and how should it appear in the diagram?

# Respuesta: faa se conecta con origin. Cada aeropuerto tiene varios datos del clima.
# airports$faa (1) --------< weather$origin (muchos)

# 2. weather only contains information for the three origin airports in NYC. If it contained weather records for all airports in the USA, what additional connection would it make to flights?

# Respuesta: se podria unir el destino con weather para saber el clima al llegar.

# 3. The year, month, day, hour, and origin variables almost form a compound key for weather, but there's one hour that has duplicate observations. Can you figure out what's special about that hour?

hora_duplicada <- weather |>
  count(year, month, day, hour, origin) |>
  filter(n > 1)

hora_duplicada

weather |>
  semi_join(hora_duplicada, join_by(year, month, day, hour, origin)) |>
  arrange(origin, time_hour)

# Respuesta: es la 1 del 3 de noviembre. Como ese dia cambio la hora, aparece dos veces.

# 4. We know that some days of the year are special and fewer people than usual fly on them (e.g., Christmas eve and Christmas day). How might you represent that data as a data frame? What would be the primary key? How would it connect to the existing data frames?

dias_especiales <- tribble(
  ~fecha, ~evento,
  as.Date("2013-12-24"), "Nochebuena",
  as.Date("2013-12-25"), "Navidad"
)

flights |>
  mutate(fecha = as.Date(time_hour)) |>
  left_join(dias_especiales, join_by(fecha))

# Respuesta: haria una tabla con fecha y evento. La clave seria fecha y se uniria con flights.

# 5. Draw a diagram illustrating the connections between the Batting, People, and Salaries data frames in the Lahman package. Draw another diagram that shows the relationship between People, Managers, AwardsManagers. How would you characterize the relationship between the Batting, Pitching, and Fielding data frames?

# Batting$playerID (muchos)  >-------- (1) People$playerID
# Salaries$playerID (muchos) >-------- (1) People$playerID
# Managers$playerID (muchos)       >--- (1) People$playerID
# AwardsManagers$playerID (muchos) >--- (1) People$playerID
# Respuesta: las tres comparten jugador y ano, pero puede haber varias filas por jugador.

####################################################################################################################
## 19.3.4 Basic joins - Exercises
####################################################################################################################

flights2 <- flights |>
  select(year, time_hour, origin, dest, tailnum, carrier)

# 1. Find the 48 hours (over the course of the whole year) that have the worst delays. Cross-reference it with the weather data. Can you see any patterns?

peores_48_horas <- flights |>
  group_by(time_hour) |>
  summarize(atraso_promedio = mean(dep_delay, na.rm = TRUE)) |>
  slice_max(atraso_promedio, n = 48) |>
  left_join(weather, join_by(time_hour))

peores_48_horas

# Respuesta: muchas de esas horas tienen mal clima, por eso puede haber mas atrasos.

# 2. Imagine you've found the top 10 most popular destinations using this code. How can you find all flights to those destinations?

top_dest <- flights2 |>
  count(dest, sort = TRUE) |>
  head(10)

flights2 |>
  semi_join(top_dest, join_by(dest))

# 3. Does every departing flight have corresponding weather data for that hour?

vuelos_sin_clima <- flights |>
  anti_join(weather, join_by(origin, time_hour))

vuelos_sin_clima |> count()

# Respuesta: no. Esta tabla muestra los vuelos sin datos del clima.

# 4. What do the tail numbers that don't have a matching record in planes have in common? (Hint: one variable explains ~90% of the problems.)

flights |>
  anti_join(planes, join_by(tailnum)) |>
  count(carrier, sort = TRUE)

# Respuesta: la mayoria son de MQ y AA porque usaban otro tipo de numero para los aviones.

# 5. Add a column to planes that lists every carrier that has flown that plane. You might expect that there's an implicit relationship between plane and airline, because each plane is flown by a single airline. Confirm or reject this hypothesis using the tools you've learned in previous chapters.

carriers_por_avion <- flights |>
  filter(!is.na(tailnum)) |>
  distinct(tailnum, carrier) |>
  group_by(tailnum) |>
  summarize(carriers = paste(carrier, collapse = ", "), n_carriers = n())

planes_con_carriers <- planes |>
  left_join(carriers_por_avion, join_by(tailnum))

planes_con_carriers |>
  filter(n_carriers > 1)

# Respuesta: no se cumple porque algunos aviones aparecen en mas de una aerolinea.

# 6. Add the latitude and the longitude of the origin and destination airport to flights. Is it easier to rename the columns before or after the join?

origen <- airports |>
  transmute(origin = faa, origin_lat = lat, origin_lon = lon)

destino <- airports |>
  transmute(dest = faa, dest_lat = lat, dest_lon = lon)

flights_con_coordenadas <- flights |>
  left_join(origen, join_by(origin)) |>
  left_join(destino, join_by(dest))

# Respuesta: es mas facil cambiar los nombres antes del join para no confundir las columnas.

# 7. Compute the average delay by destination, then join on the airports data frame so you can show the spatial distribution of delays. You might want to use the size or color of the points to display the average delay for each airport.

atraso_por_destino <- flights |>
  group_by(dest) |>
  summarize(atraso_promedio = mean(arr_delay, na.rm = TRUE)) |>
  left_join(airports, join_by(dest == faa))

atraso_por_destino |>
  ggplot(aes(x = lon, y = lat)) +
  borders("state") +
  geom_point(aes(color = atraso_promedio)) +
  coord_quickmap()

# 8. What happened on June 13 2013? Draw a map of the delays, and then use Google to cross-reference with the weather.

vuelos_13_junio <- flights |>
  filter(year == 2013, month == 6, day == 13) |>
  left_join(destino, join_by(dest))

vuelos_13_junio |>
  ggplot(aes(x = dest_lon, y = dest_lat)) +
  borders("state") +
  geom_point(aes(color = arr_delay)) +
  coord_quickmap()

weather |>
  filter(year == 2013, month == 6, day == 13) |>
  group_by(origin) |>
  summarize(lluvia = sum(precip, na.rm = TRUE), viento = max(wind_gust, na.rm = TRUE))

# Respuesta: hubo tormentas fuertes y por eso hubo muchos atrasos y cancelaciones.
