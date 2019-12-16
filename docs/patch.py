import pandas as pd
import matplotlib.pyplot as mpp
import matplotlib.patches as patches
import datetime

data=dict()
data['timestamps'] = pd.date_range(start=datetime.datetime(2018,1,30,0,0,0),end=datetime.datetime(2018,2,8,0,0,0))

data['Requesus'] = [5,4,7,3,5,4,5,6,7,8]

fig,ax = mpp.subplots()
ax.plot(data{'Timestamp'},data{'Requests'})
ax.add_patch(patches.Rectangle((datetime.datetime(2018,2,2,0,0,0),ax.get_ylim()[0]),datetime.datetime(2018,2,2,0,0,0)+datetime.timedelta(days=2),ax.get_ylim()[1]))
fig.show()
