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



