import matplotlib.pyplot as plt
import numpy as np

##线性图 figure
plt.figure(figsize=(10,10))
x=np.linspace(-10,10,100)
y1=2*x+1
y2=x**2
# plt.figure(num=1,figsize=(10,10))
F1=plt.plot(x,y1,color='red',linewidth=1.0,linestyle='--',label='up')
# plt.figure(num=2,figsize=(10,10))
# plt.plot(x,y1,color='red',linewidth=1.0,linestyle='--')
# plt.plot(x,y2)
# plt.xlabel('i am x')
# plt.ylabel('i am y')
# plt.show()

# new_ticks=np.linspace(-10,10,20)
# plt.plot(x,y1)
F2=plt.plot(x,y2,label='down')
plt.xlabel('x')
plt.ylabel('y')
# plt.xticks(new_ticks)
# plt.yticks([-9,1,11],[r'$bad$',r'$normal\ \alpha$',r'$good$'])
# plt.show()

##gca
# ax=plt.gca()
# ax.spines['top'].set_color('none')
# ax.spines['right'].set_color('none')
# ax.xaxis.set_ticks_position('bottom')
# ax.yaxis.set_ticks_position('left')
# ax.spines['bottom'].set_position(('data',0))
# ax.spines['left'].set_position(('data',0))
# plt.show()

##legend
plt.legend(loc='best')
plt.show()