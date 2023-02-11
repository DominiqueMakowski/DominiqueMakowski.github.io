import matplotlib.pyplot as plt
import neurokit2 as nk

signal = nk.signal_simulate(duration=2, sampling_rate=200, frequency=[5, 6], noise=0.5)
nk.complexity_mfdfa(signal, show=True)

fig = plt.gcf()
fig.set_size_inches(10, 8, forward=True)
fig.savefig("featured.png", dpi=300, facecolor="w")


import neurokit2 as nk

signal = nk.signal_simulate(frequency=[5, 6], noise=0.5)

results, info = nk.complexity(signal, which="fast")
results


