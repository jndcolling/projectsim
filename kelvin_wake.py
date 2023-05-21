import numpy as np
import scipy.integrate as integrate
import matplotlib.pyplot as plt
from matplotlib import cm

x_list = np.linspace(0, 10, 10)
y_list = np.linspace(0, 10, 10)
z_list = np.zeros(100)


l = 0.5   # wavelength
K = 2 * np.pi / l
P = np.exp(-K**2 / (4 * np.pi ** 2))
Fr = 0.5

count = 0
for x in x_list:
    for y in y_list:
        def integrand(theta):
            return (1j * P * np.pi * np.exp(-1j*(np.cos(theta)*x - np.sin(theta)*y) / ((Fr * np.cos(theta))**2)))\
                   / ((Fr * np.cos(theta))**4)
        z = integrate.quad(integrand, np.pi / -2, np.pi / 2)
        np.put(z_list, count, z)
        count += 1
X, Y = np.meshgrid(x_list, y_list)
z_list = np.reshape(z_list, (10, 10))
fig, ax = plt.subplots(subplot_kw={"projection": "3d"})
ax.plot_surface(X, Y, z_list, vmin=z_list.min() * 2, cmap=cm.Blues)

ax.set(xticklabels=[],
       yticklabels=[],
       zticklabels=[])

plt.show()
