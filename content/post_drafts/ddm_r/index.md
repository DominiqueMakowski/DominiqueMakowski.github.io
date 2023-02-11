---
title: "How to extract individual scores from repeated measures"
subtitle: "We compare different methods (individual models, Bayesian models with informative priors, random effects from mixed models) to extract individual scores from repeated measures tasks."
summary: "We compare different methods (individual models, Bayesian models with informative priors, random effects from mixed models) to extract individual scores from repeated measures tasks."
draft: true
featured: false
authors:
- Dominique Makowski
date: 2020-09-14
categories:
- R
- Statistics
tags:
- Statistics
- R
- Neuropsychology
- Bayesian
- Individual scores
image:
  caption: 'Absolute difference between true individual scores and the scores estimated via different methods.'
  placement: 1
---

### Introduction

### Data

The data comes from the `rtdists` package, corresponding to 17 participants performing a lexical decision task in which they have to decide if a presented string is a word or non-word. 

Two experimental conditions, under **speed** or **accuracy** instructions in different experimental blocks. This data comes with (which provides the PDF, CDF, and RNG for the full 7-parameter diffusion model). 

After removing some extreme RTs, we restrict the analysis to high-frequency words (frequency = high) and the corresponding high-frequency non-words (frequency = nw_high) to reduce estimation time. 

To setup the model we also need a binary (0 and 1) numeric response variable in which 0 corresponds to responses at the lower response boundary and 1 corresponds to responses at the upper boundary.

### Functions


```r
library(tidyverse)
library(easystats)
library(brms)

# http://singmann.org/wiener-model-analysis-with-brms-part-i/

# Get data ----------------------------------------------------------------


df <- rtdists::speed_acc %>%
  filter(censor == FALSE,  # Discard extreme RTs
         response != "error",  # Discard wrong input
         frequency %in% c("high", "nw_high")) %>%  # Keep only high-frequency to reduce computation
  mutate(Response = ifelse(response == "word", 1, 0),
         Error = ifelse(as.character(response) != as.character(stim_cat), 1, 0)) %>%
  select(Participant = id,
         Block = block,
         Condition = condition,
         Item = stim,
         Category = stim_cat,
         Response,
         Error,
         RT = rt)
#
# formula <- brmsformula(
#   RT | dec(Response) ~ 0 + Condition + (0 + Condition|Participant),
#   bs ~ 0 + Condition + (0 + Condition|Participant),
#   ndt ~ 0 + Condition + (0 + Condition|Participant),
#   bias ~ 0 + Condition + (0 + Condition|Participant))
#
#
# prior <- c(
#   prior("cauchy(0, 5)", class = "b"),
#   set_prior("normal(1.5, 1)", class = "b", dpar = "bs"),
#   set_prior("normal(0.2, 0.1)", class = "b", dpar = "ndt"),
#   set_prior("normal(0.5, 0.2)", class = "b", dpar = "bias")
# )
#
# model <- brm(formula,
#              data = df,
#              family = wiener(link_bs = "identity",
#                              link_ndt = "identity",
#                              link_bias = "identity"),
#              prior = prior,
#              # inits = initfun,
#              iter = 1000,
#              warmup = 500,
#              chains = 4,
#              control = list(max_treedepth = 15))


#
# # Save results ------------------------------------------------------------
#
#
# d <- list("results" = results, "model" = model, "contrasts" = contrasts)
# save(d, file = "data.Rdata")
```

### References

<sub>You can reference this post as follows:</sub>

<sub>- Makowski, D. (2020, September 14). How to extract individual scores from repeated measures. Retrieved from https://dominiquemakowski.github.io/post/individual_scores/</sub>

---

*Thanks for reading! Do not hesitate to share this post, and leave a comment below* :hugs:

🐦 *And don't forget to join me on Twitter* [@Dom_Makowski](https://twitter.com/Dom_Makowski)
