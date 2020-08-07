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

data_scholar[["scholar_stats"]] <- scholar::get_profile("bg0BZ-QAAAAJ")
data_scholar[["scholar_publications"]] <- scholar::get_citation_history("bg0BZ-QAAAAJ")
data_scholar[["scholar_history"]] <-  scholar::get_publications("bg0BZ-QAAAAJ", flush = TRUE)  %>%
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
  rbind(data_scholar[["scholar_publications"]] %>%
          dplyr::rename(Number = cites,
                        Year = year) %>%
          mutate(Index = "Citations",
                 Number = cumsum(Number)))



save(data_scholar, file=paste0(path, "content/cv/data_scholar.Rdata"))



# library(patchwork)

# load("data_scholar.Rdata")

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
ggsave(paste0(path, "content/cv/img/plot_impact.png"), p1, dpi=450, width=10, height=8)
