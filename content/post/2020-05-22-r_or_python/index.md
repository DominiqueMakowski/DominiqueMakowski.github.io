---
authors:
- Dominique Makowski
categories:
- R
- Python
- Psychology
date: "2020-05-22T00:00:00Z"
draft: false
featured: false
image:
  caption: ''
  placement: 0
title: 'R or Python for Psychologists'
subtitle: 'Most psychology students or researchers are faced with the challenge of learning a programming language. Which one should you pick?'
summary: 'Most psychology students or researchers are faced with the challenge of learning a programming language. Which one should you pick?'
tags:
- R 
- Python
- Language
- Psychology
- Programming
- Best language
- Psychologist
---

Many psychology students or researchers are faced with the challenge - *or the opportunity* - of learning a programming language. **Which one should you learn?** 

As an ex- psych student and a daily user and developer of both, here's my take on this hot debate.


## What has programming to do with psychology?

If you're a very young psychology student, or a future one, you might wonder: **why the heck would I have to learn programming in psychology?** *"Psychology is like philosophy, it's just learning how people's minds work by reading books and overthinking stuff"*. If you still think that, you're in for **one hell of a ride**. 

Psychology is, since its very beginning, a hard and experimental science. The founding fathers of psychology were dedicated to find ways to objectively *measure* psychological phenomena and uncovering the mathematical laws that govern Human behaviour (one of the fields of psychology is even called psycho*physics*). This *sciency* nature has been toned down by the booming popularity of **pseudo-scientific approaches like psychoanalysis**, that contributed to the stereotypical public image of the shrink doodling while listening to a neurotic patient. But that's a distorted and old-fashioned view, clearly not representative of the future of psychology. 

The fact is that psychology is very closely connected with **statistics**. Many great statistical advances were made by psychologists, and all true psychological discoveries are backed by statistical findings. And this importance of statistics is - and will be - growing further, partly due to the recent realization of some major issues in the field due to improper statistical procedures (coined the "[**replicability crisis**](https://en.wikipedia.org/wiki/Replication_crisis)"). Moreover, psychology is more and more relying on advanced data-acquiring methods (smartphone apps, website data, physiological and brain recording devices like EEG, MRI, etc.). And these new formats often require specialized knowledge (web-scraping, database querying, neuroimaging, signal processing, machine learning, ...). Even in the most applied kind of **clinical** or **psychotherapeutic** specialization, where you'd think you'd be safe, they are starting to use data intensive methods like neuro-feedback, virtual reality or smartphone sensing and surveying.

Long story short, no matter which branch of psychology you specialize in, you *will* be confronted with some technical aspects that won't be able to solve with *Excel*. Importantly, these are the skills that will make the most difference between students, and that will matter a lot if you want to pursue research.

So, **ready to dive into programming?** Fear not! It's not that complicated. Moreover, it's **one of the most rewarding skill** you can develop. I can assure you that you won't regret the time invested in learning it 😊

But where should you start?



## Both R and Python

This increasing relationship between psychology and statistics on the one hand, and other more general technical aspects on the other, is the reason why R and Python are so popular in psychology. Both languages are **free**, **open-source**, suited for **beginners**, and have a large base of users with a ton of **learning material** online. What's the difference between them?

Put simply, **R is for statistics, Python is for the rest**. 


So why is there a virulent debate going on, and a choice to make? It's true that I, *in theory*, would recommend **learning both**, as they are complementary and have their own strengths and weaknesses. 

However, many opinionated people arguing in favour of one **or** the other (usually the only one they know) will say that learning both is essentially a waste of time. They will put forth a strong argument: **you can do whatever you do in R in Python, and *vice-versa***. In other words, both languages can be used to achieve your goals, and it's **better to specialize in one than have a limited knowledge of both**. 

Although I do not agree with that statement, I do acknowledge that people have limited time and resources to learn. Saying **"just learn both"** is easy, but is arguably an unrealistic expectation for the vast majority of people. So why learning both can be a long-term goal (especially if you want to do research), you have to start somewhere. So, **what starter language should you select?**

<figure>
  <img src="pokemon.png" alt="r or python"/>
  <figcaption>Ash choosing his starter programming language. He has the choice between R, Python and Bulbasaur, i.e, Matlab - the one that no one likes.</figcaption>
</figure>




## What about Matlab?



There was a time when *Matlab* was the boss. It was used everywhere and had the best functionalities for neuroimaging, signal processing and maths. But **that time is over**. Matlab is already a dead language, which burial process will continue in the years to come. Why is it dead? Because it is **expensive**, **closed**, **ugly**, and most importantly the alternatives (namely R and Python) are now more powerful and featured than Matlab. 

