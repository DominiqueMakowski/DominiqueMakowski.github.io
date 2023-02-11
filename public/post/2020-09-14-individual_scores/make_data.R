library(tidyverse)
library(easystats)
library(rstanarm)
library(ggdist)


# Get data ----------------------------------------------------------------

get_data <- function(n_participants = 10, n_trials = 20, d = 1.5, var = 3, noise = 0.1) {
  scores_baseline <- rnorm(n_participants, 0, 1)
  scores_condition <- rnorm(n_participants, d, 1)
  variances <- rbeta(n_participants, 2, 8)
  variances <- 0.1 + variances * (var / max(variances)) # Rescale
  noise_sd <- abs(rnorm(n_participants, 0, noise))

  data <- data.frame()
  for (i in 1:n_participants) {
    a <- rnorm(n_trials, scores_baseline[i], variances[i])
    b <- rnorm(n_trials, scores_condition[i], variances[i])
    a <- a + rnorm(n_trials, 0, noise_sd[i]) # Add noise
    b <- b + rnorm(n_trials, 0, noise_sd[i]) # Add noise
    data <- rbind(data, data.frame(
      "Participant" = sprintf("S%02d", i),
      "Y" = c(a, b),
      "Score_True" = rep(c(scores_baseline[i], scores_condition[i]), each = n_trials),
      "Condition" = rep(c("Baseline", "Manipulation"), each = n_trials)
    ))
  }
  data
}



# Visualize data -----------------------------------------------------------

p <- get_data(n_participants = 20) %>%
  group_by(Participant, Condition) %>%
  mutate(mean = mean(Y)) %>%
  ggplot(aes(y = Y, x = Condition, fill = Participant, color = Participant, group = Participant)) +
  geom_line(aes(y = mean), position = position_dodge(width = 0.66)) +
  ggdist::stat_eye(point_interval = ggdist::mean_hdi, alpha = 0.66, position = position_dodge(width = 0.66), .width = c(0.95)) +
  ylab("Score") +
  theme_modern() +
  theme(legend.position = "none")
ggsave("individual.png", p, width = 7, height = 7, dpi = 450)


# Get results -------------------------------------------------------------


get_results <- function(data) {

  # Raw method ----

  results <- data %>%
    group_by(Participant, Condition) %>%
    summarise_all(mean) %>%
    rename("Score_Raw" = "Y") %>%
    arrange(Condition, Participant) %>%
    ungroup()


  # Population model ----

  model <- lme4::lmer(Y ~ Condition + (1 + Condition | Participant), data = data)

  fixed <- insight::get_parameters(model, effects = "fixed")$Estimate
  random <- insight::get_parameters(model, effects = "random")$Participant

  # Transform coefs into scores
  pop_baseline <- random[, 1] + fixed[1]
  pop_manipulation <- pop_baseline + random[, 2] + fixed[2]

  results$Score_PopulationModel <- c(pop_baseline, pop_manipulation)


  # Individual model ----

  individual_model_data <- data.frame()
  for (participant in unique(data$Participant)) {
    cat(".") # Print progress

    dat <- data[data$Participant == participant, ]

    # Frequentist
    model1 <- lm(Y ~ Condition, data = dat)
    nopriors <- parameters::parameters(model1)$Coefficient

    # Bayesian without priors
    # model2 <- stan_glm(Y ~ Condition, data = dat, refresh = 0)
    # bayes <- parameters::parameters(model2)$Median

    # Bayesian with Priors
    model3 <- stan_glm(Y ~ Condition,
      data = dat,
      refresh = 0,
      prior = normal(fixed[1]),
      prior_intercept = normal(fixed[2])
    )
    priors <- parameters::parameters(model3)$Median


    individual_model_data <- rbind(
      individual_model_data,
      data.frame(
        "Participant" = c(participant, participant),
        "Condition" = c("Baseline", "Manipulation"),
        "Score_IndividualModel" = c(nopriors[1], nopriors[1] + nopriors[2]),
        # "Score_IndividualModel_Bayes" = c(bayes[1], bayes[1] + bayes[2]),
        "Score_IndividualModel_Priors" = c(priors[1], priors[1] + priors[2])
      )
    )
  }

  results <- merge(results, individual_model_data)


  # Clean output ----

  diff <- results %>%
    mutate(
      # Diff_Raw = Score_True - Score_Raw,
      Diff_PopulationModel = Score_True - Score_PopulationModel,
      Diff_IndividualModel = Score_True - Score_IndividualModel,
      # Diff_IndividualModel_Bayes = Score_True - Score_IndividualModel_Bayes,
      Diff_IndividualModel_Priors = Score_True - Score_IndividualModel_Priors
    ) %>%
    select(Participant, Condition, starts_with("Diff")) %>%
    pivot_longer(starts_with("Diff"), names_to = "Method", values_to = "Diff") %>%
    mutate(Diff_Abs = abs(Diff))

  diff
}



# Analysis ----------------------------------------------------------------
results <- data.frame()
for(n in seq.int(10, 300, length.out = 10)){
  data <- get_data(n_participants = round(n), n_trials = 20)
  rez <- get_results(data) %>%
    select(-Participant) %>%
    group_by(Condition, Method) %>%
    summarise_all(mean) %>%
    mutate(n_Participants = n,
           Method = as.factor(Method),
           Dataset=paste0("Dataset", round(n, 2)))
  results <- rbind(results, rez)

  print(n) # Print progress
}

# model <- mgcv::gam(Diff_Abs ~ Method + s(n_Participants, by = Method), data = results)
model <- lm(Diff_Abs ~ Method * poly(n_Participants, 3), data = results)

parameters::parameters(model)


contrasts <- modelbased::estimate_contrasts(model) %>%
  arrange(Difference) %>%
  mutate(
    Level1 = stringr::str_remove(Level1, "Diff_"),
    Level2 = stringr::str_remove(Level2, "Diff_")
  ) %>%
  select(Level1, Level2, Difference, CI_low, CI_high, p)




# Visualize results ---------------------------------------------------------
p <- modelbased::estimate_means(model) %>%
  arrange(Mean) %>%
  mutate(
    Method = stringr::str_remove(Method, "Diff_"),
    Method = factor(Method, levels = Method)
  )  %>%
  ggplot(aes(x = Method, y = Mean, color = Method)) +
  geom_line(aes(group = 1)) +
  geom_pointrange(aes(ymin = CI_low, ymax = CI_high), size = 1) +
  theme_modern() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_color_material()
ggsave("featured.png", p, width = 10, height = 6, dpi = 450)



p <- modelbased::estimate_relation(model) %>%
  mutate(Method = stringr::str_remove(Method, "Diff_"))  %>%
  ggplot(aes(x = n_Participants, y = Predicted)) +
  geom_point(data=mutate(results, Method = stringr::str_remove(Method, "Diff_")),
             aes(y=Diff_Abs, color = Method)) +
  geom_ribbon(aes(ymin=CI_low, ymax=CI_high, fill=Method), alpha=0.1) +
  geom_line(aes(color = Method), size=1) +
  theme_modern() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_color_material() +
  scale_fill_material()
ggsave("n_participants.png", p, width = 10, height = 6, dpi = 450)


# Save results ------------------------------------------------------------


d <- list("results" = results, "model" = model, "contrasts" = contrasts)
save(d, file = "data.Rdata")



