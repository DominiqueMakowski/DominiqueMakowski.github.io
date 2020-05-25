# ------------------------------
# Wordcloud data
# ------------------------------
library(tidyverse)
library(pdftools)


# utility function
replace_and_add <- function(data, target, add_to, delete = T) {
  if (!add_to %in% data$word) {
    data[nrow(data) + 1, ] <- c(add_to, 0)
  }
  data <- data %>%
    mutate(
      newfreq = freq[word == target],
      newfreq = replace(newfreq, !(word %in% c(add_to)), 0),
      freq = as.numeric(freq) + as.numeric(newfreq)
    ) %>%
    select(-newfreq)

  if (delete == T) {
    data <- filter(data, word != target)
  }
  return(data)
}



# ------------------------------

sources <- list.files(path = "../publication/", recursive=TRUE, full.names=TRUE, include.dirs=TRUE, pattern = "pdf$")


text <- c()
for (source in sources) {
  text <- c(text, pdftools::pdf_text(source))
}

text <- unlist(text)
text <- paste(text, sep = " ", collapse = "")
text <- iconv(text, "UTF-8", "ASCII", sub = "")


text_clean <- tm::termFreq(text, control = list(removePunctuation = TRUE, tolower = TRUE, removeNumbers = TRUE, stopwords = TRUE, wordLengths = c(2, Inf)))

data_wordcloud <- data.frame(word = rownames(as.matrix(text_clean)), freq = rowSums(as.matrix(text_clean))) %>%
  arrange(desc(freq)) %>%
  replace_and_add("er", "emotion", delete = F) %>%
  replace_and_add("er", "regulation") %>%
  replace_and_add("emotional", "emotion") %>%
  replace_and_add("psychologie", "psychology") %>%
  replace_and_add("psychologique", "psychological") %>%
  replace_and_add("mditation", "meditation") %>%
  replace_and_add("ction", "fiction") %>%
  replace_and_add("ctional", "fiction") %>%
  dplyr::mutate(length = stringr::str_length(word)) %>%
  dplyr::filter(freq > 30) %>%
  dplyr::filter(freq < Inf) %>%
  dplyr::filter(length >= 4) %>%
  dplyr::select(-length) %>%
  dplyr::filter(!word %in% c("dans", "plus", "pour", "avec", "cette", "comme", "sont", "tion", "also", "france", "nature", "lhrdit", "eect", "entre", "will", "leur", "mais", "thse", "deux", "elle", "lanne", "chez", "left", "deux", "thus", "ainsi", "fait", "tive", "better", "cogn")) %>%
  mutate(word = stringi::stri_trans_general(word, "latin-ascii"))

write.csv(data_wordcloud, "data_wordcloud.csv", row.names = FALSE)



# ------------------------------
# Wordcloud plot
# ------------------------------
library(ggwordcloud)

data <- read.csv("data_wordcloud.csv")

colours <- c("#f44336", "#E91E63", "#9C27B0", "#673AB7", "#3F51B5", "#2196F3", "#03A9F4", "#00BCD4", "#009688", "#4CAF50", "#8BC34A", "#CDDC39", "#FFEB3B", "#FFC107", "#FF9800", "#FF5722", "#795548", "#9E9E9E")
colours <- c(colours, rep("#607D8B", length.out = nrow(data) - length(colours)))


p <- data %>%
  arrange(desc(freq)) %>%
  mutate(
    word = factor(word, unique(word)),
    colours = colours,
    angle = 45 / 3 * sample(-2:2, n(), replace = TRUE, prob = c(1, 1, 4, 1, 1))
  ) %>%
  ggplot(aes(label = word, size = freq, color = word, angle = angle)) +
  scale_color_manual(values = colours) +
  ggwordcloud::geom_text_wordcloud(
    grid_margin = 0.5,
    area_corr = TRUE,
    area_corr_power = 1,
    mask = png::readPNG("img/brain.png"),
    rm_outside = TRUE
  ) +
  scale_size_area(max_size = 13) +
  theme_minimal()
# p
ggsave("img/plot_wordcloud.png", p, dpi=600, width=10)
ggsave("../../static/img/plot_wordcloud.png", p, dpi=600, width=10)


# ------------------------------
# Scholar data
# ------------------------------
library(scholar)

data_scholar <- list()

data_scholar[["scholar_stats"]] <- scholar::get_profile("bg0BZ-QAAAAJ")
data_scholar[["scholar_publications"]] <- scholar::get_publications("bg0BZ-QAAAAJ", flush = TRUE)
data_scholar[["scholar_history"]] <- data_scholar[["scholar_publications"]]  %>%
  dplyr::filter(year > 1950) %>%
  dplyr::group_by(year) %>%
  dplyr::summarise(
    Publications = n(),
    Citations = sum(cites)
  ) %>%
  dplyr::mutate(
    Publications = cumsum(Publications),
    Citations = cumsum(Citations)
  ) %>%
  dplyr::rename(Year = year) %>%
  tidyr::gather(Index, Number, -Year) %>%
  dplyr::mutate(Index = fct_rev(Index))

save(data_scholar, file="data_scholar.Rdata")



# library(patchwork)

load("data_scholar.Rdata")

history <- data_scholar$scholar_history
publications <- data_scholar$scholar_publications


p1 <- history %>%
  ggplot(aes(x = Year, y = Number)) +
  geom_bar(aes(alpha=Year), stat="identity") +
  geom_line(aes(colour = Index), size = 2) +
  see::theme_modern() +
  ylab("") +
  # scale_x_continuous(breaks = seq(min(stats$Year), max(stats$Year), by = 1)) +
  scale_color_manual(values = c("#2196F3", "#E91E63")) +
  facet_wrap(~Index, scales = "free", strip.position = "top") +
  theme(
    strip.background = element_blank(),
    strip.placement = "outside",
    # strip.text.y = element_blank(),
    strip.text = element_text(face = "plain", size = 16),
    axis.title = element_text(face = "plain", size = 16),
    axis.title.x = element_blank(),
    legend.position = "none"
  )
