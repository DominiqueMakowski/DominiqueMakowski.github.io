---
authors:
- Anshu-Te
categories:
- Neuropsychology
- Perception
- Reality
- Reproducibility
date: "2021-11-30T00:00:00Z"
draft: false
featured: false
image:
  caption: ''
  placement: 0
title: "Pyllusion has been published!"
subtitle: 'Pyllusion, the software for creating illusions in Python, has been published.'
summary: 'Pyllusion, the software for creating illusions in Python, has been published.'
tags:
- Python
- Psychology
- Neuroscience
- Perception
- Reality
- Illusion
- Delboeuf
- Müller-Lyer
- Pyllusion
---

## Pyllusion has been published!

[Pyllusion](https://github.com/RealityBending/Pyllusion) is a package for **Python** that implements a systematic way to manipulate and generate illusions using a set of parameters.

For instance, the famous [Müller-Lyer](https://en.wikipedia.org/wiki/M%C3%BCller-Lyer_illusion) illusion below, which causes the observer to perceive the 2 segments of being different lengths depending on the shape of the arrows, can be generated wit the following lines of code:

```python
mullerlyer = pyllusion.MullerLyer(illusion_strength=30)
mullerlyer.to_image()
```

![](https://github.com/RealityBending/Pyllusion/blob/master/docs/img/README_mullerlyer1.png?raw=true)


To understand more about the parametric approach being implemented in the *Pyllusion* package, we recommend reading our [paper](https://dominiquemakowski.github.io/publication/makowski2021parametric/makowski2021parametric.pdf), which includes a hands-on example on how to generate some classic illusions (such as the [Delbeouf Illusion](https://en.wikipedia.org/wiki/Delboeuf_illusion)), and discusses how *Pyllusion* contributes to address conceptual and methodological issues in illusion science.

```python
import pyllusion

delboeuf = pyllusion.Delboeuf(illusion_strength=3)
delboeuf.to_image()
```

![](https://github.com/RealityBending/Pyllusion/blob/master/docs/img/README_delboeuf1.png?raw=true)

Don't forget to keep a look out for our [repo](https://github.com/RealityBending/) for more exciting open-source projects!
