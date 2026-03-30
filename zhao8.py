import numpy as np
a=np.arange(10).reshape(2,5)
print(a)
print(a[1][2])
print(a[1,:])
print(a.T)
for i in a.T:
    print(i)

b=np.arange(9).reshape(3,3)
print(b)
print(b.flatten())
for i in b.flatten():
    print(i)

d=np.array([[1,2,3],[4,5,6],[7,8,9]])
c=np.vstack((d,b))#垂直
e=np.hstack((d,b))#水平
print(c.shape,e.shape)

x=np.array([1,2,3])[:,np.newaxis]
print(x.shape)
y=np.array([4,5,6])[:,np.newaxis]
print(y)
x1=np.hstack((x,y))
print(x1)
print(np.concatenate((x,y),axis=0))#上下
print(np.concatenate((x,y),axis=1))#左右