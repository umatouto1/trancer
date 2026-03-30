import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

##df.plot()
##plt.show()
# df=pd.Series(np.random.randn(1000),index=np.arange(1000))
# f=df.cumsum()
# f.plot()
# plt.show() 一个函数

df=pd.DataFrame(np.random.randn(1000,4),index=np.arange(1000),columns=['a','b','c','d'])
# print(df)
df=df.cumsum()
# df.plot()
# plt.show() columns个函数

## plot methods
# scatter pie bar...
#df.plot.kde()
df.plot.scatter(x='a',y='b',color='Darkgreen',label='data')
#df.plot.scatter(x='a',y='c')#分散点
plt.show()
