---
authors:
- Dominique Makowski
categories:
- Reproducibility
date: "2021-11-05T00:00:00Z"
draft: false
featured: false
image:
  caption: ''
  placement: 0
title: '"Your sample is too small": How to Answer to Reviewers'
subtitle: 'Some tips on how to answer to reviewers when they say the sample is too small but that we cannot increase it.'
summary: Some tips on how to answer to reviewers when they say the sample is too small but that we cannot increase it.
tags:
- R
- Reproducibility
---

# "Your sample is too small": How to Answer to Reviewers

Reviewers questioning the statistical power of a study, while often valid, is common and unoriginal. The problem of possible lack of power, and thus possible false positives, can also be combined with the desire for stringent **multiple comparisons / tests** "corrections".

In many real-life scenarios, we simply cannot increase the sample size (because of money, time, COVID or any other reason). And sometimes, the many tests / comparisons are all needed as we have many hypotheses or variables. Naturally, the best **pre-study** weapon against power-related issues are **preregistration** (and registered-reports) with proper **power-analysis**.

That being said, imagine that for one reason or another we don't have that. We cannot recruit more participants and have to deal with the data that what we have. **What can we do?**

Some useful tips can be grouped and referred to as **PoSCA** (Power, Stringency, Coherence, Acknowledgment):

- **Po**wer: Don't waste power
  - Use all the information that you have. In particular, the information *within* participants (if you have multiple trials per participant, don't average over them!), by using methods such as **mixed-models**.
- **S**tringent significance
  - Increase the significance threshold, either arbitrarily (e.g., lower the *p*-value threshold to .005; Ioannidis, 2018) or pseudo-arbitrarily (using multiple-comparisons corrections such as the Bonferroni method). This, under the Bayesian framework, is <sub>(somewhat)</sub> equivalent to being more script with whatever indices that we use. For instance, consider only Bayes Factors (BF) > 30 instead of 10, or [Probabilities of Direction (*pd*)](https://easystats.github.io/bayestestR/articles/guidelines.html) of 99.9% instead of 97%, or widening the Region of Practical Equivalence (ROPE).
  - Constrain the parameters towards 0. We can also make it harder for models to have parameters (i.e., "effects") that deviate from 0. This is easy to do within the Bayesian framework by setting narrower priors centred around 0. This will naturally pull (known as "shrinkage") the results towards 0 and is a natural way of "controlling" for false positives. Under the frequentist framework, there are methods of regularization that can introduce a bias, such as LASSO or Ridge regressions.
- **C**oherence: cross-validate results
  - There is a need to look at the bigger picture, including non-significant and "trending" effects. Look at all the data together, and all the variables measuring related concepts: do the results go in the same direction? Are they internally coherent? Do they follow the same trend? In a small sample study, I would trust more a conclusion based on 10 tests with independent indices measuring aspects related to "depression", all barely significant but going in the same direction, over one super-significant (but possibly cherry-picked) result interpreted as a proof of the effect of "depression" in general. In other words, don't focus on "significant" effects and assess results in their entirety.
- **A**cknowledgment: be honest and humble
  - Quantify the evidence *against* the null hypothesis. Maybe an effect is not "significant", but that doesn't necessarily mean there is a lot of evidence that it has no effect either. Quantifying evidence against the null can be easily done using for instance Bayes Factors.
  - Be honest and acknowledge the limited power of the study. Don't try to hide it.
  - Temper the interpretation of the results. Don't over-interpret them if they are not super robust.


Science must be open, replicable & reproductible, slow, and based on methodological best-practices. But first and foremost, it must be honest.


# References

- Ioannidis, J. P. (2018). The proposal to lower P value thresholds to .005. Jama, 319(14), 1429-1430.

---

*Thanks for reading! Do not hesitate to share or tweet this post, or leave a comment below* :hugs:
