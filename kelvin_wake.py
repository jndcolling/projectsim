import numpy as np
import scipy.integrate as integrate

x_list = np.linspace(0, 10, 10)
y_list = np.linspace(0, 10, 10)
z_list = []
l = 0.5   # wavelength
K = 2 * np.pi / l
P = np.exp(-K**2 / (4 * np.pi ** 2))
Fr = 0.5

for x in x_list:
    for y in y_list:
        def integrand(theta):
            return (1j * np.pi * np.exp(-1j*(np.cos(theta)*x - np.sin(theta)*y) / ((Fr * np.cos(theta))**2)))\
                   / ((Fr * np.cos(theta))**4)
        z = integrate.quad(integrand, np.pi / -2, np.pi / 2)
        z_list += z
        print(z_list)
print(z_list)
