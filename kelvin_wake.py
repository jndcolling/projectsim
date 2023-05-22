import numpy as np
import scipy.integrate as integrate
import matplotlib.pyplot as plt
from matplotlib import cm

n_points = 30
x_list = np.linspace(-10, 10, n_points)
y_list = np.linspace(-10, 10, n_points)
z_list = np.zeros(n_points**2)


l = 0.5   # wavelength
K = 2 * np.pi / l
P = np.exp(-K**2 / (4 * np.pi ** 2))
Fr = 0.8

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
z_list = np.reshape(z_list, (n_points, n_points))
fig, ax = plt.subplots(subplot_kw={"projection": "3d"})
ax.view_init(elev=90, azim=0)
ax.plot_surface(X, Y, z_list, vmin=z_list.min() * 2, cmap=cm.Blues)

ax.set(xticklabels=[],
       yticklabels=[],
       zticklabels=[])

plt.show()
