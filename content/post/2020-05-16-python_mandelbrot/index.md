---
authors:
- Dominique Makowski
categories:
- Python
- NeuroKit
date: "2020-05-16T00:00:00Z"
draft: false
featured: false
image:
  caption: 'A Mandelbrot fractal made with Python using NeuroKit'
  placement: 0
subtitle: 'Create a Mandelbrot or Buddhabrot fractal in Python using NeuroKit.'
summary: Create a Mandelbrot or Buddhabrot fractal in Python using NeuroKit.
tags:
- Python
- Fractal
- Mandelbrot
- Buddhabrot
- NeuroKit
title: 'One Python code line for a Mandelbrot fractal'
---

## Mandelbrot Set

I wrote a small Python function to easily generate and plot a [Mandelbrot set](https://en.wikipedia.org/wiki/Mandelbrot_set). This function is now available through the [**NeuroKit2 package**](https://github.com/neuropsychology/NeuroKit#quick-example), and can be used as follows:

```python
import neurokit2 as nk

nk.fractal_mandelbrot(show=True)
```



The Mandelbrot set is defined in the between `-2` and `2` on the *x* (real) and *y* (imaginary) axes. Following that, the image can be cropped accodingly by changing the coordinates. Moreover, the colors can be tweaked by changing the the colormap (`cmap`).

```python
m = nk.fractal_mandelbrot(real_range=(-2, 0.75), imaginary_range=(-1.25, 1.25))
plt.imshow(m.T, cmap="viridis")
plt.axis("off")
plt.show()
```
## Buddhabrot Set

It is also possible to generate a [**Buddhabrot**](https://en.wikipedia.org/wiki/Buddhabrot):

```python
b = nk.fractal_mandelbrot(size=1500,
                          real_range=(-2, 0.75), imaginary_range=(-1.25, 1.25),
                          buddha=True, iterations=200)
plt.imshow(b.T, cmap="gray")
plt.axis("off")
plt.show()
```

{{< tweet user="Dom_Makowski" id="1258376273451053056" >}}



Althoug the NeuroKit Python package is primarily devoted at physiological signal processing, in also includes tons of other useful features.


👉 [**Discover more about NeuroKit here**](https://github.com/neuropsychology/NeuroKit#quick-example) 👈


Have fun!

---

*Thanks for reading! Do not hesitate to tweet and share this post, and leave a comment below* :hugs:

🐦 *Don't forget to join me on Twitter* [@Dom_Makowski](https://twitter.com/Dom_Makowski)
