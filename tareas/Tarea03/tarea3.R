library(ggplot2)
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

# install.packages("ggplot2")
# install.packages("tidyverse")
# install.packages("palmerpenguins")
# install.packages("ggthemes")

penguins # Permite visualizar el conjunto de datos de los pingüinos de Palmer.
glimpse(penguins) # Permite obtener un resumen estructurado del conjunto de datos de los pingüinos de Palmer.
summary(penguins) # Permite obtener un resumen estadístico del conjunto de datos de los pingüinos de Palmer.

ggplot(data = penguins)


# Gráfico de dispersión de la longitud del aleta vs la masa corporal de los pingüinos.

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g) 
)

# Gráfico de dispersión de la longitud del aleta vs la masa corporal de los pingüinos con puntos.

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()

# Grafico igual al anterior pero agrega color

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point()

# Grafico igual al anterior pero agrega una línea de tendencia lineal

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth(method = "lm")

# Grafico igual pero marca una sola tendencia

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "black")

# Grafico igual al anterior pero ahora se asigna color y forma a los puntos según la especie.

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

# Grafico completo y traducido 

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Masa corporal y longitud del aleta",
    subtitle = "Dimensiones de los pingüinos Adelie, Chinstrap y Gentoo",
    x = "Longitud del aleta (mm)", y = "Masa corporal (g)",
    color = "Especie", shape = "Especie"
  ) +
  scale_color_colorblind()

####################################################################################################################
# EJERCICIOS A RESOLVER
####################################################################################################################

#1 How many rows are in penguins? How many columns?

nrow(penguins)
ncol(penguins)

# Respuesta: El conjunto de datos tiene 344 filas y 8 columnas.

#2 What does the bill_depth_mm variable in the penguins data frame describe? Read the help for ?penguins to find out.
?penguins

# Respuesta: Es la profundidad del pico en milimetros.

#3 Make a scatterplot of bill_depth_mm vs. bill_length_mm. That is, make a scatterplot with bill_depth_mm on the y-axis and bill_length_mm on the x-axis. Describe the relationship between these two variables.

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point()

# Respuesta: Los puntos no siguen una linea muy clara. Parecen estar en grupos.

#4 What happens if you make a scatterplot of species vs. bill_depth_mm? What might be a better choice of geom?
ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +
  geom_boxplot()

# Respuesta: Queda raro porque species no es numerica. Un boxplot se ve mejor.

#5 Why does the following give an error and how would you fix it?
# ggplot(data = penguins) + 
#   geom_point()
#
# Respuesta: Falta decir que va en x y en y. Se arregla agregando aes().
ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point()

#6 What does the na.rm argument do in geom_point()? What is the default value of the argument? Create a scatterplot where you successfully use this argument set to TRUE.

# Respuesta: Sirve para sacar los NA. Por defecto es FALSE.
ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point(na.rm = TRUE)

#7 Add the following caption to the plot you made in the previous exercise: “Data come from the palmerpenguins package.” Hint: Take a look at the documentation for labs().

# Respuesta: Se agrega con caption en labs().
ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point(na.rm = TRUE) +
  labs(caption = "Data come from the palmerpenguins package.")

#8 Recreate the following visualization. What aesthetic should bill_depth_mm be mapped to? And should it be mapped at the global level or at the geom level?

# Respuesta: bill_depth_mm va en color, dentro de geom_point().
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = bill_depth_mm)) +
  geom_smooth()

#10 Will these two graphs look different? Why/why not?

# Respuesta: No cambian. Usan los mismos datos y las mismas variables.

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )

####################################################################################################################
# 1.4.3 EXERCISES
####################################################################################################################

#1 Make a bar plot of penguin species, but map species to the y aesthetic. How is this plot different?

ggplot(
  data = penguins,
  mapping = aes(y = species)
) +
  geom_bar()

# Respuesta: Es parecido, pero queda horizontal.

#2 How are these two plots different? Which aesthetic, color or fill, is more useful for changing the color of bars?

ggplot(
  data = penguins,
  mapping = aes(x = species)
) +
  geom_bar(color = "red")

ggplot(
  data = penguins,
  mapping = aes(x = species)
) +
  geom_bar(fill = "red")

