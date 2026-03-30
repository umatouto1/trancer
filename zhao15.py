import numpy as np
import pandas as pd
from sympy import *
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
# plt.plot([1,2,3],[4,5,6],'ro')#标红点
# plt.plot([1,2,3],[4,5,6])#连点折线

# df=pd.DataFrame(np.random.randn(1000,4),index=np.arange(1000),columns=['a','b','c','d'])
# df=df.cumsum()
# df.iloc[:50].plot.bar(width=1)

##二维等高线图
x=np.linspace(0,10,100)
y=np.linspace(0,10,100)
x,y = np.meshgrid(x,y)
def z_func(x,y):#定义2函数
    v=x+y
    u=x*y
    return np.exp(u)*np.sin(v)
fig=plt.figure(figsize=(8,6))
# contour=plt.contourf(x,y,z_func(x,y),levels=20,cmap='viridis')#将函数值相同的点相连 contourf用相同颜色填充
# plt.colorbar(contour)#可视化颜色标尺 由levels决定contour等高线数量 决定contourf颜色数量
# plt.xlabel('x')
# plt.ylabel('y')
# plt.title('contour plot of e^(xy)*sin(x+y)')

##三维曲面图
ax=fig.add_subplot(111,projection='3d')#fig.add_subplot(1,1,1)画布的第一行第一列第一张
ax.plot_surface(x,y,z_func(x,y),cmap='viridis',edgecolor='none')#去除网格线 ‘white’ ‘black’
ax.set_xlabel('x')                   #红绿蓝渐变风格
ax.set_ylabel('y')
ax.set_zlabel('z')
ax.set_title('3D plot of e^(xy)*sin(x+y)')
plt.show()