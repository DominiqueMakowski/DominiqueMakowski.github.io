library(tidyverse)
library(tidyverse)

df <- data.frame(
  x = seq(-sqrt(2), sqrt(2), length.out = 1000)
)
df$y <- -df$x ** 2
df$y[df$x >= 0] <- df$y[df$x >= 0] * 4


p <- df |>
  ggplot(aes(x=x, y=y)) +
  geom_segment(aes(x = -sqrt(2), xend = -sqrt(2), y = -6, yend=-2), color="#E0E0E0", linetype="dashed", linewidth=0.5) +
  geom_segment(aes(x = 0, xend = 0, y = -6, yend=0), color="#E0E0E0", linetype="dashed", linewidth=0.5) +
  geom_line(aes(color = x), linewidth=4) +
  scale_y_continuous(breaks  = c(-4, -2, 0), labels = c("Fictional", "Agnostic-Real\n(Default Mode)", "Real\n(Strong feeling)")) +
  scale_x_continuous(breaks=c(-sqrt(2), 0, 1), labels = c("Normal", "Intense", "Extreme")) +
  scale_color_gradientn(colors=c("green", "green", "red", "red", "blue", "blue")) +
  labs(x = "Affective Response (Emotional Arousal)",
       y = 'Reality Belief\n(output of the "Simulation Monitoring" process)',
       title = 'The Affective Reality Theory',
       subtitle  = "Belief that the object of an experience is real as a function of how it affects us:\n \n ",
       caption = "Makowski (2018)") +
  # geom_hline(yintercept = c(-2, -4)) +
  guides(color = "none") +
  coord_cartesian(ylim  = c(-4, 0), xlim = c(-sqrt(2), 1)) +
  see::theme_blackboard() +
  theme(plot.title = element_text(face = "bold", hjust =  0.5, color="white", size=rel(1.5)),
        plot.subtitle = element_text(hjust = 0, vjust=4, color="white"),
        plot.caption = element_text(face = "italic"),
        axis.title.x = element_text(face = "bold", color = "white"),
        axis.title.y = element_text(face = "bold", color = "white"),
        axis.text.x = element_text(color = "white"),
        axis.text.y = element_text(color = "white"))
p

ggsave("AffectiveRealityTheory_Makowski.png", p, dpi=300, height=6, width=8)