# Respuesta: color cambia el borde y fill cambia el relleno. Fill sirve mas.

#3 What does the bins argument in geom_histogram() do?

ggplot(
  data = penguins,
  mapping = aes(x = body_mass_g)
) +
  geom_histogram(bins = 30)

# Respuesta: bins cambia la cantidad de barras del histograma.

#4 Make a histogram of the carat variable in the diamonds dataset. Try different binwidths. What binwidth shows the most interesting patterns?

ggplot(
  data = diamonds,
  mapping = aes(x = carat)
) +
  geom_histogram(binwidth = 0.01)

ggplot(
  data = diamonds,
  mapping = aes(x = carat)
) +
  geom_histogram(binwidth = 0.1)

ggplot(
  data = diamonds,
  mapping = aes(x = carat)
) +
  geom_histogram(binwidth = 0.5)

# Respuesta: Me parece que binwidth = 0.1 se entiende mejor.

####################################################################################################################
# 1.5.5 EXERCISES
####################################################################################################################

#1 The mpg data frame that is bundled with the ggplot2 package contains 234 observations collected by the US Environmental Protection Agency on 38 car models. Which variables in mpg are categorical? Which variables are numerical? How can you see this information when you run mpg?

mpg
glimpse(mpg)

# Respuesta: Algunas son texto/categorias y otras son numeros. Se ve con
# glimpse(mpg).

#2 Make a scatterplot of hwy vs. displ using the mpg data frame. Next, map a third, numerical variable to color, then size, then both color and size, then shape. How do these aesthetics behave differently for categorical vs. numerical variables?

ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy)
) +
  geom_point()

ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy, color = cty)
) +
  geom_point()

ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy, size = cty)
) +
  geom_point()

ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy, color = cty, size = cty)
) +
  geom_point()

ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy, shape = cty)
) +
  geom_point()

# Respuesta: color y size funcionan con numeros. Shape no queda tan bien.

#3 In the scatterplot of hwy vs. displ, what happens if you map a third variable to linewidth?

ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy, linewidth = cty)
) +
  geom_point()

# Respuesta: Casi no se nota porque linewidth es mas para lineas.

#4 What happens if you map the same variable to multiple aesthetics?

ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy, color = class, shape = class)
) +
  geom_point()

# Respuesta: La misma variable se muestra de dos formas, por ejemplo color y shape.

#5 Make a scatterplot of bill_depth_mm vs. bill_length_mm and color the points by species. What does adding coloring by species reveal about the relationship between these two variables? What about faceting by species?

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species)
) +
  geom_point()

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species)
) +
  geom_point() +
  facet_wrap(~species)

# Respuesta: Con color se ven mejor los grupos por especie. Con facetas se separan.

#6 Why does the following yield two separate legends? How would you fix it to combine the two legends?

ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm,
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species")

ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm,
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species", shape = "Species")

# Respuesta: Salen dos leyendas porque tienen nombres distintos. Se arregla con labs().

#7 Create the two following stacked bar plots. Which question can you answer with the first one? Which question can you answer with the second one?

ggplot(
  data = penguins,
  mapping = aes(x = island, fill = species)
) +
  geom_bar(position = "fill")

ggplot(
  data = penguins,
  mapping = aes(x = species, fill = island)
) +
  geom_bar(position = "fill")

# Respuesta: El primero compara especies por isla. El segundo compara islas por especie.

####################################################################################################################
# 1.6.1 EXERCISES
####################################################################################################################


#library(ggsave)
#install.packages("ggsave")

#1 Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?

ggplot(
  data = mpg,
  mapping = aes(x = class)
) +
  geom_bar()

ggplot(
  data = mpg,
  mapping = aes(x = cty, y = hwy)
) +
  geom_point()

ggsave("mpg-plot.png")

# Respuesta: Se guarda el segundo, porque ggsave guarda el ultimo grafico.

#2 What do you need to change in the code above to save the plot as a PDF instead of a PNG? How could you find out what types of image files would work in ggsave()?

ggsave("mpg-plot.pdf")

?ggsave

# Respuesta: Hay que cambiar .png por .pdf. Se puede mirar ?ggsave.