<figure>
  <img src="https://media.giphy.com/media/sDOhzJBsFvjMY/giphy.gif" alt="matlab"/>
  <figcaption>Agamemnon reacting to king Priam saying "The city of Matlab will never be conquered".</figcaption>
</figure>


The truth is, there are only two reasons people still use Matlab: **habit** (it's hard to learn a new approach if your old way of doing things still works) and **SPM** (a toolbox for neuroimaging that is still - *for now* - the leader in the field).

But seriously, don't waste time on it if you have limited resources, it's just not worth it. You will learn an outdated tool that you won't be able to use in another lab if they don't agree to pay for an expensive license (unless you're a pirate ☠️). Whereas with open and free languages like R or Python, you have access to the best tools and can use them freely everywhere. Also, it makes you a **supporter of open-science**, and that's trendy 😁.


## How to decide between R and Python

**Time has come to make a decision.**

Despite what people say, **R and Python are not equivalent**. You can argue as much as you want, but doing statistics and data visualization in Python is not as fast, easy and neat as it is in R. And signal processing or neuroimaging is not as powerful in R as compared to Python. Note that both languages are still growing and changing, and they are influencing themselves: for instance, many popular Python modules (e.g., **pandas**, **statsmodels**, **seaborn**, ...) have been directly inspired by R. As such, the boundaries between the two languages are fading (and I'm not even mentioning the great advances in interoperability, with tools like [**reticulate**](https://rstudio.github.io/reticulate/) that allow you to use one language directly inside the other).

That being said, Python and R remain very different languages at their core, with a different feel and vibe to it. R was made by statisticians for statistics, and the majority of its users are academics and researchers. On the contrary, Python is a true general-purpose "programming" language, widely used outside of academia, in the private sector.

Here are some things to consider when deciding on what language to learn:

### Reasons to choose Python

- **You have some basic knowledge or familiarity with programming** 

For instance, you know what a loop is. Python being a true programming language, having any prior experience will be useful.

- **You are good with logic and spatial representation (like imagining shapes in 3D, rotating them, etc.)** 

In Python, you will have to think with a "programming" mindset. That means perceiving things in terms of logical statements and blocks, understanding data as 2D or 3D tables that you have to slice and recombine.

- **You are comfortable with maths**

In Python, numbers and numbers combinations are used a lot. Paradoxically, you will typically see a lot more of maths in Python than in R.

- **You plan to do signal processing or experimental tasks creation** 

These are some of the domains where Python is well-established (which doesn't mean that R doesn't have some great tools in development).

- **You are good at googling and don't mind spending time looking for the right answer**

Python has so much material online that it's sometimes hard to find the appropriate thing. Harder than in R, in my opinion.

### Reasons to choose R

- **You have no experience with programming whatsoever**

R is not made to be used as a traditional *programming* language. It's more of finding what functions to apply to what, and that makes it easy for beginners.

- **You are interested in statistical analyses, modelling things, and making inferences from data**

R excels at this. You can create powerful models super easily and jump into their understanding and interpretation.

- **You like making nice figures and plots**

R, through the [**ggplot**](https://ggplot2.tidyverse.org/index.html) ecosystem, has hands down the best tools for visualization. Your imagination is the limit (check-out the artworks by [Thomas Lin Pedersen](https://www.data-imaginist.com/art) abd [Danielle Navarro](https://art.djnavarro.net/) 😍).

- **You are *not* so good with stats or maths**

You heard it right! To start with R you don't need to know stats or maths like a boss. R, in fact, will help you to become proficient at it, by slowly opening more and more layers of complexity to you, if you are deemed worthy.

- **You are interested in joining the academic community**

Because most of its users are academics, R has a fantastic community online, for instance on [**Twitter \#rstats**](https://twitter.com/hashtag/rstats). 
  
### Other considerations

- **What your peers are learning**

It's easier to learn together, so try to discuss it with your class or lab mates if you can.

- **What your lab is using**

It might be easier if you have mentors that can understand what you are doing and guide you. But that should not be a priority, as it can lead to old habits reproduction (especially if your lab has a tradition of Matlab 🤭).

## Hands on!

👉 Looking for places to start? Check out this [**10-min crash course introduction to Python**](https://neurokit2.readthedocs.io/en/latest/tutorials/learnpython.html) and this [**collection of resources for R**](https://easystats.github.io/blog/resources/).


---

*Thanks for reading!* 🐦 *Don't forget to join me on Twitter* ([@Dom_Makowski](https://twitter.com/Dom_Makowski)) *and leave a comment below* 👇


