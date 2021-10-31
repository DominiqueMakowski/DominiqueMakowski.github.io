---
authors:
- Dominique Makowski
categories:
- R
- Statistics
date: "2020-05-17T00:00:00Z"
draft: true
featured: false
image:
  caption: ''
  placement: 0
title: 'The Null Hypothesis Fallacy'
subtitle: 'The one where I argue that there is no such thing as a null effect (i.e., a coefficient of exactly zero).'
summary: 'The one where I argue that there is no such thing as a null effect (i.e., a coefficient of exactly zero).'
tags:
- Statistics
- Significance
- p-value
- Null hypothesis
---

## Introduction


The null hypothesis is a hallmark of experimental science, and the paradigm derived from it - the **null hypothesis significance testing (NHST) ** - has dominated the world of applied statistics in the last century. It has led to the invention and widespread usage of the infamous ***p*-value** and the related concept of **significance**, but it can also be present in alternative frameworks such as Bayesian statistics. Interestingly, it became one of the combustible fuelling the recent controversies related to the **reproducibility** and **replicability** crises.

In this series of posts, I will argue that the null hypothesis is not plausible, and examine the consequences of this fact, that will naturally lead me to elaborate an alternative framework for significance testing.

## Absence of effect *vs.* Null Effect

Most scientists are designing experiments to quantify or assess the existence of an **effect** (a relationship between two things), to which a natural opposite seems to be the **absence of effect**. These effects are usually operationalized as parameters - or coefficients - of some statistical models. Such models are akin to a simplified version of the world, which can be more or less complex, accurate, appropriate or sensitive to investigate a given effect.

Interestingly, in most of statistical models, the *existence* of effects (i.e., coefficients) is predetermined. We could, in theory, imagine a model in which we say *"here are 3 variables, V1, V2 and V3"*, and the model would create parameters, for instance the correlation between *V1* and *V3*, only if said effect *is present* (exists in the data). With such a model, it would be possible to tell whether an effect exists (i.e., if it's present as a parameter), and if so investigate its properties (size, range, ...). The presence/absence of effects, a dichotomous concept by nature, would be directly transposable to the mathematics.

But that's not what happens. In general, the existence of a given parameter depends on the model specification, rather than on the data. This means that the researcher has to specify whether he wants to include the correlation between *V1* and *V3* in order to estimate it. This might seem trivial, but it has important consequences, as it leads to the *de facto* swapping of **absence of effects** for **null effects**, which shifts the focus to the value of the effect, which is by nature a continuous concept. 

While most people would argue that **no effect** and **null effect** are equivalent, merely representing two ways of looking at the same phenomenon ("null effect" being the numerical, coefficient-focused, version of "no effect"), it is still important to note that null *vs.* non-null effect is most of the time an artificial dichotomization of a continuous measure.

## A Null Effect is not a Very Small Effect

The focus on the effect value is a double edged sword. Let's take an effect (i.e., a coefficient) of `0.000001`. 

We all have a tendency to equate very small effects as "null" effects.


## Null Effects Do Not Exist

Meehl’s (1967, 1978, 1990, 1997), in a series of demonstration (see also Waller, 2004), suggested that *"the null hypothesis, taken literally, is always false"* (Meehl, 1978, p. 822). Based on strongly-powered personality datasets, he realised that the probability of two variables being significantly related is a function of sample size, and concluded that *"in social science everything correlates with almost everything else, theory aside"* (Meehl, 1997, p. 393). 

I would like to extent this conclusion beyond social sciences or, as coined by Meehl or Waller (2004), *"soft psychology"* (a term that I do not particularly like). Example of air pressure.


This is a **major issue**, as it means that any effect for which we cannot reject the null hypothesis (where *p* > .05) can be interpreted as *""*

## No Effects Do Not Exist Either


## Solutions

- Bayesian: quantify support in favour of the null
- Effect size & region of equivalence

- Third solution: change paradigm (SexIt).


Taken literally, the null hypothesis is always false. (as cited in Meehl, 1990, p 205). When this phenomenon is combined with the fact that very large samples can make every small effect a significant effect, one has to conclude that with the ideal sample (as large as possible) one have to reject every null hypothesis.

This is problematic because this will turn research into a tautology. Every experiment that has a p-value > .05, will become a type II error since the sample was just not big enough to detect the effect. A solution could be to attach more importance to effect sizes and make them decisive in whether a null hypothesis should be rejected.



## References



Waller, N. G. (2004). The fallacy of the null hypothesis in soft psychology. Applied and Preventive Psychology, 11(1), 83-86.

Meehl, P. E. (1967). Theory-testing in psychology and physics: A methodological paradox. Philosophy of Science, 34, 103–115.

Meehl, P. E. (1978). Theoretical risks and tabular asterisks: Sir Karl, Sir Ronald, and the slow progress of soft psychology. Journal of Consulting and Clinical Psychology, 46, 806–834.

Meehl, P. E. (1990). Appraising and amending theories: The strategy of Lakatosian defense and two principles that warrant using it. Psychological Inquiry, 1, 108–141, 173–180.

Meehl, P. E. (1997). The problem is epistemology, not statistics: Replace significance tests by confidence intervals and quantify accuracy of risky numerical predictions. In L. L. Harlow, S. A. Mulaik, & J.H. Steiger (Eds.), What if there were no significance tests? (pp. 393–425). Mahwah, NJ: Erlbaum.


---

*Thanks for reading! Do not hesitate to tweet and share this post, and leave a comment below* :hugs:

🐦 *Don't forget to join me on Twitter* [@Dom_Makowski](https://twitter.com/Dom_Makowski)
