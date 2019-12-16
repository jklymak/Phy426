# just pot the foil
import numpy as np
import matplotlib.pylab as plt
#%matplotlib notebook
#import ipywidgets as widgets
#import IPython.display as display


def getdata(offset):
    b = 1.2
    a = 1.

    #offset = 0

    th = np.arange(0, 2.*np.pi, 0.02)

    zeta = a * np.exp(1j*th) + offset
    z = zeta + b**2 * np.conj(zeta)/ zeta / np.conj(zeta)

    return zeta, z

offset = 0.0
zeta, z = getdata(0. )

fig, axs = plt.subplots(2, 1) #, sharex = True, sharey=True)
zeta_, = axs[0].plot(np.real(zeta), np.imag(zeta))
center, = axs[0].plot(np.real(offset), np.imag(offset), 'b.', picker=10)

axs[0].set_aspect(1.)
axs[0].grid('on')

z_, = axs[1].plot(np.real(z), np.imag(z))
axs[1].set_aspect(1.)
axs[1].grid('on')

for ax in [axs[1]]:
    ax.set_ylim([-2, 2])
    ax.set_xlim([-4, 4])

_dragging = False

def onpick(event):
    global _dragging
    thispoint = event.artist
    if thispoint == center:
        print('HIT')
        _dragging = True
        print('set',_dragging)

def on_motion(event):
    global _dragging
    # print('motion', _dragging)
    if _dragging:
        print('Dragging!')
        offset = event.xdata + event.ydata*1j
        zeta, z = getdata(offset)
        zeta_.set_xdata(np.real(zeta))
        zeta_.set_ydata(np.imag(zeta))
        z_.set_xdata(np.real(z))
        z_.set_ydata(np.imag(z))
        center.set_xdata(np.real(offset))
        center.set_ydata(np.imag(offset))
        fig.canvas.draw()

def on_release(event):
    global _dragging
    print('release', _dragging)
    _dragging = False

fig.canvas.mpl_connect('pick_event', onpick)
fig.canvas.mpl_connect('motion_notify_event', on_motion)
fig.canvas.mpl_connect('button_release_event', on_release)

plt.show()
