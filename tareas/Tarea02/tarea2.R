# Tarea 02
# Datos aproximados

# A1 Introducción a los Tipos de Datos

encuestado_id <- 910028  #integer
ingreso <- 1000000  #numeric
miembros_hogar <- 4L #integer
estado <- "Ocupado" #character
busca_trabajo <- FALSE #logical

class(encuestado_id)
class(ingreso)
class(miembros_hogar)
class(estado)
class(busca_trabajo)

# A2 Números y Cadenas de Texto

sector <- "Programacion" #character
categoria <- "Desarrollador" #character

class(sector)
class(categoria)

textocompleto <- paste("Pertenece al sector", sector, "y a la categoria", categoria)
print(textocompleto)

# A3 Booleanos y Operadores

salario_mensual <- ingreso  #numeric
class(salario_mensual)
salario_anual <- ingreso * 12  #numeric
class(salario_anual)
salario_anual_aguinaldo <- salario_anual + ingreso / 13  #numeric
class(salario_anual_aguinaldo)
salario_por_miembro_hogar <- salario_mensual / miembros_hogar  #numeric
class(salario_por_miembro_hogar)

edad <- 23L #integer
esmayor <- edad >= 18  #logical
espoblacioneconomicamenteactiva <- esmayor & estado %in% c("Ocupado", "Desempleado")  #logical

# A4 Toma de decisiones (If...Else)

if(salario_mensual < 300000) {
  print("Por debajo del salario minimo")
}

if(salario_mensual >= 1000000) {
  decil <- "Alto"
} else if(salario_mensual >= 500000) {
  decil <- "Medio"
} else {
  decil <- "Bajo"
}
print(decil)

# A5 Bucles - While Loop

mesesbuscandonuevotrabajo <- 3L #integer
while(mesesbuscandonuevotrabajo < 12) {
  print(paste("Lleva", mesesbuscandonuevotrabajo, "meses", "buscando trabajo (maximo 1 año)"))
  mesesbuscandonuevotrabajo <- mesesbuscandonuevotrabajo + 1
}

mesesbuscandonuevotrabajo < 12L
while (TRUE) {
  if(mesesbuscandonuevotrabajo >= 12) {
    break
  }
  print(paste("Lleva", mesesbuscandonuevotrabajo, "meses", "buscando trabajo (maximo 1 año)"))
  mesesbuscandonuevotrabajo <- mesesbuscandonuevotrabajo + 1
}

horas_trabajadas <- 40L #integer
ingreso_por_hora <- ingreso / (horas_trabajadas)  #numeric

horas_oficiales <- 20L #integer
horas_extras <- horas_trabajadas - horas_oficiales  #integer
ingreso_por_hora_extra <- ingreso_por_hora * 1.5  #numeric

# A6 Bucles - For Loop

freelance_salarios_hora_mediotiempo <- c(5000, 6000, 7000, 8000, 9000)  
for(salario in freelance_salarios_hora_mediotiempo) {
  print(paste("El salario freelance es", salario * 4))
}


# A7 Vectores y Listas

edades_hogar <- c(23L, 45L, 18L, 12L)  #integer vector
promedio_edad_hogar <- mean(edades_hogar)  #numeric

quienesjefedehogar <- c(TRUE, TRUE, FALSE, FALSE)  #logical vector

jefe_de_hogar <- edades_hogar[quienesjefedehogar]  #integer vector of household heads' ages

jefedehogar <- list(
    id = encuestado_id,
    edad = jefe_de_hogar,
    nombre = "CarlitosTevez",    
    es_propietario = TRUE
)

# A8 Matrices y Arrays
datos_transicion <- c(1, 2, 3, 4)
matriz_transicion <- matrix(datos_transicion, nrow = 2, ncol = 2)  #2x2 matrix
class(matriz_transicion)

# A9 Data Frames
microdatitos <- data.frame(
  id = c(1, 2, 3, 4),
  ingreso = c(250000, 500000, 750000, 1000000),
  miembros_hogar = c(3, 4, 2, 5)
)

microdatitos_matrix <- as.matrix(microdatitos)
class(microdatitos_matrix)

# A10 Factores
vector_decil <- c("Alto", "Medio", "Bajo")
estado_decil <- factor(vector_decil)
levels(estado_decil)

print(estado_decil)

