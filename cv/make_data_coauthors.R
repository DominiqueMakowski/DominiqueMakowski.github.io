# Set Path
# path <- "../../"  # If manually
path <- ""  # If from GH action


# ------------------------------
# Network data
# ------------------------------
library(dplyr)
library(stringr)
library(scholar)
library(igraph)
library(ggraph)
library(see)
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
# write.csv(data, "data_network.csv", row.names = FALSE)
# data <- read.csv("data_network.csv", stringsAsFactors = FALSE)

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

p_semi
ggsave(paste0(path, "content/cv/img/plot_network.png"), p_semi, dpi=500, width=10, height=10)

