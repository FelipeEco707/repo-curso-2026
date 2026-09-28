# Tarea 05 -----------------------------------------------------------------

# Instalar si hace falta:
# install.packages(c("tidyverse", "tidytext", "textdata", "topicmodels",
#                    "igraph", "ggraph"))

library(tidyverse)
library(tidytext)
library(topicmodels)
library(igraph)
library(ggraph)

# Cargamos los datos --------------------------------------------------------

url <- "https://gitlab.com/uploads/-/system/personal_snippet/4897254/d83847870c9577a22a20063379f91120/DATA-T9-mckinsey-mind-the-gap-articles-20251020.csv"
datos <- read_csv(url, show_col_types = FALSE)

glimpse(datos)
range(as.Date(datos$date))
datos %>% select(title, date) %>% print(n = Inf)

datos <- datos %>%
	mutate(
		doc_id = row_number(),
		date = as.Date(date),
		n_words = str_count(article_text, "\\S+")
	)

summary(datos$n_words)

ggplot(datos, aes(x = n_words)) +
	geom_histogram(bins = 25, fill = "#2c7fb8", color = "white") +
	labs(title = "Longitud de los artículos", x = "Palabras", y = "Cantidad") +
	theme_minimal()

# Tokenización y palabras frecuentes ----------------------------------------

data("stop_words", package = "tidytext")
custom_stop <- tibble(
	word = c(
		"mckinsey", "brought", "welcome", "email", "newsletter",
		"mind", "gap", "gen", "zers"
	)
)

tidy_articles <- datos %>%
	select(doc_id, title, date, article_text) %>%
	unnest_tokens(word, article_text) %>%
	filter(str_detect(word, "[a-z]")) %>%
	anti_join(stop_words, by = "word") %>%
	anti_join(custom_stop, by = "word")

tidy_articles %>% count(word, sort = TRUE) %>% slice_max(n, n = 20)

tidy_articles %>%
	count(doc_id, word) %>%
	bind_tf_idf(word, doc_id, n) %>%
	arrange(desc(tf_idf)) %>%
	slice_head(n = 20)

# Sentimientos --------------------------------------------------------------

bing <- get_sentiments("bing")

sentiment_bing <- tidy_articles %>%
	inner_join(bing, by = "word") %>%
	count(doc_id, sentiment) %>%
	pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
	mutate(net_sentiment = positive - negative) %>%
	left_join(datos %>% select(doc_id, title, date), by = "doc_id")

sentiment_bing %>%
	arrange(net_sentiment) %>%
	select(title, date, negative, positive, net_sentiment) %>%
	slice_head(n = 5)

sentiment_bing %>%
	arrange(desc(net_sentiment)) %>%
	select(title, date, negative, positive, net_sentiment) %>%
	slice_head(n = 5)

ggplot(sentiment_bing, aes(x = date, y = net_sentiment)) +
	geom_col(aes(fill = net_sentiment > 0), show.legend = FALSE) +
	scale_fill_manual(values = c("firebrick", "#2c7fb8")) +
	labs(title = "Sentimiento por artículo (Bing)", x = NULL, y = "Positivas - negativas") +
	theme_minimal()

# AFINN asigna un puntaje de -5 a 5 a cada palabra.
afinn <- get_sentiments("afinn")

sentiment_afinn <- tidy_articles %>%
	inner_join(afinn, by = "word") %>%
    group_by(doc_id, title, date) %>%
	summarise(sentiment = mean(value), .groups = "drop")

summary(sentiment_afinn$sentiment)

ggplot(sentiment_afinn, aes(x = date, y = sentiment)) +
	geom_point(color = "#2c7fb8") +
	geom_smooth(se = FALSE, color = "firebrick") +
	geom_hline(yintercept = 0, linetype = "dashed") +
	labs(title = "Sentimiento promedio (AFINN)", x = NULL, y = "Puntaje promedio") +
	theme_minimal()

# Tópicos: LDA con k = 10 y k = 15 ------------------------------------------

dtm <- tidy_articles %>%
	count(doc_id, word) %>%
	cast_dtm(doc_id, word, n)

set.seed(1234)
lda_10 <- LDA(dtm, k = 10, control = list(seed = 1234))
lda_15 <- LDA(dtm, k = 15, control = list(seed = 1234))

top_10 <- tidy(lda_10, matrix = "beta") %>%
	group_by(topic) %>%
	slice_max(beta, n = 8) %>%
	ungroup()

top_10 %>%
	mutate(term = reorder_within(term, beta, topic)) %>%
	ggplot(aes(term, beta, fill = factor(topic))) +
	geom_col(show.legend = FALSE) +
	facet_wrap(~topic, scales = "free") +
	coord_flip() +
	scale_x_reordered() +
	labs(title = "Términos principales por tópico (k = 10)", x = NULL, y = "Beta")

top_15 <- tidy(lda_15, matrix = "beta") %>%
	group_by(topic) %>%
	slice_max(beta, n = 8) %>%
	ungroup()

top_15 %>%
	mutate(term = reorder_within(term, beta, topic)) %>%
	ggplot(aes(term, beta, fill = factor(topic))) +
	geom_col(show.legend = FALSE) +
	facet_wrap(~topic, scales = "free") +
	coord_flip() +
	scale_x_reordered() +
	labs(title = "Términos principales por tópico (k = 15)", x = NULL, y = "Beta")

# Bigramas frecuentes -------------------------------------------------------

bigrams <- datos %>%
	unnest_tokens(bigram, article_text, token = "ngrams", n = 2) %>%
	separate(bigram, into = c("word1", "word2"), sep = " ") %>%
	filter(
		!word1 %in% stop_words$word, !word2 %in% stop_words$word,
		!word1 %in% custom_stop$word, !word2 %in% custom_stop$word
	)

bigram_counts <- bigrams %>% count(word1, word2, sort = TRUE)
bigram_counts %>% head(15)

set.seed(2025)
bigram_graph <- bigram_counts %>%
	filter(n > 3) %>%
	graph_from_data_frame()

ggraph(bigram_graph, layout = "fr") +
	geom_edge_link(aes(edge_alpha = n), show.legend = FALSE) +
	geom_node_point(color = "#2c7fb8", size = 3) +
	geom_node_text(aes(label = name), repel = TRUE, size = 3) +
	theme_void() +
	labs(title = "Red de bigramas frecuentes")

# Bigramas con negaciones ---------------------------------------------------

negaciones <- c("not", "no", "never", "without", "cant", "cannot",
				"dont", "isnt", "wont")

bigramas_negados <- datos %>%
	unnest_tokens(bigram, article_text, token = "ngrams", n = 2) %>%
	separate(bigram, into = c("word1", "word2"), sep = " ") %>%
	filter(word1 %in% negaciones) %>%
	inner_join(afinn, by = c("word2" = "word")) %>%
	count(word1, word2, value, sort = TRUE)

bigramas_negados %>% head(20)

# Las palabras con AFINN aparecen después de una negación. Es una aproximación
# porque el diccionario no interpreta el contexto completo.