p1



# p2 <- publications %>%
#   ggplot(aes(x = cites)) +
#   geom_histogram(bins = 30) +
#   geom_density(aes(y = 3 * stat(count)), bw="SJ") +
#   see::theme_modern() +
#   theme(
#     strip.background = element_blank(),
#     axis.title = element_text(face = "plain", size = 16),
#     legend.position = "none"
#   )
# p2

# p1 / p2
ggsave("img/plot_impact.png", p1, dpi=450, width=10)
ggsave("../../static/img/plot_impact.png", p1, dpi=450, width=10)















# ------------------------------
# Network data
# ------------------------------
library(tidyverse)
library(scholar)
library(igraph)
library(ggraph)
library(tidygraph)


# Functions --------------------
find_coauthors <- function(id){
  df <- scholar:::list_coauthors(id, Inf)
  df$id <- scholar:::grab_id(df$coauthors_url)
  df[c("author", "coauthors", "id")]
}


list_coauthors <- function(df, sleep=0, silent=FALSE){
  data <- data.frame()

  for(i in 1:nrow(df)){

    if(silent==FALSE){
      cat(paste0(round(i/nrow(df)*100, 2), "%\n"))
    }

    Sys.sleep(runif(1, 1, sleep))

    if(!df$coauthors[i] %in% unique(df$author)){
      data <- rbind(data, find_coauthors(df$id[i]))
    }
  }

  data
}


get_coauthors <- function(id="bg0BZ-QAAAAJ", n_deep = 1, sleep=3, silent=FALSE) {
  stopifnot(is.numeric(n_deep), length(n_deep) >= 1, n_deep != 0)

  df <- find_coauthors(id)
  if(n_deep > 0){
    for(level in 1:n_deep){
      cat(paste0("level ", level, ":\n"))
      df <- rbind(df, list_coauthors(df, sleep=sleep, silent=silent))
    }
  }

  df$author <- stringr::str_to_title(df$author)
  df$coauthors <- stringr::str_to_title(df$coauthors)
  df <- df[!df$author %in% c("Sort By Citations", "Sort By Year", "Sort By Title"),]
  df <- df[!df$coauthors %in% c("Sort By Citations", "Sort By Year", "Sort By Title"),]
  df[c("author", "coauthors")]
}



create_graph <- function(data){
  data %>%
    tidygraph::as_tbl_graph(directed=FALSE) %>%
    dplyr::filter(name != "") %>%
    dplyr::mutate(closeness = tidygraph::centrality_closeness(normalized = TRUE),
                  degree = tidygraph::centrality_degree(normalized = TRUE),
                  betweeness = tidygraph::centrality_betweenness(normalized = TRUE)) %>%
    tidygraph::activate(edges) %>%
    dplyr::mutate(importance = tidygraph::centrality_edge_betweenness(),
                  group = as.factor(from)) %>%
    tidygraph::activate(nodes) %>%
    dplyr::filter(!name %in% c("Sort By Citations", "Sort By Year", "Sort By Title")) %>%
    dplyr::mutate(name = stringr::str_remove(name, ",.*"),
                  # group1 = as.factor(tidygraph::group_edge_betweenness()),
                  group2 = as.factor(tidygraph::group_optimal()),
                  # group3 = as.factor(tidygraph::group_walktrap()),
                  # group4 = as.factor(tidygraph::group_spinglass()),
                  group5 = as.factor(tidygraph::group_louvain())) %>%
    as.list()
}

# Get data --------------------------------

# Scrap data from google scholar
data <- get_coauthors("bg0BZ-QAAAAJ", n_deep=2, sleep=15)
write.csv(data, "data_network.csv", row.names = FALSE)
data <- read.csv("data_network.csv", stringsAsFactors = FALSE)

# Prune
data1 <- data[(data$author=="Dominique Makowski" | data$coauthors=="Dominique Makowski"), ]
firstlevel <- unique(c(data1$author, data1$coauthors))

data2 <- data[(data$author %in% firstlevel | data$coauthors %in% firstlevel), ]
secondlevel <- unique(c(data2$author, data2$coauthors))

data3 <- data[(data$author %in% secondlevel & data$coauthors %in% secondlevel) |
                (data$author %in% secondlevel & data$coauthors %in% secondlevel), ]


# Make plots --------------------------------



# Plot
data_semi <- create_graph(data3)


p_semi <- tidygraph::tbl_graph(nodes=data_semi$nodes, edges=data_semi$edges, directed=FALSE) %>%
  ggraph::ggraph(layout = 'fr') +
  ggraph::geom_edge_arc(aes(alpha=importance), show.legend = FALSE, strength=0.1) +
  ggraph::geom_node_point(aes(size = degree, colour=group2), show.legend = FALSE) +
  ggraph::geom_node_text(aes(label = name, size=degree), repel = TRUE, check_overlap = TRUE, show.legend = FALSE) +
  ggraph::theme_graph() +
  scale_size_continuous(range = c(2, 6)) +
  scale_edge_alpha_continuous(range=c(0.1, 0.8)) +
  # scale_color_viridis_d() +
  see::scale_color_material_d(palette="rainbow", reverse=TRUE)

ggsave("img/plot_network.png", p_semi, dpi=500, width=10, height=10)
ggsave("../../static/img/plot_network.png", p_semi, dpi=500, width=10, height=10)

