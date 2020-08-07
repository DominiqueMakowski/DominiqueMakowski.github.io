# Set Path
# path <- "../../"  # If manually
path <- ""  # If from GH action


# ------------------------------
# Wordcloud data
# ------------------------------
library(dplyr)
library(ggplot2)
library(pdftools)
library(tm)
library(png)

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
  data
}



# ------------------------------

sources <- list.files(path = paste0(path, "content/publication/"), recursive=TRUE, full.names=TRUE, include.dirs=TRUE, pattern = "pdf$")


text <- c()
for (source in sources) {
  text <- c(text, pdftools::pdf_text(source))
}

text <- unlist(text)
text <- paste(text, sep = " ", collapse = "")
text <- iconv(text, "UTF-8", "ASCII", sub = "")


text_clean <- tm::termFreq(text, control = list(removePunctuation = TRUE, tolower = TRUE, removeNumbers = TRUE, stopwords = TRUE, wordLengths = c(2, Inf)))

data <- data.frame(word = rownames(as.matrix(text_clean)), freq = rowSums(as.matrix(text_clean))) %>%
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
  dplyr::mutate(word = stringr::str_conv(word, "UTF8"))






# ------------------------------
# Wordcloud plot
# ------------------------------
library(ggwordcloud)


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
    mask = png::readPNG(paste0(path, "content/cv/img/brain.png")),
    rm_outside = TRUE
  ) +
  scale_size_area(max_size = 13) +
  theme_minimal()
p

Sys.sleep(10)
ggsave(paste0(path, "content/cv/img/plot_wordcloud.png"), p, dpi=600, width=10)
Sys.sleep(10)
