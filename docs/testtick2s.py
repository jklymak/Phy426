import matplotlib.pyplot as plt

ax = plt.subplot()
ax.tick_params(labelleft=False, labelright=True,
                   which='major')
ax.tick_params(labelleft=False, labelright=True,
                   which='minor')
plt.show()
