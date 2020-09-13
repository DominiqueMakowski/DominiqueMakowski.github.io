# Set Path
# path <- "../../"  # If manually
path <- ""  # If from GH action

# ------------------------------
# Scholar data
# ------------------------------
library(dplyr)
library(scholar)
library(ggplot2)
library(forcats)
library(see)

data_scholar <- list()

data_scholar[["date"]] <- format(Sys.time(), "%d %B %Y")
data_scholar[["scholar_stats"]] <- scholar::get_profile("bg0BZ-QAAAAJ")
data_scholar[["scholar_history"]] <- scholar::get_citation_history("bg0BZ-QAAAAJ")
data_scholar[["scholar_publications"]] <-  scholar::get_publications("bg0BZ-QAAAAJ", flush = TRUE)
data_scholar[["scholar_data"]] <-  data_scholar[["scholar_publications"]]  %>%
  dplyr::filter(year > 1950) %>%
  dplyr::group_by(year) %>%
  dplyr::summarise(
    Publications = n(),
    # Citations = sum(cites)
  ) %>%
  dplyr::mutate(
    Publications = cumsum(Publications)
    # Citations = cumsum(Citations)
  ) %>%
  dplyr::rename(Year = year) %>%
  tidyr::gather(Index, Number, -Year) %>%
  dplyr::mutate(Index = forcats::fct_rev(Index)) %>%
  rbind(data_scholar[["scholar_history"]] %>%
          dplyr::rename(Number = cites,
                        Year = year) %>%
          mutate(Index = "Citations",
                 Number = cumsum(Number)))

# Publications individual
data <- data_scholar[["scholar_publications"]] %>%
  mutate(Authors = paste0(lapply(stringr::str_split(author, " "), `[[`, 2)),
         Authors = stringr::str_to_title(stringr::str_remove_all(Authors, ",")),
         Publication = paste0(Authors, " (", year),
         Journal = stringr::str_to_title(journal))


# Disambiguate unique
suffix <- letters
suffix[1] <- ""
for(i in 1:nrow(data)){
  pub <- data$Publication[i]
  j <- 1
  while(paste0(pub, suffix[j]) %in% data$Publication[1:i-1]){
    j <- j + 1
  }
  data$Publication[i] <- paste0(pub, suffix[j])
}

data_scholar[["scholar_publications"]] <- data %>%
  mutate(Publication = paste0(Publication, ")"),
         Publication = fct_reorder(Publication, cites, .desc = TRUE)) %>%
  filter(Publication != "Makowski (2013)")


save(data_scholar, file=paste0(path, "content/cv/data_scholar.Rdata"))



# library(patchwork)

# load("data_scholar.Rdata")

data <- data_scholar$scholar_data


p1 <- data %>%
  filter(Year >= 2014) %>%
  ggplot(aes(x = Year, y = Number)) +
  geom_bar(aes(alpha=Year), stat="identity") +
  geom_line(aes(colour = Index), size = 2) +
  see::theme_modern() +
  ylab("") +
  scale_x_continuous(labels = as.character(data$Year), breaks = data$Year) +
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


p2 <- data_scholar[["scholar_publications"]]  %>%
  ggplot(aes(x = Publication, y = cites, label = Journal)) +
  geom_bar(aes(fill=Publication), stat="identity") +
  # geom_text(angle=90, y=1, hjust = 0) +
  see::theme_modern() +
  scale_fill_material_d(palette="rainbow", reverse=TRUE) +
  ylab("Number of citations") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, NA)) +
  theme(
    # axis.title = element_text(face = "plain"),
    axis.title.x = element_blank(),
    axis.text.x = element_text(angle=45, hjust=1),
    legend.position = "none"
  )
p2



# p2 <- data_scholar$scholar_publications %>%
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
ggsave(paste0(path, "content/cv/img/plot_impact.png"), p1, dpi=450, width=10, height=8)
ggsave(paste0(path, "content/cv/img/plot_citations.png"), p2, dpi=450, width=10, height=4)
