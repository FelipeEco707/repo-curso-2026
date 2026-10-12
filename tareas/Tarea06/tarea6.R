# Tarea 06 - EDGAR

# Paquetes ---------------------------------------------------------------
# Instalar si hace falta:
# install.packages(c("edgar", "tidyverse", "tidytext", "textdata"))

library(edgar)
library(tidyverse)
library(tidytext)
library(textdata)

# Contacto para las consultas a la SEC
contacto <- "Estudiante ECON-520 59FA45237678@campus.economicas.uba.ar"

# Empresas argentinas que cotizan en NYSE -------------------------------
if (dir.exists(file.path("tareas", "Tarea06"))) {
  setwd(file.path("tareas", "Tarea06"))
}

dir.create("resultados", showWarnings = FALSE)

empresas <- tibble(
  empresa = c("YPF", "Pampa Energia", "Telecom Argentina", "TGS"),
  cik = c("904851", "1469395", "932470", "931427")
)

# Descargar reportes anuales ---------------------------------------------
getFilings(
  cik.no = empresas$cik,
  form.type = "20-F",
  filing.year = 2020:2025,
  downl.permit = "y",
  useragent = contacto
)

# Leer y preparar los reportes -------------------------------------------
archivos <- list.files(
  "edgar_Filings",
  pattern = "\\.txt$",
  recursive = TRUE,
  full.names = TRUE
)

leer_reporte <- function(archivo) {
  texto <- paste(readLines(archivo, warn = FALSE), collapse = " ")

  documento <- str_split(texto, "<DOCUMENT>", simplify = FALSE)[[1]]
  principal <- documento[
    str_detect(documento, regex("^\\s*<TYPE>\\s*20-F", ignore_case = TRUE))
  ]
  if (length(principal) > 0) {
    texto <- paste(principal, collapse = " ")
  }

  texto %>%
    str_remove_all(regex(
      "<style[^>]*>.*?</style>|<script[^>]*>.*?</script>",
      ignore_case = TRUE,
      dotall = TRUE
    )) %>%
    str_remove_all("<[^>]+>") %>%
    str_replace_all("&[^;[:space:]]+;", " ") %>%
    str_to_lower()
}

reportes <- tibble(archivo = archivos) %>%
  mutate(cik = str_remove(str_extract(basename(archivo), "^[0-9]+"), "^0+")) %>%
  left_join(empresas, by = "cik") %>%
  filter(!is.na(empresa)) %>%
  mutate(texto = map_chr(archivo, leer_reporte))

# Analisis de texto: incidencia de palabras ------------------------------
palabras <- c(
  "inflation", "devaluation", "exchange controls", "default",
  "restructuring", "imf", "capital controls", "price controls",
  "country risk", "embi"
)

por_empresa <- reportes %>%
  group_by(empresa) %>%
  summarise(
    texto = paste(texto, collapse = " "),
    total_palabras = str_count(texto, "\\b\\w+\\b"),
    .groups = "drop"
  )

menciones <- expand_grid(empresa = por_empresa$empresa, palabra = palabras) %>%
  left_join(por_empresa, by = "empresa") %>%
  mutate(
    cantidad = map2_int(
      texto, palabra,
      ~ str_count(.x, regex(paste0("\\b", .y, "\\b")))
    ),
    por_10000_palabras = cantidad / total_palabras * 10000
  ) %>%
  select(empresa, palabra, cantidad, por_10000_palabras)

write_csv(menciones, "resultados/menciones.csv")
print(menciones)

# Palabras distintivas por empresa (TF-IDF) ------------------------------
tokens <- reportes %>%
  select(empresa, texto) %>%
  unnest_tokens(palabra, texto) %>%
  filter(str_detect(palabra, "^[a-z]+$")) %>%
  anti_join(stop_words, by = c("palabra" = "word")) %>%
  count(empresa, palabra)

tfidf <- tokens %>%
  bind_tf_idf(palabra, empresa, n) %>%
  group_by(empresa) %>%
  slice_max(tf_idf, n = 10, with_ties = FALSE) %>%
  ungroup()

write_csv(tfidf, "resultados/tfidf.csv")
print(tfidf)

# Analisis de sentimiento (Loughran-McDonald) ----------------------------
sentimientos <- tokens %>%
  inner_join(
    get_sentiments("loughran"),
    by = c("palabra" = "word"),
    relationship = "many-to-many"
  ) %>%
  count(empresa, sentiment, wt = n)

write_csv(sentimientos, "resultados/sentimientos.csv")
print(sentimientos)
