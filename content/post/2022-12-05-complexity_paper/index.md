---
authors:
- Stephanie-Kirk
categories:
- Complexity Science
- EEG
- Psychology
- Neurokit2
- Neurophysiology
date: "2022-12-05"
draft: false
featured: false
image:
  caption: ''
  placement: 0
title: "About signal complexity"
subtitle: 'We recently did a bit of groundwork to better understand how to use signal complexity in neurophysiology.'
summary: 'We recently did a bit of groundwork to better understand how to use signal complexity in neurophysiology.'
tags:
- NeuroKit2
- Python
- Complexity Science
- Nonlinear Dynamics
- Fractal
- Neurophysiology
- Psychology
---

The signals recorded from the brain or the body are rich in information, and there are many ways to analyze them. For instance, for EEG, one can focus on **Event Related Potentials** (ERP), time-frequency analyses, [**microstates**](https://neuropsychology.github.io/NeuroKit/examples/eeg_microstates/eeg_microstates.html), etc.

An alternative framework, used to characterize the general characteristics of the signal, relies on the extraction of indices of **"complexity"** (a general term for constructs such as entropy, chaos, fractal dimension, predictability). However, that field is quite *complex* (no pun intended), drawing heavily onto mathematical concepts that psychologists or neuroscientists might not be familiar with.

In order to better understand the world of complexity indices as applied to neurophysiology, we have done some groundwork to help us make better decisions in our future usage of this type of analysis.

- A [**gentle introduction**](https://onlinelibrary.wiley.com/doi/10.1111/ejn.15800) to complexity indices applied to neuroscience.
- A [**indices selection guide**](https://www.mdpi.com/1099-4300/24/8/1036) in which we compare how different indices relate to one another.

Additionally, we also provide an easy way to compute them in Python in our **NeuroKit** package (see [**here**](https://neuropsychology.github.io/NeuroKit/functions/complexity.html) for the list of functions and [**here**](https://neuropsychology.github.io/NeuroKit/examples/eeg_complexity/eeg_complexity.html) for an EEG application).

